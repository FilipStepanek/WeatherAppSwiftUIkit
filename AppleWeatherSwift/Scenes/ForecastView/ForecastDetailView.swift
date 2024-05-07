//
//  ForecastDetailView.swift
//  AppleWeatherSwift
//
//  Created by Filip Štěpánek on 28.11.2023.
//

import UIKit

class ForecastDetailView: UIView {
    
    let weather: ForecastResponse.ListResponse
    
    // UI Components
    
    init(weather: ForecastResponse.ListResponse) {
        self.weather = weather
        super.init(frame: .zero)
        setupViews()
        configure(with: weather)
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
    
    private func configure(with weather: ForecastResponse.ListResponse) {
        iconImageView.image = UIImage(named: WeatherManagerExtension().getImageNameFromForecastIcon(icon: weather.weather.first?.icon ?? ""))
        titleLabel.text = Date.formatUnixTimestampInGMT(weather.date)
        infoLabel.text = WeatherManagerExtension().getWeatherInfoFromForecastIcon(icon: weather.weather.first?.icon ?? "")
        temperatureLabel.text = temperatureUnitSymbol()
    }
    
    
    private func temperatureUnitSymbol() -> String {
        let measurementFormatter = MeasurementFormatter()
        measurementFormatter.numberFormatter.maximumFractionDigits = 0
        
        let temperature = Measurement(value: weather.main.temp, unit: UnitTemperature.celsius)
        return measurementFormatter.string(from: temperature)
    }
}

import SwiftUI

struct ForecastDetailViewWrapper: UIViewRepresentable {
    typealias UIViewType = ForecastDetailView
    
    let weather: ForecastResponse.ListResponse
    
    func makeUIView(context: Context) -> ForecastDetailView {
        return ForecastDetailView(weather: weather)
    }
    
    func updateUIView(_ uiView: ForecastDetailView, context: Context) {
        // Update the view if needed
    }
}

#if DEBUG
struct ForecastDetailViewWrapper_Previews: PreviewProvider {
    static var previews: some View {
        let mockListResponse = ForecastResponse.ListResponse(date: 1702749600, main: ForecastResponse.MainResponseForecast(temp: 30), weather: [])
        let mockForecastResponse = ForecastResponse(city: ForecastResponse.CoordinatesResp(coord: ForecastResponse.Coordinates(lon: 0, lat: 0)), list: [mockListResponse])
        
        ForecastDetailViewWrapper(weather: mockListResponse)
             // Adjust the frame size as needed
            .previewLayout(.sizeThatFits)
    }
}
#endif
