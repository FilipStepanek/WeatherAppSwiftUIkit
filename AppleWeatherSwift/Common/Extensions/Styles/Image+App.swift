//
//  Image-App.swift
//  AppleWeatherSwift
//
//  Created by Filip Štěpánek on 23.11.2023.
//

import SwiftUI

// MARK: - SwiftUI
extension Image {
    static let systemLocation = Image(systemName: "location.fill")
    static let systemWarning = Image(systemName: "exclamationmark.triangle.fill")
    static let systemNetworkError = Image(systemName: "wifi.exclamationmark")
    static let systemReload = Image(systemName: "arrow.clockwise")
    static let defaultImage = Image(systemName: "photo.circle.fill")
}

// MARK: - UIKit
extension UIImage {
    static let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    static let circularImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 24 // Half of the maximum width or height
        imageView.clipsToBounds = true
        imageView.backgroundColor = UIColor.iconBase
        imageView.frame = CGRect(x: 0, y: 0, width: 48, height: 48)
        return imageView
    }()
}

