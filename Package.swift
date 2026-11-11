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
            url: "https://github.com/JTh0mps0n/opencv-ios-spm/releases/download/4.12.0-3/opencv2.xcframework.zip",
            checksum: "bcbed05a6d89005db2e9dfee04d1b3efea5d822898ed95424f4eef9c317af005"
        )
    ]
)
