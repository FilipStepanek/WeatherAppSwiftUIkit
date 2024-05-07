//
//  ForecastDetailNowView.swift
//  AppleWeatherSwift
//
//  Created by Filip Štěpánek on 07.02.2024.
//

import UIKit

class ForecastDetailNowView: UIView {
    
    let weatherNow: CurrentResponse
    
    // UI Components
    
    init(weatherNow: CurrentResponse) {
        self.weatherNow = weatherNow
        super.init(frame: .zero)
        setupViews()
        updateUI()
    }
    
    required init?(coder: NSCoder) {
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
        
        NSLayoutConstraint.activate([
            
            circularImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            circularImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            circularImageView.widthAnchor.constraint(equalToConstant: 48),
            circularImageView.heightAnchor.constraint(equalToConstant: 48),
            
            iconImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24.4),
            iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 28.8),
            iconImageView.heightAnchor.constraint(equalToConstant: 28.8),
            
            titleLabel.topAnchor.constraint(equalTo: circularImageView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: circularImageView.trailingAnchor, constant: 17),
            
            infoLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            infoLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            
            temperatureLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            temperatureLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
    

    
    private func updateUI() {
        iconImageView.image = UIImage(named: WeatherManagerExtension().getImageNameFromForecastIcon(icon: weatherNow.weather.first?.icon ?? ""))
        titleLabel.text = "Now"
        infoLabel.text = WeatherManagerExtension().getWeatherInfoFromForecastIcon(icon: weatherNow.weather.first?.icon ?? "")
        temperatureLabel.text = temperatureUnitSymbol()
    }
    
    private func temperatureUnitSymbol() -> String {
        let measurementFormatter = MeasurementFormatter()
        measurementFormatter.numberFormatter.maximumFractionDigits = 0
        
        let temperature = Measurement(value: weatherNow.main.temp, unit: UnitTemperature.celsius)
        return measurementFormatter.string(from: temperature)
    }
}

import SwiftUI

struct ForecastDetailNowViewWrapper: UIViewRepresentable {
    typealias UIViewType = ForecastDetailNowView
    
    let weatherNow: CurrentResponse
    
    func makeUIView(context: Context) -> ForecastDetailNowView {
        return ForecastDetailNowView(weatherNow: weatherNow)
    }
    
    func updateUIView(_ uiView: ForecastDetailNowView, context: Context) {
        // Update the view if needed
    }
}

#if DEBUG
struct ForecastDetailNowViewWrapper_Previews: PreviewProvider {
    static var previews: some View {
        ForecastDetailNowViewWrapper(weatherNow: .previewMock)
    }
}
#endif

