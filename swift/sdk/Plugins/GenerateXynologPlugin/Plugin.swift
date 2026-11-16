import Foundation
import PackagePlugin

@main
struct GenerateXynologPlugin: BuildToolPlugin {
  func createBuildCommands(context: PluginContext, target: any Target) throws -> [Command] {
    let specs = context.package.directoryURL.appendingPathComponent("../../../protocol/specs/src")
      .standardizedFileURL
    guard let files = FileManager.default.enumerator(at: specs, includingPropertiesForKeys: nil)
    else {
      throw PluginFailure.missingSpec
    }
    let required = context.package.directoryURL.appendingPathComponent(
      "Sources/XynologCodegen/required-schemas.json")
    var inputs: [URL] = [required]
    for case let file as URL in files where file.pathExtension == "json" { inputs.append(file) }
    let mode: String
    switch target.name {
    case "Xynolog": mode = "models"
    case "XynologTests": mode = "tests"
    default: throw PluginFailure.unsupportedTarget
    }
    let output = context.pluginWorkDirectoryURL.appendingPathComponent("Models.swift")
    return [
      .buildCommand(
        displayName: "Generate Xynolog models from protocol/specs/src",
        executable: try context.tool(named: "GenerateXynolog").url,
        arguments: [specs.path, required.path, output.path, mode],
        environment: [
          "LLVM_PROFILE_FILE": context.pluginWorkDirectoryURL.appendingPathComponent(
            "generator-%m-%p.profraw"
          ).path
        ],
        inputFiles: inputs.sorted { $0.path < $1.path }, outputFiles: [output]
      )
    ]
  }
}
enum PluginFailure: Error { case missingSpec, unsupportedTarget }
