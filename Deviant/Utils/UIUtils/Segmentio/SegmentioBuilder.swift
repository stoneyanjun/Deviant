//
//  SegmentioBuilder.swift
//  Segmentio
//
//  Created by Dmitriy Demchenko on 11/14/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Segmentio
import UIKit

struct SegmentioBuilder {
    private enum Const {
        static let maxVisibleItems = 4
        static let numberOfLines = 1
        static let ratio: CGFloat = 1
        static let fontSize: CGFloat = 13
        static let animationDuration = 0.3
    }
    static func setupBadgeCountForIndex(_ segmentioView: Segmentio, index: Int) {
        segmentioView.addBadge(
            at: index,
            count: 10,
            color: ColorPalette.coral
        )
    }

    static func buildHomeSegmentioView(segmentioView: Segmentio,
                                       segmentioStyle: SegmentioStyle,
                                       segmentioPosition: SegmentioPosition = .fixed(maxVisibleItems: Const.maxVisibleItems)) {
        segmentioView.setup(
            content: homeSegmentioContent(),
            style: segmentioStyle,
            options: segmentioOptions(segmentioStyle: segmentioStyle,
                                      segmentioPosition: segmentioPosition)
        )
    }

    static func buildDetailSegmentioView(segmentioView: Segmentio,
                                         segmentioStyle: SegmentioStyle,
                                         segmentioPosition: SegmentioPosition = .fixed(maxVisibleItems: Const.maxVisibleItems)) {
        segmentioView.setup(
            content: detailSegmentioContent(),
            style: segmentioStyle,
            options: segmentioOptions(segmentioStyle: segmentioStyle,
                                      segmentioPosition: segmentioPosition)
        )
    }

    private static func homeSegmentioContent() -> [SegmentioItem] {
        return [
            SegmentioItem(title: "Popular", image: nil),
            SegmentioItem(title: "Topic", image: nil),
            SegmentioItem(title: "Daily", image: nil)
        ]
    }

    private static func detailSegmentioContent() -> [SegmentioItem] {
        return [
            SegmentioItem(title: "Info", image: nil),
            SegmentioItem(title: "Comment", image: nil),
            SegmentioItem(title: "Favorate", image: nil),
            SegmentioItem(title: "More", image: nil)
        ]
    }

    private static func segmentioOptions(segmentioStyle: SegmentioStyle,
                                         segmentioPosition: SegmentioPosition = .fixed(maxVisibleItems: Const.maxVisibleItems)) -> SegmentioOptions {
        var imageContentMode = UIView.ContentMode.center
        switch segmentioStyle {
        case .imageBeforeLabel, .imageAfterLabel:
            imageContentMode = .scaleAspectFit
        default:
            break
        }

        return SegmentioOptions(
            backgroundColor: ColorPalette.white,
            segmentPosition: segmentioPosition,
            scrollEnabled: true,
            indicatorOptions: segmentioIndicatorOptions(),
            horizontalSeparatorOptions: segmentioHorizontalSeparatorOptions(),
            verticalSeparatorOptions: segmentioVerticalSeparatorOptions(),
            imageContentMode: imageContentMode,
            labelTextAlignment: .center,
            labelTextNumberOfLines: Const.numberOfLines,
            segmentStates: segmentioStates(),
            animationDuration: Const.animationDuration
        )
    }

    private static func segmentioStates() -> SegmentioStates {
        let font = UIFont.exampleAvenirMedium(ofSize: Const.fontSize)
        return SegmentioStates(
            defaultState: segmentioState(
                backgroundColor: .clear,
                titleFont: font,
                titleTextColor: ColorPalette.grayChateau
            ),
            selectedState: segmentioState(
                backgroundColor: .cyan,
                titleFont: font,
                titleTextColor: ColorPalette.black
            ),
            highlightedState: segmentioState(
                backgroundColor: ColorPalette.whiteSmoke,
                titleFont: font,
                titleTextColor: ColorPalette.grayChateau
            )
        )
    }

    private static func segmentioState(backgroundColor: UIColor,
                                       titleFont: UIFont,
                                       titleTextColor: UIColor) -> SegmentioState {
        return SegmentioState(
            backgroundColor: backgroundColor,
            titleFont: titleFont,
            titleTextColor: titleTextColor
        )
    }

    private static func segmentioIndicatorOptions() -> SegmentioIndicatorOptions {
        return SegmentioIndicatorOptions(
            type: .bottom,
            ratio: Const.ratio,
            height: 5,
            color: ColorPalette.coral
        )
    }

    private static func segmentioHorizontalSeparatorOptions() -> SegmentioHorizontalSeparatorOptions {
        return SegmentioHorizontalSeparatorOptions(
            type: .topAndBottom,
            height: 1,
            color: ColorPalette.whiteSmoke
        )
    }

    private static func segmentioVerticalSeparatorOptions() -> SegmentioVerticalSeparatorOptions {
        return SegmentioVerticalSeparatorOptions(
            ratio: Const.ratio,
            color: ColorPalette.whiteSmoke
        )
    }
}
