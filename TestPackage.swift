// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "SilasLearnsChineseTest",
    platforms: [
        .iOS(.v14),
        .macOS(.v11)
    ],
    products: [
        .executable(
            name: "SilasLearnsChineseTest",
            targets: ["SilasLearnsChineseTest"]
        ),
    ],
    targets: [
        .executableTarget(
            name: "SilasLearnsChineseTest",
            dependencies: [],
            path: "TestSources",
            sources: ["main.swift"]
        )
    ]
)
