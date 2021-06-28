//
//  UIFontExtensions.swift
//  DesignKit
//
//  Created by daixingchuang on 2021/6/25.
//定义的字体规范
/**
 大标题（Display），用于显示这个页面的唯一标题，使用特大字号（如 42pt 和 36pt）；
 标题（Titile），用于显示段落的标题，我们提供了五种不同的段落标题，其字号由大变小；
 文本（Body），用于显示一般的内容文本，我们提供了普通和加粗两种类型来呈现不同的文本；
 小文本（Small text），使用较小的字体来显示辅佐内容，例如备注、版本信息等。
 */

import UIKit
//使用 label1.font = UIFont.designKit.title42
public extension UIFont {
    static let designKit = kDesignKitEnum()
    struct kDesignKitEnum {
        /**大标题特大字号*/
        public var display42: UIFont {
            scaled(baseFont: .systemFont(ofSize: 42, weight: .semibold), forTextStyle: .largeTitle, maximumFactor: 1.5)
        }
        /****大标题大字号**/
        public var display36: UIFont {
            scaled(baseFont: .systemFont(ofSize: 36, weight: .semibold), forTextStyle: .largeTitle, maximumFactor: 1.5)
        }
        /****标题字号24**/
        public var title24: UIFont {
            scaled(baseFont: .systemFont(ofSize: 24, weight: .semibold), forTextStyle: .title1)
        }
        /****标题字号20**/
        public var title20: UIFont {
            scaled(baseFont: .systemFont(ofSize: 20, weight: .semibold), forTextStyle: .title2)
        }
        /****标题字号18**/
        public var title18: UIFont {
            scaled(baseFont: .systemFont(ofSize: 18, weight: .semibold), forTextStyle: .title3)
        }
        /****标题字号14**/
        public var title14: UIFont {
            scaled(baseFont: .systemFont(ofSize: 14, weight: .regular), forTextStyle: .headline)
        }
        /****标题字号12**/
        public var title12: UIFont {
            scaled(baseFont: .systemFont(ofSize: 12, weight: .regular), forTextStyle: .subheadline)
        }
        /****文本字号16加粗**/
        public var bodyBold16: UIFont {
            scaled(baseFont: .systemFont(ofSize: 16, weight: .semibold), forTextStyle: .body)
        }
        /****文本字号16**/
        public var body16: UIFont {
            scaled(baseFont: .systemFont(ofSize: 16, weight: .light), forTextStyle: .body)
        }
        /****文本字号14**/
        public var captionBold14: UIFont {
            scaled(baseFont: .systemFont(ofSize: 14, weight: .semibold), forTextStyle: .caption1)
        }
        /****文本字号14**/
        public var caption14: UIFont {
            scaled(baseFont: .systemFont(ofSize: 14, weight: .light), forTextStyle: .caption1)
        }
        /**小文本字号12*/
        public var small12: UIFont {
            scaled(baseFont: .systemFont(ofSize: 12, weight: .light), forTextStyle: .footnote)
        }
    }
}

private extension UIFont.kDesignKitEnum {
    func scaled(baseFont: UIFont, forTextStyle textStyle: UIFont.TextStyle = .body, maximumFactor: CGFloat? = nil) -> UIFont {
        let fontMetrics = UIFontMetrics(forTextStyle: textStyle)

        if let maximumFactor = maximumFactor {
            let maximumPointSize = baseFont.pointSize * maximumFactor
            return fontMetrics.scaledFont(for: baseFont, maximumPointSize: maximumPointSize)
        }
        return fontMetrics.scaledFont(for: baseFont)
    }
}
