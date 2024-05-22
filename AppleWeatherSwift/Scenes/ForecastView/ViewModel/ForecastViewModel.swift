//
//  ForecastViewModel.swift
//  AppleWeatherSwift
//
//  Created by Filip Štěpánek on 08.01.2024.
//

//import Combine
//import CoreLocation
//import Factory
//
//@MainActor
//final class ForecastViewModel: ObservableObject {
//    @Published var shouldReloaded = false
//    @Published private(set) var state: State = .loading
//
//    //MARK: - Injected weatherManager via Factory package manager - Dependency Injection
//    @Injected(\.weatherManager) private var weatherManager
//    @Injected(\.locationManager) private var locationManager
//
//    private var cancellables = Set<AnyCancellable>()
//
//    init() {
//           setupBinding()
//       }
//
//    func setupBinding() {
//        locationManager
//            .location
//            .compactMap{$0}
//            .sink { [weak self] location in
//                self?.getForecast(for: location)
//            }
//            .store(in: &cancellables)
//
//        locationManager
//            .authorizationStatus
//            .sink { [weak self] status in
//                switch status {
//                case.locationGaranted:
//                    self?.locationManager.requestLocation()
//                default:
//                    self?.state = .missingLocation
//                }
//            }
//            .store(in: &cancellables)
//    }
//
//    func getForecast(for location: CLLocationCoordinate2D) {
//        state = .loading
//
//        Task {
//            do {
//                let forecastResponse = try await weatherManager.getForecastWeather(
//                    latitude: location.latitude,
//                    longitude: location.longitude)
//
//                let currentResponse = try await weatherManager.getCurrentWeather(
//                    latitude: location.latitude,
//                    longitude: location.longitude)
//
//                state = .success(forecastResponse, currentResponse)
//            } catch {
//                if case NetworkError.noInternetConnection = error {
//                    return state = .errorNetwork(error.localizedDescription)
//                } else {
//                    return state = .error(error.localizedDescription)
//                }
//            }
//        }
//    }
//
//    func onRefresh() {
//        locationManager.requestLocation()
//    }
//}
//
//// MARK: - State
//extension ForecastViewModel {
//    enum State {
//        case loading
//        case missingLocation
//        case success(ForecastResponse, CurrentResponse)
//        case error(String)
//        case errorNetwork(String)
//    }
//}


import Combine
import CoreLocation
import Factory

@MainActor
final class ForecastViewModel: ObservableObject {
    @Published var shouldReloaded = false
    @Published private(set) var state: State = .loading
    
    //MARK: - Injected weatherManager via Factory package manager - Dependency Injection
    @Injected(\.weatherManager) private var weatherManager
    @Injected(\.locationManager) private var locationManager
    
    private var cancellables = Set<AnyCancellable>()
    private var timer: Timer?
    
    init() {
        setupBinding()
        startFetchingWeatherData()
    }
    
    func setupBinding() {
        locationManager
            .location
            .compactMap{$0}
            .sink { [weak self] location in
                self?.getForecast(for: location)
            }
            .store(in: &cancellables)
        
        locationManager
            .authorizationStatus
            .sink { [weak self] status in
                switch status {
                case.locationGaranted:
                    self?.locationManager.requestLocation()
                default:
                    self?.state = .missingLocation
                }
            }
            .store(in: &cancellables)
    }
    
    func startFetchingWeatherData() {
            // Start a timer to fetch weather data periodically
            timer = Timer.scheduledTimer(withTimeInterval: 1800.0, repeats: true) { _ in // Fetch every 30 minutes
                Task { @MainActor in
                    self.locationManager.requestLocation()
                }
            }
        }
    
    func stopFetchingWeatherData() {
        // Invalidate the timer to stop fetching data
        timer?.invalidate()
        timer = nil
    }
    
    func getForecast(for location: CLLocationCoordinate2D) {
        state = .loading
        
        Task {
            do {
                let forecastResponse = try await weatherManager.getForecastWeather(
                    latitude: location.latitude,
                    longitude: location.longitude)
                
                let currentResponse = try await weatherManager.getCurrentWeather(
                    latitude: location.latitude,
                    longitude: location.longitude)
                
                state = .success(forecastResponse, currentResponse)
            } catch {
                if case NetworkError.noInternetConnection = error {
                    return state = .errorNetwork(error.localizedDescription)
                } else {
                    return state = .error(error.localizedDescription)
                }
            }
        }
    }
    
    func onRefresh() {
        locationManager.requestLocation()
    }
}

// MARK: - State
extension ForecastViewModel {
    enum State {
        case loading
        case missingLocation
        case success(ForecastResponse, CurrentResponse)
        case error(String)
        case errorNetwork(String)
    }
}
