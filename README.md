# opencv-ios-spm

An **unofficial** Swift Package that distributes a prebuilt `opencv2.xcframework` of [OpenCV](https://opencv.org) for iOS. It is not affiliated with or endorsed by the OpenCV project.

- OpenCV version: **4.12.0** (upstream tag `4.12.0`, commit `49486f61fb25722cbcf586b7f4320921d46fb38e`)
- Platforms: iOS device (`arm64`) and iOS Simulator (`arm64`, Apple silicon). No Intel simulator slice.
- Static framework, all default OpenCV modules, no `opencv_contrib`.
- Versions: a release tag is the OpenCV version plus a build revision, such as `4.12.0-1`. Tags are never moved; a rebuild gets the next revision.

## Use

In Xcode: File > Add Package Dependencies, enter `https://github.com/JTh0mps0n/opencv-ios-spm`, and add the `OpenCV` product to your target. Or in `Package.swift`:

```swift
.package(url: "https://github.com/JTh0mps0n/opencv-ios-spm", exact: "4.12.0-2")
```

Then `#import <opencv2/opencv2.h>` from Objective-C or a bridging header.

## How the binary was built

Built on macOS with Xcode 26.3 (17C529), CMake 3.28.1 and Python 3.14, from a shallow clone of the official source at the tag above:

```sh
git clone --depth 1 --branch 4.12.0 https://github.com/opencv/opencv.git src
python3 src/platforms/apple/build_xcframework.py -o out \
  --iphoneos_archs arm64 --iphonesimulator_archs arm64 --build_only_specified_archs
```

The script emits macOS-style "deep" frameworks (`Versions/A/...`), which iOS rejects: an iOS framework has `Info.plist` at its root. Its binaries are static archives inside a single-architecture fat wrapper, which the repackaging below thins to plain archives. The compiled code is otherwise unchanged. The package's `OpenCV` library product is declared `.static`, over a stub source target that depends on the binary, so Xcode links the archive directly. A product made of a binary target alone cannot be static, and Xcode would wrap it in an embedded dynamic framework that the iOS installer rejects.

```sh
for slice in ios-arm64 ios-arm64-simulator; do
  from="out/opencv2.xcframework/$slice/opencv2.framework/Versions/A"
  to="flat/$slice/opencv2.framework"
  mkdir -p "$to"
  cp -R "$from/Headers" "$from/Modules" "$to/"
  cp "$from/Resources/Info.plist" "$from/Resources/PrivacyInfo.xcprivacy" "$to/"
  lipo "$from/opencv2" -thin arm64 -output "$to/opencv2"
done
xcodebuild -create-xcframework \
  -framework flat/ios-arm64/opencv2.framework \
  -framework flat/ios-arm64-simulator/opencv2.framework \
  -output flat/opencv2.xcframework

ditto -c -k --keepParent flat/opencv2.xcframework opencv2.xcframework.zip
swift package compute-checksum opencv2.xcframework.zip
```

The checksum in `Package.swift` is the SwiftPM checksum of the release asset `opencv2.xcframework.zip`. SwiftPM refuses the download if the file ever differs.

## Licenses

OpenCV is licensed under Apache 2.0 (`LICENSE`). The framework statically includes zlib, libjpeg-turbo, libwebp, libpng, protobuf and flatbuffers, each under its own license; the texts are in `THIRD_PARTY_NOTICES.md`.
