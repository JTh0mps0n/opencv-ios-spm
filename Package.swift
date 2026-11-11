// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "opencv-ios-spm",
    platforms: [.iOS(.v17)],
    products: [
        .library(name: "OpenCV", type: .static, targets: ["OpenCV"])
    ],
    targets: [
        .target(name: "OpenCV", dependencies: ["opencv2"]),
        .binaryTarget(
            name: "opencv2",
            url: "https://github.com/JTh0mps0n/opencv-ios-spm/releases/download/4.12.0-2/opencv2.xcframework.zip",
            checksum: "68fe3adc02d20fef133cbfd340c19fd03d57fc0388c01d965f54954966584a83"
        )
    ]
)
