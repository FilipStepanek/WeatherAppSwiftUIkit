//
//  ForecastDetailView.swift
//  AppleWeatherSwift
//
//  Created by Filip Štěpánek on 28.11.2023.
//

import UIKit
import SwiftUI

class ForecastDetailView: UICollectionViewCell {

    let weather: ForecastResponse.ListResponse
    
    // UI Components
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let circularImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 24 // Half of the maximum width or height
        imageView.clipsToBounds = true
        imageView.backgroundColor = UIColor.iconBase
        imageView.frame = CGRect(x: 0, y: 0, width: 48, height: 48)
        return imageView
    }()
    
    let titleLabel: UILabel = {
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
    
    init(weather: ForecastResponse.ListResponse) {
        self.weather = weather
        super.init(frame: .zero)
        setupViews()
        configure(with: weather)
    }
    
    override init(frame: CGRect) {
          self.weather = ForecastResponse.ListResponse(date: 0, main: ForecastResponse.MainResponseForecast(temp: 0), weather: [])
          super.init(frame: frame)
          setupViews()
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
            
            titleLabel.topAnchor.constraint(equalTo: circularImageView.topAnchor, constant: 4),
            titleLabel.leadingAnchor.constraint(equalTo: circularImageView.trailingAnchor, constant: 17),
            
            infoLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            infoLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            
            temperatureLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            temperatureLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
    
    func configure(with weather: ForecastResponse.ListResponse) {
        iconImageView.image = UIImage(named: WeatherManagerExtension().getImageNameFromForecastIcon(icon: weather.weather.first?.icon ?? ""))
        titleLabel.text = Date.formatUnixTimestampInGMT(weather.date)
        infoLabel.text = WeatherManagerExtension().getWeatherInfoFromForecastIcon(icon: weather.weather.first?.icon ?? "")
        temperatureLabel.text = formatTemperature(weather.main.temp)
    }

    private func formatTemperature(_ temperature: Double) -> String {
        let measurementFormatter = MeasurementFormatter()
        measurementFormatter.numberFormatter.maximumFractionDigits = 0
        
        let temperatureValue = Measurement(value: temperature, unit: UnitTemperature.celsius)
        return measurementFormatter.string(from: temperatureValue)
    }
}

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
        
        ForecastDetailViewWrapper(weather: mockListResponse)
             // Adjust the frame size as needed
            .previewLayout(.sizeThatFits)
    }
}
#endif
