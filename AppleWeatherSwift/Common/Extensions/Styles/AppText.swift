//
//  AppText.swift
//  AppleWeatherSwift
//
//  Created by Filip Štěpánek on 23.11.2023.
//

import SwiftUI

struct TitleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .lineSpacing(0)
            .lineLimit(3)
            .multilineTextAlignment(.leading)
            .font(.headLineOne)
            .tracking(-4)
    }
}

struct ErrorInfoModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.errorDetailInfo)
            .foregroundColor(.mainText)
    }
}

struct TemperatureModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.temperatureInformation)
            .foregroundColor(.mainText)
    }
}

struct ContentModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.contentInfo)
            .foregroundColor(.contentRegular)
    }
}

struct ContentSmallModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.contentInfoSmall)
            .foregroundColor(.mainText)
    }
}

struct ContentSmallInfoModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.contentInfoSmall)
            .foregroundColor(.contentRegular)
    }
}

struct ContentMediumModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.contentMedium)
            .foregroundColor(.mainText)
    }
}

struct HeadlineThreeModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.headlineThree)
            .foregroundColor(.mainText)
    }
}

// MARK: - UIKit

let titleLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.contentMediumBase
    label.textColor = .mainText
    return label
}()

let infoLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.contentInfoSmallBase
    label.textColor = .contentRegular
    return label
}()

let temperatureLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.headlineThreeBase
    label.textColor = .mainText
    return label
}()

let dayLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.dayInfoBase
    label.textColor = .mainText
    return label
}()

let dateLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.contentInfoSmallBase
    label.textColor = .contentRegular
    return label
}()
