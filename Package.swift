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
            url: "https://github.com/JTh0mps0n/opencv-ios-spm/releases/download/4.12.0-4/opencv2.xcframework.zip",
            checksum: "6397c799d5544e6c680e16c9f1f11b9cd1d8c1d29ba4a79124e58c3eda9740e0"
        )
    ]
)
