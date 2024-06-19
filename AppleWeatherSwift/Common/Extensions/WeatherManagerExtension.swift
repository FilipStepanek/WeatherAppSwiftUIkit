//
//  WeatherManagerExtension.swift
//  AppleWeatherSwift
//
//  Created by Filip Štěpánek on 18.01.2024.
//

import Foundation
import SwiftUI

class WeatherManagerExtension {
    
    // MARK: - Getting image name from current weather icon
    func getImageNameFromWeatherIcon(icon: String) -> Image {
        switch icon {
        case "01d":
            return Image(.todaySun)
        case "01n":
            return Image(.todayMoon)
        case "02d":
            return Image(.todayFewCloudsSun)
        case "02n":
            return Image(.todayFewCloudsSun)
        case "03d":
            return Image(.todayCloudy)
        case "03n":
            return Image(.todayCloudy)
        case "04d":
            return Image(.todayCloudy)
        case "04n":
            return Image(.todayCloudy)
        case "09d":
            return Image(.todayShowers)
        case "09n":
            return Image(.todayShowers)
        case "10d":
            return Image(.todayRain)
        case "10n":
            return Image(.todayRain)
        case "11d":
            return Image(.todayThunderstorm)
        case "11n":
            return Image(.todayThunderstorm)
        case "13d":
            return Image(.todaySnow)
        case "13n":
            return Image(.todaySnow)
        case "50d":
            return Image(.todayMist)
        case "50n":
            return Image(.todayMist)
        default:
            return Image(systemName: "photo.circle.fill")
        }
    }
    
    // MARK: - Getting image name from forecast icon
    func getImageNameFromForecastIcon(icon: String) -> UIImage? {
        switch icon {
        case "01d":
            return UIImage(resource: .forecastSun)
        case "01n":
            return UIImage(resource: .forecastMoon)
        case "02d":
            return UIImage(resource: .forecastFewCloudsSun)
        case "02n":
            return UIImage(resource: .forecastFewCloudsMoon)
        case "03d":
            return UIImage(resource: .forecastCloudy)
        case "03n":
            return UIImage(resource: .forecastCloudy)
        case "04d":
            return UIImage(resource: .forecastCloudy)
        case "04n":
            return UIImage(resource: .forecastCloudy)
        case "09d":
            return UIImage(resource: .forecastShowersLight)
        case "09n":
            return UIImage(resource: .forecastShowersLight)
        case "10d":
            return UIImage(resource: .forecastRain)
        case "10n":
            return UIImage(resource: .forecastRain)
        case "11d":
            return UIImage(resource: .forecastThunderstorm)
        case "11n":
            return UIImage(resource: .forecastThunderstorm)
        case "13d":
            return UIImage(resource: .forecastSnow)
        case "13n":
            return UIImage(resource: .forecastSnow)
        case "50d":
            return UIImage(resource: .forecastMist)
        case "50n":
            return UIImage(resource: .forecastMist)
        default:
            return UIImage(systemName: "photo.circle.fill")
        }
    }
    
    // MARK: - Getting weather info from weather icon
    func getWeatherInfoFromWeatherIcon(icon: String, temperature: Double) -> String {
        switch icon {
        case "01d":
            if temperature > 30 {
                return String(localized: "hot.message")
            } else {
                return String(localized: "day.clear.sky.message")
            }
        case "01n":
            return String(localized: "night.clear.sky.message")
        case "02d":
            return String(localized: "few.clouds.message")
        case "02n":
            return String(localized: "few.clouds.message")
        case "03d":
            return String(localized: "cloudy.message")
        case "03n":
            return String(localized: "cloudy.message")
        case "04d":
            return String(localized: "cloudy.message")
        case "04n":
            return String(localized: "cloudy.message")
        case "09d":
            return String(localized: "showers.message")
        case "09n":
            return String(localized: "showers.message")
        case "10d":
            return String(localized: "rainy.message")
        case "10n":
            return String(localized: "rainy.message")
        case "11d":
            return String(localized: "thunderstorm.message")
        case "11n":
            return String(localized: "thunderstorm.message")
        case "13d":
            return String(localized: "snow.message")
        case "13n":
            return String(localized: "snow.message")
        case "50d":
            return String(localized: "fog.message")
        case "50n":
            return String(localized: "fog.message")
        default:
            return String(localized: "no.info.current.weather")
        }
    }
    
    // MARK: - Getting weather info from forecast icon
    func getWeatherInfoFromForecastIcon(icon: String) -> String {
        switch icon {
        case "01d":
            return String(localized: "forecast.sun.message")
        case "01n":
            return String(localized: "forecast.moon.message")
        case "02d":
            return String(localized: "forecast.scattered.clouds.message")
        case "02n":
            return String(localized: "forecast.scattered.clouds.message")
        case "03d":
            return String(localized: "forecast.cloudy.message")
        case "03n":
            return String(localized: "forecast.cloudy.message")
        case "04d":
            return String(localized: "forecast.cloudy.message")
        case "04n":
            return String(localized: "forecast.cloudy.message")
        case "09d":
            return String(localized: "forecast.rain.showers.message")
        case "09n":
            return String(localized: "forecast.rain.showers.message")
        case "10d":
            return String(localized: "forecast.rain.message")
        case "10n":
            return String(localized: "forecast.rain.message")
        case "11d":
            return String(localized: "forecast.thunderstorm.message")
        case "11n":
            return String(localized: "forecast.thunderstorm.message")
        case "13d":
            return String(localized: "forecast.snowing.message")
        case "13n":
            return String(localized: "forecast.snowing.message")
        case "50d":
            return String(localized: "forecast.mist.message")
        case "50n":
            return String(localized: "forecast.mist.message")
        default:
            return String(localized: "forecast.no.info.current.weather")
        }
    }
    
    func getColor1(icon: String) -> Color {
        switch icon {
        case "01d":
            return .sun1
        case "10d":
            return .rain1
        case "04d":
            return .cloudy1
        default:
            return .default1
        }
    }
    
    func getColor2(icon: String) -> Color {
        switch icon {
        case "01d":
            return .sun2
        case "10d":
            return .rain2
        case "04d":
            return .cloudy2
        default:
            return .default2
        }
    }
}
