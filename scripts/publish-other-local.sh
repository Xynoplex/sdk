#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd -P)"
source "$ROOT/build-tools/container-runtime.sh"
source "$ROOT/scripts/run-container-quietly.sh"
source "$ROOT/scripts/require-protocol-pin.sh"
RUNTIME="$(detect_container_runtime)"
STATE_ROOT="${XDG_CACHE_HOME:-$HOME/.cache}/xynoplex-sdk/local"
PROTOCOL="$ROOT/protocol"
LANGUAGE="${1:-all}"
case "$LANGUAGE" in
  all|go|csharp|haskell|kotlin|ocaml|swift) ;;
  *) echo "Unsupported language for this artifact script: $LANGUAGE" >&2; exit 2 ;;
esac
PROTOCOL_REVISION="$(require_protocol_pin "$ROOT")"
mkdir -p "$STATE_ROOT"/{go-proxy,nuget,nuget-cache,haskell,cabal-cache,haskell-build,kotlin-maven,gradle-cache,opam-repo,swift,swift-cache,swift-build,go-mod-cache,go-build-cache}
OPAM_VOLUME=xynoplex-sdk-opam-5-5
VERSION="$(sed -n 's/.*"version": "\([^"]*\)".*/\1/p' "$ROOT/version.json" | head -n1)"
SDK_SOURCE_TIME="$(git -C "$ROOT" log -1 --format=%cI)"

case "$LANGUAGE" in
  all|go|csharp|kotlin)
    [[ -d "$PROTOCOL/specs/src" ]] || exit 1
    ;;
esac

if [[ "$LANGUAGE" == all || "$LANGUAGE" == go ]]; then
echo 'Building the Go module proxy package in a Go container…'
# What a commit of this tree would hold of the module and what Go's packager
# reads beside it: go/, LICENSE and .gitattributes, tracked or new and not ignored.
GO_MODULE_SOURCE="$(mktemp -d)"
trap 'rm -rf "$GO_MODULE_SOURCE"' EXIT
git -C "$ROOT" ls-files -z --cached --others --exclude-standard -- go LICENSE .gitattributes \
  | while IFS= read -r -d '' path; do if [[ -e "$ROOT/$path" ]]; then printf '%s\0' "$path"; fi; done \
  | tar -C "$ROOT" --null -T - -cf - | tar -C "$GO_MODULE_SOURCE" -xf -
run_container_quietly "$RUNTIME" run --rm \
  --volume "$ROOT:/source:ro" --volume "$PROTOCOL:/protocol:ro" \
  --volume "$GO_MODULE_SOURCE:/module-source:ro" \
  --volume "$STATE_ROOT/go-proxy:/out" --volume "$STATE_ROOT/go-mod-cache:/go/pkg/mod" \
  --volume "$STATE_ROOT/go-build-cache:/root/.cache/go-build" \
  --env "SDK_SOURCE_TIME=$SDK_SOURCE_TIME" \
  --workdir /tmp golang:1.27.4-bookworm bash -euc '
    version=$(sed -n "s/.*\"version\": \"\([^\"]*\)\".*/\1/p" /source/version.json | head -n1)
    mkdir -p /tmp/sdk && cp -a /source/. /tmp/sdk/ && rm -rf /tmp/sdk/protocol && cp -a /protocol /tmp/sdk/protocol && cd /tmp/sdk/go && go build ./...
    module="github.com/Xynoplex/sdk/go"
    escaped="github.com/!xynoplex/sdk/go"
    mkdir -p "/out/$escaped/@v"
    printf "{\"Version\":\"v%s\",\"Time\":\"%s\"}\n" "$version" "$SDK_SOURCE_TIME" > "/out/$escaped/@v/v$version.info"
    cp /source/go/go.mod "/out/$escaped/@v/v$version.mod"
    printf "v%s\\n" "$version" > "/out/$escaped/@v/list"
    # Go packages a module from a commit: commit the staged tree in a scratch repository.
    cp -R /module-source /tmp/module-repository
    git -C /tmp/module-repository init -q
    git -C /tmp/module-repository add -A -f
    git -C /tmp/module-repository -c user.name=go-module-zip -c user.email=go-module-zip@localhost commit -q -m "go-module-zip"
    (cd /source/scripts/go-module-zip && go run . "$module" "v$version" /tmp/module-repository HEAD go "/out/$escaped/@v/v$version.zip")
  '
fi
if [[ "$LANGUAGE" == all || "$LANGUAGE" == csharp ]]; then
echo 'Packing the .NET SDK in a .NET container…'
dotnet_version="$(sed -n 's/.*"version": "\([^"]*\)".*/\1/p' "$ROOT/csharp/sdk/global.json" | sed -E 's/(-(preview|rc)\.[0-9]+)\.[0-9]+\.[0-9]+$/\1/')"
run_container_quietly "$RUNTIME" run --rm \
  --volume "$ROOT:/source:ro" --volume "$PROTOCOL:/protocol:ro" \
  --volume "$STATE_ROOT/nuget:/out" --volume "$STATE_ROOT/nuget-cache:/root/.nuget/packages" --workdir /tmp \
  "mcr.microsoft.com/dotnet/sdk:$dotnet_version" bash -euc '
    version=$(sed -n "s/.*\"version\": \"\([^\"]*\)\".*/\1/p" /source/version.json | head -n1)
    cp -a /source /tmp/sdk
    rm -rf /tmp/sdk/protocol
    cp -a /protocol /tmp/protocol
    dotnet pack /tmp/sdk/csharp/sdk/src/Xynoplex/Xynoplex.csproj -c Release --verbosity quiet \
      -p:IsPackable=true -p:PackageId=Xynoplex -p:PackageVersion="$version" \
      -p:CheckRefusals=false -o /out
  '
fi

if [[ "$LANGUAGE" == all || "$LANGUAGE" == haskell ]]; then
echo 'Creating the Haskell source distribution in a GHC container…'
run_container_quietly "$RUNTIME" run --rm --memory 4g --volume "$ROOT/haskell/sdk:/source:ro" \
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
run_container_quietly "$RUNTIME" run --rm --memory 4g --volume "$ROOT:/source:ro" \
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
if ! run_container_quietly "$RUNTIME" run --rm --volume "$OPAM_VOLUME:/cache" \
  ocaml/opam:debian-13-ocaml-5.5 bash -euc 'test -s /cache/config'; then
  echo 'Seeding the pinned OCaml switch cache…'
  run_container_quietly "$RUNTIME" run --rm --user 0:0 --volume "$OPAM_VOLUME:/cache" \
    ocaml/opam:debian-13-ocaml-5.5 bash -euc 'cp -R /home/opam/.opam/. /cache/ && chown -R opam:opam /cache'
fi
# The OCaml image runs as its opam user, who writes the repository here.
chmod 0777 "$STATE_ROOT/opam-repo"
run_container_quietly "$RUNTIME" run --rm --memory 4g --volume "$ROOT/ocaml/sdk:/source:ro" \
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
run_container_quietly "$RUNTIME" run --rm --memory 4g --volume "$ROOT/swift/sdk:/source:ro" --volume "$PROTOCOL:/protocol:ro" \
  --volume "$STATE_ROOT/swift:/out" --volume "$STATE_ROOT/swift-cache:/root/.cache" \
  --volume "$STATE_ROOT/swift-build:/build" --env "XYNOPLEX_SDK_VERSION=$VERSION" --workdir /tmp "swift:$swift_version" bash -euc '
    apt-get update -qq && apt-get install -y -qq --no-install-recommends zip >/dev/null
    mkdir -p /tmp/sdk/swift/sdk /tmp/protocol /tmp/archive/sdk/swift/sdk /tmp/archive/protocol
    cp -a /source/. /tmp/sdk/swift/sdk/
    cp -a /protocol/. /tmp/protocol/
    cd /tmp/sdk/swift/sdk
    if ! swift build --build-path /build --jobs 4 --force-resolved-versions --product Xynoplex > /out/build.log 2>&1; then tail -n 100 /out/build.log; exit 1; fi
    cp -a /source/. /tmp/archive/sdk/swift/sdk/
    cp -a /protocol/. /tmp/archive/protocol/
    cd /tmp/archive
    rm -f "/out/xynoplex-$XYNOPLEX_SDK_VERSION.zip"
    zip -qr "/out/xynoplex-$XYNOPLEX_SDK_VERSION.zip" sdk protocol
  '
fi
