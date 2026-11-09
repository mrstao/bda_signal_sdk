// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "BDASignalSDK",
    platforms: [.iOS(.v15)],
    products: [
        .library(name: "BDASignalSDK", targets: ["BDASignalSDK"])
    ],
    targets: [
        .binaryTarget(
            name: "BDASignalRequestLib",
            path: "lib/BDASignalRequestLib.xcframework"
        ),
        .target(
            name: "BDASignalSDKObjC",
            dependencies: ["BDASignalRequestLib"],
            path: "BDASignalSDK",
            exclude: ["BDASignalSDK.h", "Classes/BDASignalSwiftFile.swift"],
            sources: [
                "Classes/BDASignalDefinitions.m",
                "Classes/BDASignalManager.m",
                "Classes/Utilities/BDASignalUtility.m"
            ],
            publicHeadersPath: "Classes",
            cSettings: [
                .headerSearchPath("Classes"),
                .headerSearchPath("Classes/Utilities")
            ],
            linkerSettings: [
                .linkedFramework("UIKit"),
                .linkedFramework("Foundation"),
                .linkedFramework("StoreKit"),
                .linkedFramework("WebKit"),
                .linkedLibrary("sqlite3"),
                .unsafeFlags(["-ObjC"])
            ]
        ),
        .target(
            name: "BDASignalSDK",
            dependencies: ["BDASignalSDKObjC"],
            path: "Sources/BDASignalSDK",
            sources: ["Exports.swift"],
            resources: [.copy("../../Assets/PrivacyInfo.xcprivacy")]
        )
    ]
)
