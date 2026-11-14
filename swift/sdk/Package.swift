// swift-tools-version: 6.2
import PackageDescription

let package = Package(
  name: "Xynoplex",
  platforms: [.macOS(.v15), .iOS(.v18)],
  products: [
    .library(name: "Xynoplex", targets: ["Xynoplex"]),
    .library(name: "XynoplexTesting", targets: ["XynoplexTesting"]),
  ],
  dependencies: [
    .package(url: "https://github.com/apple/swift-crypto.git", from: "5.0.3"),
    .package(url: "https://github.com/apple/swift-nio.git", from: "2.104.0"),
    .package(url: "https://github.com/swift-server/async-http-client.git", from: "1.36.2"),
    .package(url: "https://github.com/open-telemetry/opentelemetry-swift-core.git", from: "2.6.0"),
    .package(url: "https://github.com/open-telemetry/opentelemetry-swift.git", from: "2.6.0"),
  ],
  targets: [
    .executableTarget(
      name: "XynoplexWireDriver",
      dependencies: [
        "Xynoplex",
        .product(name: "AsyncHTTPClient", package: "async-http-client"),
        .product(name: "OpenTelemetrySdk", package: "opentelemetry-swift-core"),
        .product(name: "OpenTelemetryProtocolExporterHTTP", package: "opentelemetry-swift"),
      ], path: "Conformance", exclude: ["launch.sh"], swiftSettings: [.treatAllWarnings(as: .error)]
    ),
    .target(
      name: "Xynoplex",
      dependencies: [
        .product(name: "Crypto", package: "swift-crypto"),
        .product(name: "CryptoExtras", package: "swift-crypto"),
        .product(name: "NIOCore", package: "swift-nio"),
        .product(name: "AsyncHTTPClient", package: "async-http-client"),
        .product(name: "OpenTelemetryApi", package: "opentelemetry-swift-core"),
      ], swiftSettings: [.treatAllWarnings(as: .error)],
      plugins: ["GenerateXynoplexPlugin"]),
    .executableTarget(
      name: "GenerateXynoplex", dependencies: ["XynoplexCodegen"],
      swiftSettings: [.treatAllWarnings(as: .error)]),
    .plugin(
      name: "GenerateXynoplexPlugin", capability: .buildTool(), dependencies: ["GenerateXynoplex"]),
    .target(
      name: "XynoplexTesting", dependencies: ["Xynoplex"],
      swiftSettings: [.treatAllWarnings(as: .error)]),
    .target(
      name: "XynoplexCodegen", exclude: ["required-schemas.json"],
      swiftSettings: [.treatAllWarnings(as: .error)]),
    .testTarget(
      name: "XynoplexTests",
      dependencies: [
        .product(name: "CryptoExtras", package: "swift-crypto"),
        "Xynoplex",
        "XynoplexTesting",
        .product(name: "AsyncHTTPClient", package: "async-http-client"),
        .product(name: "NIOPosix", package: "swift-nio"),
        .product(name: "NIOHTTP1", package: "swift-nio"),
        .product(name: "OpenTelemetrySdk", package: "opentelemetry-swift-core"),
      ],
      swiftSettings: [.treatAllWarnings(as: .error)], plugins: ["GenerateXynoplexPlugin"]),
    .testTarget(
      name: "XynoplexCodegenTests", dependencies: ["XynoplexCodegen"],
      swiftSettings: [.treatAllWarnings(as: .error)]),
  ],
  swiftLanguageModes: [.v6]
)
