//
//  Spacing.swift
//  DesignKit
//
//  Created by daixingchuang on 2021/6/25.
//
/**
 间距分成三组：小（Small）、中（Medium）、大（Large）。
 两个小间距之间的差别是 4pt，中间距与小间距相差 6pt，而大间距直接相差 8pt
 */
//let spacing = kSpacing.twoExtraSmall
public struct kSpacing {
    /**超小间距4*/
    public static let twoExtraSmall: CGFloat = 4
    /**特小间距 8*/
    public static let extraSmall: CGFloat = 8
    /**小间距 12*/
    public static let small: CGFloat = 12
    /**中间距18*/
    public static let medium: CGFloat = 18
    /**大间距24*/
    public static let large: CGFloat = 24
    /**大大间距32*/
    public static let extraLarge: CGFloat = 32
    /**特大间距40*/
    public static let twoExtraLarge: CGFloat = 40
    /**超大间距48*/
    public static let threeExtraLarge: CGFloat = 48
}
