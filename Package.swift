// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "SilasLearnsChinese",
    platforms: [
        .iOS(.v14),
        .macOS(.v11)
    ],
    products: [
        .executable(
            name: "SilasLearnsChinese",
            targets: ["SilasLearnsChinese"]
        ),
    ],
    dependencies: [
        // Add any dependencies here if needed
    ],
    targets: [
        .executableTarget(
            name: "SilasLearnsChinese",
            dependencies: [],
            path: "SilasLearnsChinese",
            exclude: [
                "Assets.xcassets",
                "Preview Content",
                "Info.plist"
            ],
            sources: [
                "SilasLearnsChineseApp.swift",
                "ContentView.swift",
                "Models/Vocabulary.swift",
                "Models/Progress.swift", 
                "Models/Character.swift",
                "Services/AudioService.swift",
                "Views/LearningView.swift",
                "Views/ActivityView.swift",
                "ProgressView.swift"
            ]
        )
    ]
)
