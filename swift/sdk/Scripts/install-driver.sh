#!/bin/sh
set -eu
swift build --jobs 4 --force-resolved-versions --enable-code-coverage --product XynoplexWireDriver
bin=$(swift build --force-resolved-versions --show-bin-path)
mkdir -p .build/conformance/bin .build/conformance/lib
cp "$bin/XynoplexWireDriver" .build/conformance/bin/
# The suite's Ubuntu runner supplies libc and curl; Swift's runtime travels with the driver.
ldd "$bin/XynoplexWireDriver" | awk '$2 == "=>" && $3 ~ /\/swift\// { print $3 }' > .build/driver-libraries
while IFS= read -r library; do cp "$library" .build/conformance/lib/; done < .build/driver-libraries
cp Conformance/launch.sh .build/conformance/xynoplex-swift-wire-driver
chmod +x .build/conformance/xynoplex-swift-wire-driver
