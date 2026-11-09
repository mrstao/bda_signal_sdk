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

选择产品 **BDASignalSDK**。在 App target 的 **Build Settings → Other Linker Flags** 中保留 `$(inherited)` 并添加 `-ObjC`。

原 `2.0.0` 标签的包配置含有 `unsafeFlags`，会被部分 Xcode 工程拒绝作为依赖。本次仅修复 SPM 包装配置，SDK 业务源码与二进制仍为上游 2.0.0；请使用下方固定提交，或选择已包含修复的 `main` 分支。

也可以在 Package.swift 中声明：

```swift
.package(url: "https://github.com/mrstao/bda_signal_sdk.git", revision: "d84085ac747754da9aea19c1930f493ed7745542")
```

Swift：

```swift
import BDASignalSDK

BDASignalManager.register(withOptionalData: ["your_key": "your_value"])
```

Objective-C：

```objc
#import <BDASignalSDK/BDASignalManager.h>
#import <BDASignalSDK/BDASignalDefinitions.h>
```

## Automatic upstream sync

GitHub Actions 每天检查并同步 `oceanengine/bda_signal_sdk` 的 `main` 分支，也支持在 **Actions → Sync upstream and publish → Run workflow** 手动触发。

- 同步采用 merge，不使用强制推送；Fork 独有的 SPM 文件会保留。
- 如果上游与 Fork 修改了同一个文件导致冲突，工作流会停止，需人工解决后重新运行。
- 同步后执行 `swift package dump-package` 和 `swift package describe`。
- 自动查找上游同步下来的最新语义化版本 Tag；若 Fork 尚无对应 Tag，则将该 Tag 创建在**已合并的 Fork HEAD** 上并发布 GitHub Release，确保版本快照包含 Package.swift 和 SPM wrapper。
- 通过 `GITHUB_TOKEN` 发布，不需要额外配置 PAT。

## CocoaPods

原有 `BDASignalSDK.podspec` 保留，CocoaPods 用户可继续按官方方式集成。

## Notes

- `BDASignalRequestLib.xcframework` 通过本地 SwiftPM binary target 引入，因此 XCFramework 必须保留在仓库中。
- CI 的 manifest 检查不等同于完整 iOS 编译验证；首次接入请在 Xcode 中解析依赖，并在模拟器及真机上验证。
- 请遵循上游 SDK 的许可证、隐私要求和巨量引擎接入文档。
