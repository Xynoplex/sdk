# Xynolog SDK for Swift

The Swift package of the Xynolog SDK. Each release of the SDK writes one
commit here and tags it with the Swift package's version; nothing here is
edited by hand. The SDK is developed in
[xynolog/sdk](https://github.com/xynolog/sdk), whose
[Swift README](https://github.com/xynolog/sdk/blob/main/swift/sdk/README.md)
describes its use.

Add the package to your `Package.swift` by this repository's URL, from the
version you want:

```swift
.package(url: "https://github.com/xynolog/sdk-swift.git", from: "<version>"),
```

and add `.product(name: "Xynolog", package: "sdk-swift")` to your target's
dependencies. `XynologTesting` holds the test doubles.

The wire models in `Sources/Xynolog/Generated` are generated from the
Protocol release the SDK release was built from.
