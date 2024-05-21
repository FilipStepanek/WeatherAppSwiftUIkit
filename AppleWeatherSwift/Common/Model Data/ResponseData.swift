//
//  ResponseData.swift
//  AppleWeatherSwift
//
//  Created by Filip Štěpánek on 14.03.2024.
//

//import Foundation
//
//// MARK: - Model of the response body we get from calling the OpenWeather API
//struct CurrentResponse: Codable {
//    var coord: CoordinatesResponse
//    var weather: [WeatherResponse]
//    var main: MainResponse
//    var name: String
//    var wind: WindResponse
//    var sys: CountryName
//    var rain: Precipitation?
//    
//    
//    struct CoordinatesResponse: Codable {
//        var lon: Double
//        var lat: Double
//    }
//    
//    struct WeatherResponse: Codable {
//        var id: Double
//        var main: String
//        var description: String
//        var icon: String
//    }
//    
//    struct MainResponse: Codable {
//        var temp: Double
//        var pressure: Double
//        var humidity: Double
//    }
//    
//    struct WindResponse: Codable {
//        var speed: Double
//        let deg: Double
//        var windDirection: String {
//            if deg >= 337 || deg < 23 {
//                return "N"
//            }
//            if deg < 67 {
//                return "NE"
//            }
//            if deg < 113 {
//                return "E"
//            }
//            if deg < 157 {
//                return "SE"
//            }
//            if deg < 203 {
//                return "S"
//            }
//            if deg < 247 {
//                return "SW"
//            }
//            if deg < 293 {
//                return "W"
//            }
//            return "NW"
//        }
//    }
//    
//    struct CountryName: Codable {
//        var country: String
//    }
//    
//    struct Precipitation: Codable {
//        var oneHour: Double?
//        
//        enum CodingKeys: String, CodingKey {
//            case oneHour = "1h"
//        }
//    }
//}
//
//struct ForecastResponse: Codable {
//    let city: CoordinatesResp
//    let list: [ListResponse]
//    
//    struct ListResponse: Codable {
//        var date: Double
//        var main: MainResponseForecast
//        var weather: [WeatherResponseForecast]
//        
//        enum CodingKeys: String, CodingKey {
//            case date = "dt"
//            case main
//            case weather
//        }
//    }
//    
//    struct CoordinatesResp: Codable {
//        var coord: Coordinates
//    }
//    
//    struct Coordinates: Codable {
//        var lon: Double
//        var lat: Double
//    }
//    
//    struct MainResponseForecast: Codable {
//        var temp: Double
//    }
//    
//    struct WeatherResponseForecast: Codable {
//        var icon: String
//    }
//}
//
//#if DEBUG
////MARK: - Extension for ModelData
//extension CurrentResponse {
//    static let previewMock: Self = load("weatherDataCurrentWeather.json")
//}
//
//extension ForecastResponse {
//    static let previewMock: Self = load("weatherDataForecast.json")
//}
//#endif


import Foundation

// MARK: - Model of the response body we get from calling the OpenWeather API
struct CurrentResponse: Codable, Equatable {
    var coord: CoordinatesResponse
    var weather: [WeatherResponse]
    var main: MainResponse
    var name: String
    var wind: WindResponse
    var sys: CountryName
    var rain: Precipitation?
    
    static func == (lhs: CurrentResponse, rhs: CurrentResponse) -> Bool {
        return lhs.coord == rhs.coord &&
               lhs.weather == rhs.weather &&
               lhs.main == rhs.main &&
               lhs.name == rhs.name &&
               lhs.wind == rhs.wind &&
               lhs.sys == rhs.sys &&
               lhs.rain == rhs.rain
    }
    
    struct CoordinatesResponse: Codable, Equatable {
        var lon: Double
        var lat: Double
    }
    
    struct WeatherResponse: Codable, Equatable {
        var id: Double
        var main: String
        var description: String
        var icon: String
    }
    
    struct MainResponse: Codable, Equatable {
        var temp: Double
        var pressure: Double
        var humidity: Double
    }
    
    struct WindResponse: Codable, Equatable {
        var speed: Double
        let deg: Double
        var windDirection: String {
            if deg >= 337 || deg < 23 {
                return "N"
            }
            if deg < 67 {
                return "NE"
            }
            if deg < 113 {
                return "E"
            }
            if deg < 157 {
                return "SE"
            }
            if deg < 203 {
                return "S"
            }
            if deg < 247 {
                return "SW"
            }
            if deg < 293 {
                return "W"
            }
            return "NW"
        }
    }
    
    struct CountryName: Codable, Equatable {
        var country: String
    }
    
    struct Precipitation: Codable, Equatable {
        var oneHour: Double?
        
        enum CodingKeys: String, CodingKey {
            case oneHour = "1h"
        }
    }
}

struct ForecastResponse: Codable, Equatable {
    let city: CoordinatesResp
    let list: [ListResponse]
    
    static func == (lhs: ForecastResponse, rhs: ForecastResponse) -> Bool {
        return lhs.city == rhs.city && lhs.list == rhs.list
    }
    
    struct ListResponse: Codable, Equatable {
        var date: Double
        var main: MainResponseForecast
        var weather: [WeatherResponseForecast]
        
        enum CodingKeys: String, CodingKey {
            case date = "dt"
            case main
            case weather
        }
    }
    
    struct CoordinatesResp: Codable, Equatable {
        var coord: Coordinates
    }
    
    struct Coordinates: Codable, Equatable {
        var lon: Double
        var lat: Double
    }
    
    struct MainResponseForecast: Codable, Equatable {
        var temp: Double
    }
    
    struct WeatherResponseForecast: Codable, Equatable {
        var icon: String
    }
}

#if DEBUG
//MARK: - Extension for ModelData
extension CurrentResponse {
    static let previewMock: Self = load("weatherDataCurrentWeather.json")
}

extension ForecastResponse {
    static let previewMock: Self = load("weatherDataForecast.json")
}
#endif
