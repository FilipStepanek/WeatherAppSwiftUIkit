//
//  ForecastDetailView.swift
//  AppleWeatherSwift
//
//  Created by Filip Štěpánek on 28.11.2023.
//

import UIKit

// Define a protocol to unify the data models
protocol WeatherData {
    var icon: String { get }
    var title: String { get }
    var info: String { get }
    var temperature: Double { get }
}

// Extend CurrentResponse to conform to WeatherData
extension CurrentResponse: WeatherData {
    var icon: String {
        return weather.first?.icon ?? ""
    }
    var title: String {
        return "Now"
    }
    var info: String {
        return WeatherManagerExtension().getWeatherInfoFromForecastIcon(icon: icon)
    }
    var temperature: Double {
        return main.temp
    }
}

// Extend ForecastResponse.ListResponse to conform to WeatherData
extension ForecastResponse.ListResponse: WeatherData {
    var icon: String {
        return weather.first?.icon ?? ""
    }
    var title: String {
        return Date.formatUnixTimestampInGMT(date)
    }
    var info: String {
        return WeatherManagerExtension().getWeatherInfoFromForecastIcon(icon: icon)
    }
    var temperature: Double {
        return main.temp
    }
}

class WeatherDetailView<T: WeatherData>: UICollectionViewCell {
    
    var weatherData: T?
    
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
    
    func configure(with weatherData: T) {
        self.weatherData = weatherData
        updateUI()
    }
    
    private func updateUI() {
        guard let weatherData = weatherData else { return }
        iconImageView.image = UIImage(named: WeatherManagerExtension().getImageNameFromForecastIcon(icon: weatherData.icon))
        titleLabel.text = weatherData.title
        infoLabel.text = weatherData.info
        temperatureLabel.text = formatTemperature(weatherData.temperature)
    }
    
    private func formatTemperature(_ temperature: Double) -> String {
        let measurementFormatter = MeasurementFormatter()
        measurementFormatter.numberFormatter.maximumFractionDigits = 0
        
        let temperatureValue = Measurement(value: temperature, unit: UnitTemperature.celsius)
        return measurementFormatter.string(from: temperatureValue)
    }
}

#if DEBUG
import SwiftUI

struct WeatherDetailViewWrapper<T: WeatherData>: UIViewRepresentable {
    typealias UIViewType = WeatherDetailView<T>
    
    let weatherData: T
    
    func makeUIView(context: Context) -> WeatherDetailView<T> {
        let weatherDetailView = WeatherDetailView<T>()
        weatherDetailView.configure(with: weatherData)
        return weatherDetailView
    }
    
    func updateUIView(_ uiView: WeatherDetailView<T>, context: Context) {
        uiView.configure(with: weatherData)
    }
}

struct WeatherDetailViewWrapper_Previews: PreviewProvider {
    static var previews: some View {
        let mockCurrentResponse = CurrentResponse.previewMock
        let mockForecastResponse = ForecastResponse.ListResponse(date: 1702749600, main: ForecastResponse.MainResponseForecast(temp: 30), weather: [])
        
        VStack {
            WeatherDetailViewWrapper(weatherData: mockCurrentResponse)
                .previewLayout(.sizeThatFits)
            WeatherDetailViewWrapper(weatherData: mockForecastResponse)
                .previewLayout(.sizeThatFits)
        }
    }
}
#endif
