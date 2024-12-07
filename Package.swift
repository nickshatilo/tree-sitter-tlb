// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "TreeSitterTlb",
    products: [
        .library(name: "TreeSitterTlb", targets: ["TreeSitterTlb"]),
    ],
    dependencies: [
        .package(url: "https://github.com/ChimeHQ/SwiftTreeSitter", from: "0.8.0"),
    ],
    targets: [
        .target(
            name: "TreeSitterTlb",
            dependencies: [],
            path: ".",
            sources: [
                "src/parser.c",
                // NOTE: if your language has an external scanner, add it here.
            ],
            resources: [
                .copy("queries")
            ],
            publicHeadersPath: "bindings/swift",
            cSettings: [.headerSearchPath("src")]
        ),
        .testTarget(
            name: "TreeSitterTlbTests",
            dependencies: [
                "SwiftTreeSitter",
                "TreeSitterTlb",
            ],
            path: "bindings/swift/TreeSitterTlbTests"
        )
    ],
    cLanguageStandard: .c11
)
