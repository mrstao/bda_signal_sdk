# BDASignalSDK (SPM)

Ocean Engine BDASignalSDK 的 Swift Package Manager 适配仓库。官方 Objective-C 实现、XCFramework 和隐私清单均保留；此 Fork 增加 SwiftPM 包描述及自动同步工作流。

## Requirements

- Xcode 15+
- iOS 15+
- Swift 5.9+

## Swift Package Manager

在 Xcode 中选择 **File → Add Package Dependencies**，输入：

```text
https://github.com/mrstao/bda_signal_sdk.git
```

选择产品 **BDASignalSDK**。

也可以在 Package.swift 中声明：

```swift
.package(url: "https://github.com/mrstao/bda_signal_sdk.git", from: "2.0.0")
```

Objective-C：

```objc
#import <BDASignalSDK/BDASignalManager.h>
#import <BDASignalSDK/BDASignalDefinitions.h>
```

Swift：

```swift
import BDASignalSDK

BDASignalManager.register(withOptionalData: ["your_key": "your_value"])
```

## Automatic upstream sync

GitHub Actions 每天检查并同步 `oceanengine/bda_signal_sdk` 的 `main` 分支，也支持在 **Actions → Sync upstream and publish → Run workflow** 手动触发。

同步采用 merge，不会强制覆盖 Fork 的 SPM 适配文件。遇到上游与本仓库同文件冲突时，工作流会停止，需人工处理后重新运行。

同步完成后，工作流会读取上游已有的语义化版本 Tag；若 Fork 尚无对应 Tag，则创建同名 Tag 和 GitHub Release。SwiftPM 的版本依赖只会在对应 Tag 发布后可用。

## CocoaPods

原有 `BDASignalSDK.podspec` 保留，CocoaPods 用户可继续按官方方式集成。

## Important

- 本包将官方 `BDASignalRequestLib.xcframework` 作为本地 binary target 引入。
- SwiftPM manifest 检查不等同于完整 iOS 编译验证；发布前仍需在 Xcode 真机及模拟器环境验证。
- 请遵循上游 SDK 的许可证、隐私要求和巨量引擎接入文档。
