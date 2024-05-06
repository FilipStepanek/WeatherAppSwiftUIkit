//
//  ForecastDetailNowView.swift
//  WeatherAppAppleWatch Watch App
//
//  Created by Filip Štěpánek on 13.02.2024.
//

import SwiftUI

struct ForecastDetailNowView: View {
    
    let weatherNow: CurrentResponse
    
    var body: some View {
        
        let temperatureWithUnits = "\(temperatureUnitSymbol())"
        
        HStack(
            spacing: 6
            
        ) {
            ZStack {
                
                Circle()
                    .frame(maxWidth: 35, maxHeight: 35)
                    .cornerRadius(35)
                    .foregroundColor(.iconBase)
                Image(WeatherManagerExtension().getImageNameFromForecastIcon(icon: weatherNow.weather.first?.icon ?? ""))
                    .imageSize()
                
            }
            .padding(.leading, 5)
            .padding(.vertical, 6)
            
            VStack(
                alignment: .leading
                
            ) {
                
                Text("Now")
                    .modifier(ContentMediumModifier())
                
            
                Text(WeatherManagerExtension().getWeatherInfoFromForecastIcon(icon: weatherNow.weather.first?.icon ?? ""))
                    .modifier(MediumModifier())
            }
            
            Spacer()
            
            Text(temperatureWithUnits)
                .modifier(HeadlineThreeModifier())
                .lineLimit(0)
                .padding()
        }
        .frame(maxWidth: .infinity)
        .background(.row)
        .cornerRadius(16)
    }
    func temperatureUnitSymbol() -> String {
        let measurementFormatter = MeasurementFormatter()
        measurementFormatter.numberFormatter.maximumFractionDigits = 0
        
        let temperature = Measurement(value: weatherNow.main.temp, unit: UnitTemperature.celsius)
        return measurementFormatter.string(from: temperature)
    }
}

#if DEBUG
#Preview {
    ForecastDetailNowView(weatherNow: .previewMock)
}
#endif
