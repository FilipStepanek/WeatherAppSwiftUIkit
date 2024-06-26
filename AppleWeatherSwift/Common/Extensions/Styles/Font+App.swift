//
//  Font+App.swift
//  AppleWeatherSwift
//
//  Created by Filip Štěpánek on 15.11.2023.
//

import SwiftUI

// MARK: - SwiftUI
extension Font {
    private static let interBold = "Inter-Bold"
    private static let interMedium = "Inter-Medium"
    private static let interRegular = "Inter-Regular"
    private static let interSemibold = "Inter-SemiBold"
    
    enum FontSize: CGFloat {
        case tabBar = 10
        case headLine1 = 64
        case headLine2 = 40
        case headLine3 = 32
        case contentRegular = 16
        case contentSmall = 14
        case mediumTitle = 18
        case largeTitle = 30
        case extraLargeTitle = 70
        case dayInfoFont = 20
    }
    
    // Current Lotaion Data - Font
    static let myLocationTitle = (custom(Self.interBold, size: Self.FontSize.largeTitle.rawValue))
    static let myLocationText = (custom(Self.interBold, size: Self.FontSize.largeTitle.rawValue))
    static let myLocationTemperature = (custom(Self.interBold, size: Self.FontSize.extraLargeTitle.rawValue))
    static let myLocationWeather = (custom(Self.interBold, size: Self.FontSize.mediumTitle.rawValue))
    
    // Tab Bar
    static let tabBarFont = (custom(Self.interBold, size: Self.FontSize.tabBar.rawValue))
    
    // Head Line 1
    static let headLineOne = (custom(Self.interBold, size: Self.FontSize.headLine1.rawValue))
    
    // Error detail information
    static let errorDetailInfo = (custom(Self.interMedium, size: Self.FontSize.contentRegular.rawValue))
    
    // Buttons
    static let buttons = (custom(Self.interSemibold, size: Self.FontSize.contentRegular.rawValue))
    
    // Temperature
    static let temperatureInformation = (custom(Self.interSemibold, size: Self.FontSize.headLine3.rawValue))
    
    // Content Info
    static let contentInfo = (custom(Self.interRegular, size: Self.FontSize.contentRegular.rawValue))
    
    // Content Info Small
    static let contentInfoSmall = (custom(Self.interMedium, size: Self.FontSize.contentSmall.rawValue))
    
    // Content Medium
    static let contentMedium = (custom(Self.interMedium, size: Self.FontSize.contentRegular.rawValue))
    
    // Headline 3
    static let headlineThree = (custom(Self.interSemibold, size: Self.FontSize.headLine3.rawValue))
    
    // Day Info Font
    static let dayInfo = (custom(Self.interSemibold, size: Self.FontSize.dayInfoFont.rawValue))
    
    // Headline 2
    static let headlineTwo = (custom(Self.interBold, size: Self.FontSize.headLine2.rawValue))
    
    // Medium Title Temperature Apple Watch - Forecast
    static let mediumTitleWatch = (custom(Self.interBold, size: Self.FontSize.mediumTitle.rawValue))
    
    // Medium Title Temperature Apple Watch - Forecast
    static let mediumWatch = (custom(Self.interMedium, size: Self.FontSize.tabBar.rawValue))
    
    // Medium Title Temperature Apple Watch - Forecast
    static let contentSmallWatch = (custom(Self.interMedium, size: Self.FontSize.contentSmall.rawValue))
}

// MARK: - UIKit
extension UIFont {
    private static let interBold = "Inter-Bold"
    private static let interMedium = "Inter-Medium"
    private static let interSemibold = "Inter-SemiBold"
    
    enum FontSize: CGFloat {
        case headLine2 = 40
        case headLine3 = 32
        case contentRegular = 16
        case contentSmall = 14
        case dayInfoFont = 20
    }
    
    static let contentInfoSmallBase = UIFont(name: interMedium, size: FontSize.contentSmall.rawValue)!
    static let contentInfoSmall = UIFontMetrics(forTextStyle: .body).scaledFont(for: contentInfoSmallBase)
    
    static let contentMediumBase = UIFont(name: interMedium, size: FontSize.contentRegular.rawValue)!
    static let contentMedium = UIFontMetrics(forTextStyle: .title3).scaledFont(for: contentMediumBase)
    
    static let headlineThreeBase = UIFont(name: interSemibold, size: FontSize.headLine3.rawValue)!
    static let headlineThree = UIFontMetrics(forTextStyle: .largeTitle).scaledFont(for: headlineThreeBase)
    
    static let dayInfoBase = UIFont(name: interSemibold, size: FontSize.dayInfoFont.rawValue)!
    static let dayInfo = UIFontMetrics(forTextStyle: .title2).scaledFont(for: dayInfoBase)
    
    static let headlineTwoBase = UIFont(name: interBold, size: FontSize.headLine2.rawValue)!
    static let headlineTwo = UIFontMetrics(forTextStyle: .largeTitle).scaledFont(for: headlineTwoBase)
}
