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
            checksum: "df3597bbe4f4eed0f143a60100f0e328ae0175e0fde71b1ad250dc7e757ddca0"
        )
    ]
)
