// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.


import PackageDescription

let package = Package(
    name: "CustomVideoPlayerSdk",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "CustomVideoPlayerSdk",
            targets: ["CustomVideoPlayer"]
        )
    ],
    targets: [
        .binaryTarget(
            name: "CustomVideoPlayer",
            path: "XCFramework/CustomVideoPlayer.xcframework"
        )
    ]
)
