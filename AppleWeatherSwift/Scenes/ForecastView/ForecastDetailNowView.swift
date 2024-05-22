//
//  ForecastDetailNowView.swift
//  AppleWeatherSwift
//
//  Created by Filip Štěpánek on 07.02.2024.
//

import UIKit

class ForecastDetailNowView: UICollectionViewCell {
    
    var weatherNow: CurrentResponse?
    
    // UI Components
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let circularImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 24
        imageView.clipsToBounds = true
        imageView.backgroundColor = UIColor.iconBase
        imageView.frame = CGRect(x: 0, y: 0, width: 48, height: 48)
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.contentMediumBase
        label.textColor = .mainText
        return label
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.contentInfoSmallBase
        label.textColor = .contentRegular
        return label
    }()
    
    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.headlineThreeBase
        label.textColor = .mainText
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = .row
        layer.cornerRadius = 16
        layer.masksToBounds = true
        
        addSubview(circularImageView)
        addSubview(iconImageView)
        addSubview(titleLabel)
        addSubview(infoLabel)
        addSubview(temperatureLabel)
        
        // Layout constraints
        circularImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Set compression resistance priority for infoLabel
        infoLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        temperatureLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        NSLayoutConstraint.activate([
            circularImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            circularImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            circularImageView.widthAnchor.constraint(equalToConstant: 48),
            circularImageView.heightAnchor.constraint(equalToConstant: 48),
            
            iconImageView.centerXAnchor.constraint(equalTo: circularImageView.centerXAnchor),
            iconImageView.centerYAnchor.constraint(equalTo: circularImageView.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 28.8),
            iconImageView.heightAnchor.constraint(equalToConstant: 28.8),
            
            titleLabel.topAnchor.constraint(equalTo: circularImageView.topAnchor, constant: 4),
            titleLabel.leadingAnchor.constraint(equalTo: circularImageView.trailingAnchor, constant: 17),
            
            infoLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            infoLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            infoLabel.trailingAnchor.constraint(lessThanOrEqualTo: temperatureLabel.leadingAnchor, constant: -8),
            
            temperatureLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            temperatureLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
    
    func configure(with weatherNow: CurrentResponse) {
        self.weatherNow = weatherNow
        updateUI()
    }
    
    private func updateUI() {
        guard let weatherNow = weatherNow else { return }
        iconImageView.image = UIImage(named: WeatherManagerExtension().getImageNameFromForecastIcon(icon: weatherNow.weather.first?.icon ?? ""))
        titleLabel.text = "Now"
        infoLabel.text = WeatherManagerExtension().getWeatherInfoFromForecastIcon(icon: weatherNow.weather.first?.icon ?? "")
        temperatureLabel.text = temperatureUnitSymbol()
    }
    
    private func temperatureUnitSymbol() -> String {
        let measurementFormatter = MeasurementFormatter()
        measurementFormatter.numberFormatter.maximumFractionDigits = 0
        
        let temperature = Measurement(value: weatherNow?.main.temp ?? 0.0, unit: UnitTemperature.celsius)
        return measurementFormatter.string(from: temperature)
    }
}

#if DEBUG
import SwiftUI

struct ForecastDetailNowViewWrapper: UIViewRepresentable {
    typealias UIViewType = ForecastDetailNowView
    
    let weatherNow: CurrentResponse
    
    func makeUIView(context: Context) -> ForecastDetailNowView {
        let forecastDetailNowView = ForecastDetailNowView()
        forecastDetailNowView.configure(with: weatherNow)
        return forecastDetailNowView
    }
    
    func updateUIView(_ uiView: ForecastDetailNowView, context: Context) {
        uiView.configure(with: weatherNow)
    }
}

#Preview {
    ForecastDetailNowViewWrapper(
        weatherNow: .previewMock
    )
}
#endif

