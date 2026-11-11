// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "opencv-ios-spm",
    platforms: [.iOS(.v17)],
    products: [
        .library(name: "opencv2", targets: ["opencv2"])
    ],
    targets: [
        .binaryTarget(
            name: "opencv2",
            url: "https://github.com/JTh0mps0n/opencv-ios-spm/releases/download/4.12.0/opencv2.xcframework.zip",
            checksum: "a9903452182ea8cbde8b3b14f65342aab5cfbfffef3460aeeab1c846f88124c6"
        )
    ]
)
