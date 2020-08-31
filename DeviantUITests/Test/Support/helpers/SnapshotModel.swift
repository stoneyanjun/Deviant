//
//  SnapshotModel.swift
//  DeviantUITests
//
//  Copyright © 2020 Stone. All rights reserved.
//

import UIKit
import FBSnapshotTestCase

protocol SnapshotModel {
    var snapshotTestCase: FBSnapshotTestCase { get }
}

extension SnapshotModel where Self: UIScreenModel {
    @discardableResult
    func verifyView(snapshotName: String? = nil,
                    tolerence: CGFloat = 0,
                    file: StaticString = #file,
                    line: UInt = #line) -> Self {
        guard let device = Device(screenSize: windowSize()) else {
            fatalError("unsupported device")
        }

        guard let croppedImage = screenShot().image.cropForTesting(for: device,
                                                                   skipKeyboard: false,
                                                                   windowSizeFunc: windowSize,
                                                                   keyboardOrignYFunc: keyboradOriginY) else {
                                                                    XCTFail("fail to cropp the screenshot", file: file, line: line)
                                                                    return self
        }

        let imageView = UIImageView(image: croppedImage)
        snapshotTestCase.FBSnapshotVerifyView(imageView,
                                              identifier: snapshotName ?? "",
                                              overallTolerance: tolerence,
                                              file: file,
                                              line: line)

        return self
    }

    private func screenShot() -> XCUIScreenshot {
        return XCUIScreen.main.screenshot()
    }

    private func windowSize() -> CGSize {
        return app.windows.firstMatch.frame.size
    }

    private func keyboradOriginY() -> CGFloat {
        return app.keyboards.firstMatch.frame.origin.y
    }
}

private extension UIImage {
    func cropForTesting(for device: Device,
                        skipKeyboard: Bool,
                        windowSizeFunc: () -> CGSize,
                        keyboardOrignYFunc: () ->CGFloat) -> UIImage? {
        guard let cgImage = cgImage else {
            return nil
        }

        let yOffset = device.statusBarHeight * scale
        var height = cgImage.height -  Int(yOffset)

        if skipKeyboard {
            let keyboardOriginY = keyboardOrignYFunc()
            height -= Int((windowSizeFunc().height - keyboardOriginY)  * scale)
        }

        let cropRect = CGRect(x: 0, y: Int(yOffset), width: cgImage.width, height: height)

        if let croppedCGImage = cgImage.cropping(to: cropRect) {
            return UIImage(cgImage: croppedCGImage, scale: scale, orientation: imageOrientation)
        }

        return nil
    }
}

private enum Device {
    case iPhone8
    case iPhone8Plus
    case iPhoneX
    case iPhoneXR

    init?(screenSize: CGSize) {
        switch screenSize {
        case CGSize(width: 375, height: 667):
            self = .iPhone8
        case CGSize(width: 414, height: 736):
            self = .iPhone8Plus
        case CGSize(width: 375, height: 812):
            self = .iPhoneX
        case CGSize(width: 414, height: 896):
            self = .iPhoneXR
        default:
            return nil
        }
    }

    var statusBarHeight: CGFloat {
        switch self {
        case .iPhoneX, .iPhoneXR:
            return 44
        default:
            return 22
        }
    }
}

extension SnapshotModel where Self: UIScreenModel {
    @discardableResult
    func verifyView(snapshotKey: SnapshotKey,
                    tolerence: CGFloat = Const.tolerence,
                    file: StaticString = #file,
                    line: UInt = #line) -> Self {
        let snapshotName = "\(snapshotKey.rawValue)"
        return verifyView(snapshotName: snapshotName,
                          tolerence: tolerence,
                          file: file,
                          line: line)
    }
}
