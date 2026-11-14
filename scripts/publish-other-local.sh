#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd -P)"
source "$ROOT/scripts/container-runtime.sh"
RUNTIME="$(detect_container_runtime)"
STATE_ROOT="${XDG_CACHE_HOME:-$HOME/.cache}/xynoplex-sdk/local"
PROTOCOL="$ROOT/../protocol"
[[ -d "$PROTOCOL/specs/src" ]] || PROTOCOL="$ROOT/protocol"
LANGUAGE="${1:-all}"
case "$LANGUAGE" in
  all|go|csharp|haskell|kotlin|ocaml|swift) ;;
  *) echo "Unsupported language for this artifact script: $LANGUAGE" >&2; exit 2 ;;
esac
mkdir -p "$STATE_ROOT"/{go-proxy,nuget,nuget-cache,haskell,cabal-cache,haskell-build,kotlin-maven,gradle-cache,opam-repo,swift,swift-cache,swift-build,go-mod-cache,go-build-cache}
OPAM_VOLUME=xynoplex-sdk-opam-5-5
VERSION="$(sed -n 's/.*"version": "\([^"]*\)".*/\1/p' "$ROOT/version.json" | head -n1)"

case "$LANGUAGE" in
  all|go|csharp|kotlin)
    if [[ ! -d "$PROTOCOL/specs/src" ]]; then
  echo "Protocol schemas were not found at $PROTOCOL/specs/src." >&2
  echo 'Initialize the pinned protocol submodule before publishing.' >&2
  exit 1
    fi
    ;;
esac

if [[ "$LANGUAGE" == all || "$LANGUAGE" == go ]]; then
echo 'Building the Go module proxy package in a Go container…'
"$RUNTIME" run --rm \
  --volume "$ROOT:/source:ro" --volume "$PROTOCOL:/protocol:ro" \
  --volume "$STATE_ROOT/go-proxy:/out" --volume "$STATE_ROOT/go-mod-cache:/go/pkg/mod" \
  --volume "$STATE_ROOT/go-build-cache:/root/.cache/go-build" \
  --workdir /tmp golang:1.27.4-bookworm bash -euc '
    apt-get update -qq && apt-get install -y -qq --no-install-recommends zip >/dev/null
    version=$(sed -n "s/.*\"version\": \"\([^\"]*\)\".*/\1/p" /source/version.json | head -n1)
    mkdir -p /tmp/sdk && cp -a /source/. /tmp/sdk/ && rm -rf /tmp/sdk/protocol && cp -a /protocol /tmp/sdk/protocol && cd /tmp/sdk/go && go build ./...
    module="github.com/!xynoplex/sdk/go"
    escaped="$module"
    mkdir -p "/out/$escaped/@v" /tmp/go-proxy-package
    printf "{\"Version\":\"v%s\",\"Time\":\"%s\"}\n" "$version" "$(date -u +%Y-%m-%dT%H:%M:%SZ)" > "/out/$escaped/@v/v$version.info"
    cp /source/go/go.mod "/out/$escaped/@v/v$version.mod"
    printf "v%s\\n" "$version" > "/out/$escaped/@v/list"
    mkdir -p "/tmp/go-proxy-package/$module@v$version"
    cp -a /tmp/sdk/go/. "/tmp/go-proxy-package/$module@v$version/"
    rm -f "/tmp/go-proxy-package/$module@v$version/go.sum"
    (cd /tmp/go-proxy-package && zip -qr "/out/$escaped/@v/v$version.zip" .)
  '
fi

if [[ "$LANGUAGE" == all || "$LANGUAGE" == csharp ]]; then
echo 'Packing the .NET SDK in a .NET container…'
dotnet_version="$(sed -n 's/.*"version": "\([^"]*\)".*/\1/p' "$ROOT/csharp/sdk/global.json" | sed -E 's/(-(preview|rc)\.[0-9]+)\.[0-9]+\.[0-9]+$/\1/')"
"$RUNTIME" run --rm \
  --volume "$ROOT:/source:ro" --volume "$PROTOCOL:/protocol:ro" \
  --volume "$STATE_ROOT/nuget:/out" --volume "$STATE_ROOT/nuget-cache:/root/.nuget/packages" --workdir /tmp \
  "mcr.microsoft.com/dotnet/sdk:$dotnet_version" bash -euc '
    version=$(sed -n "s/.*\"version\": \"\([^\"]*\)\".*/\1/p" /source/version.json | head -n1)
    cp -a /source /tmp/sdk
    rm -rf /tmp/sdk/protocol
    cp -a /protocol /tmp/protocol
    dotnet pack /tmp/sdk/csharp/sdk/src/Xynoplex/Xynoplex.csproj -c Release \
      -p:IsPackable=true -p:PackageId=Xynoplex -p:PackageVersion="$version" \
      -p:CheckRefusals=false -o /out
  '
fi

if [[ "$LANGUAGE" == all || "$LANGUAGE" == haskell ]]; then
echo 'Creating the Haskell source distribution in a GHC container…'
"$RUNTIME" run --rm --memory 4g --volume "$ROOT/haskell/sdk:/source:ro" \
  --volume "$STATE_ROOT/haskell:/out" --volume "$STATE_ROOT/cabal-cache:/root/.cabal" \
  --volume "$STATE_ROOT/haskell-build:/tmp/sdk/dist-newstyle" --workdir /tmp \
  haskell:9.10.3 bash -euc 'mkdir -p /tmp/sdk && cp -a /source/. /tmp/sdk/ && cd /tmp/sdk && printf "packages: .\\n" > cabal.project && test -f /root/.cabal/packages/hackage.haskell.org/01-index.cache || cabal update; cabal build lib:xynoplex && cabal sdist --output-directory=/out'
fi

if [[ "$LANGUAGE" == all || "$LANGUAGE" == kotlin ]]; then
# Gradle's standard Maven publication is injected only for this local publish;
# the SDK build itself stays unchanged and its locked dependencies stay intact.
echo 'Building and publishing the Kotlin SDK to a local Maven repository in a JDK container…'
jdk="$(cat "$ROOT/kotlin/sdk/.java-version")"
cat > "$STATE_ROOT/kotlin-publish.init.gradle" <<'GRADLE'
allprojects {
  plugins.withId('org.jetbrains.kotlin.jvm') {
    afterEvaluate {
      apply plugin: 'maven-publish'
      publishing {
        publications {
          mavenJava(MavenPublication) {
            from components.java
            groupId = 'org.xynoplex'
            artifactId = 'xynoplex'
            version = System.getenv('XYNOPLEX_SDK_VERSION')
          }
        }
        repositories { maven { name = 'xynoplexLocal'; url = uri('/out') } }
      }
    }
  }
}
GRADLE
"$RUNTIME" run --rm --memory 4g --volume "$ROOT:/source:ro" \
  --volume "$PROTOCOL:/protocol:ro" --volume "$STATE_ROOT/kotlin-maven:/out" \
  --volume "$STATE_ROOT/gradle-cache:/root/.gradle" \
  --volume "$STATE_ROOT/kotlin-publish.init.gradle:/tmp/publish.init.gradle:ro" \
  --workdir /tmp eclipse-temurin:"$jdk"-jdk bash -euc '
    mkdir -p /tmp/sdk && cp -a /source/. /tmp/sdk/ && rm -rf /tmp/sdk/protocol && cp -a /protocol /tmp/protocol
    export XYNOPLEX_SDK_VERSION="$(sed -n "s/.*\"version\": \"\([^\"]*\)\".*/\1/p" /source/version.json | head -n1)"
    cd /tmp/sdk/kotlin/sdk
    ./gradlew --no-daemon -I /tmp/publish.init.gradle assemble -x checkKotlinAbi publishMavenJavaPublicationToXynoplexLocalRepository
  '
fi

if [[ "$LANGUAGE" == all || "$LANGUAGE" == ocaml ]]; then
echo 'Building and archiving the OCaml SDK in an OCaml container…'
opam_archive_uri="file://$STATE_ROOT/opam-repo/repo/archives/xynoplex.$VERSION.tar.gz"
opam_archive_uri="${opam_archive_uri// /%20}"
if ! "$RUNTIME" volume inspect "$OPAM_VOLUME" >/dev/null 2>&1; then
  "$RUNTIME" volume create "$OPAM_VOLUME" >/dev/null
fi
if ! "$RUNTIME" run --rm --volume "$OPAM_VOLUME:/cache" \
  ocaml/opam:debian-13-ocaml-5.5 bash -euc 'test -s /cache/config'; then
  echo 'Seeding the pinned OCaml switch cache…'
  "$RUNTIME" run --rm --volume "$OPAM_VOLUME:/cache" \
    ocaml/opam:debian-13-ocaml-5.5 bash -euc 'cp -R /home/opam/.opam/. /cache/'
fi
"$RUNTIME" run --rm --memory 4g --volume "$ROOT/ocaml/sdk:/source:ro" \
  --volume "$STATE_ROOT/opam-repo:/out" \
  --volume "$OPAM_VOLUME:/home/opam/.opam" \
  --env "XYNOPLEX_SDK_VERSION=$VERSION" --env "XYNOPLEX_OPAM_ARCHIVE_URI=$opam_archive_uri" \
  --workdir /tmp \
  ocaml/opam:debian-13-ocaml-5.5 bash -euc '
    sudo apt-get update -qq && sudo apt-get install -y -qq --no-install-recommends libgmp-dev pkg-config >/dev/null
    cp -a /source /tmp/sdk && cd /tmp/sdk
    rm -rf /home/opam/.opam/5.5/.opam-switch/sources/uring.2.15.0
    OPAMJOBS=1 opam install . --deps-only -y
    eval "$(opam env)"
    dune build -p xynoplex @install
    version="$XYNOPLEX_SDK_VERSION"
    rm -rf /out/repo && mkdir -p "/out/repo/packages/xynoplex/xynoplex.$version" "/out/repo/archives"
    cp xynoplex.opam "/out/repo/packages/xynoplex/xynoplex.$version/opam"
    tar --exclude=.git --exclude=_build -czf "/out/repo/archives/xynoplex.$version.tar.gz" .
    checksum=$(sha256sum "/out/repo/archives/xynoplex.$version.tar.gz" | cut -d" " -f1)
    printf "\nurl {\n  src: \"%s\"\n  checksum: [ \"sha256=%s\" ]\n}\n" \
      "$XYNOPLEX_OPAM_ARCHIVE_URI" "$checksum" >> "/out/repo/packages/xynoplex/xynoplex.$version/opam"
    printf "opam-version: \"2.0\"\n" > /out/repo/repo
    cd /out/repo && opam admin index
  '
fi

if [[ "$LANGUAGE" == all || "$LANGUAGE" == swift ]]; then
echo 'Building and archiving the Swift package in a Swift container…'
swift_version="$(cat "$ROOT/swift/sdk/.swift-version")"
"$RUNTIME" run --rm --memory 4g --volume "$ROOT/swift/sdk:/source:ro" --volume "$PROTOCOL:/protocol:ro" \
  --volume "$STATE_ROOT/swift:/out" --volume "$STATE_ROOT/swift-cache:/root/.cache" \
  --volume "$STATE_ROOT/swift-build:/build" --env "XYNOPLEX_SDK_VERSION=$VERSION" --workdir /tmp "swift:$swift_version" bash -euc '
    apt-get update -qq && apt-get install -y -qq --no-install-recommends zip >/dev/null
    mkdir -p /tmp/sdk /tmp/archive/sdk && cp -a /source/. /tmp/sdk/ && cd /tmp/sdk
    find .build -depth -delete 2>/dev/null || true
    if ! swift build --build-path /build --jobs 4 --force-resolved-versions --product Xynoplex > /out/build.log 2>&1; then tail -n 100 /out/build.log; exit 1; fi
    cp -a /source/. /tmp/archive/sdk/
    cd /tmp/archive
    rm -f "/out/xynoplex-$XYNOPLEX_SDK_VERSION.zip"
    zip -qr "/out/xynoplex-$XYNOPLEX_SDK_VERSION.zip" sdk -x "sdk/.build/" "sdk/.build/*"
  '
fi

if [[ "$LANGUAGE" == all ]]; then
cat <<EOF

Additional local SDK artifacts are ready under:
  Go module proxy: $STATE_ROOT/go-proxy (set GOPROXY=file://$STATE_ROOT/go-proxy)
  NuGet feed:      $STATE_ROOT/nuget (add as a local folder source)
  Haskell sdist:   $STATE_ROOT/haskell
  Maven repo:      $STATE_ROOT/kotlin-maven
  opam repo:       $STATE_ROOT/opam-repo/repo
  Swift archive:   $STATE_ROOT/swift

EOF
else
  case "$LANGUAGE" in
    go) echo "Go module proxy artifacts are ready under: $STATE_ROOT/go-proxy" ;;
    csharp) echo "NuGet package artifacts are ready under: $STATE_ROOT/nuget" ;;
    haskell) echo "Haskell source distribution is ready under: $STATE_ROOT/haskell" ;;
    kotlin) echo "Kotlin Maven artifacts are ready under: $STATE_ROOT/kotlin-maven" ;;
    ocaml) echo "OCaml package repository is ready under: $STATE_ROOT/opam-repo/repo" ;;
    swift) echo "Swift package archive is ready under: $STATE_ROOT/swift" ;;
  esac
fi
