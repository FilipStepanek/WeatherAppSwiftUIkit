//
//  ForecastViewModel.swift
//  WeatherAppAppleWatch Watch App
//
//  Created by Filip Štěpánek on 13.02.2024.
//

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
    
    init() {
        setupBinding()
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

