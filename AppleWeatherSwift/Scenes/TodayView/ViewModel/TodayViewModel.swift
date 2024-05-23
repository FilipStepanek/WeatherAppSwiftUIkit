//
//  TodayView-ViewModel.swift
//  AppleWeatherSwift
//
//  Created by Filip Štěpánek on 23.12.2023.
//

import Combine
import CoreLocation
import Factory

@MainActor
final class TodayViewModel: ObservableObject {
    @Published var isShareSheetPresented = false
    @Published var shouldReloaded = false
    @Published var isConnected = true
    @Published var isPresented: Bool = false
    @Published private(set) var state: State = .loading
    
    //MARK: - Injected weatherManager via Factory package manager - Dependency Injection
    @Injected(\.weatherManager) private var weatherManager
    @Injected(\.locationManager) private var locationManager
    
    var weatherManagerExtension = WeatherManagerExtension()
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
                self?.getWeather(for: location)
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
    
    // add constant
    func startFetchingWeatherData() {
            // Start a timer to fetch weather data periodically
            timer = Timer.scheduledTimer(withTimeInterval: 1800.0, repeats: true) { _ in // Fetch every 30 minutes
                Task { @MainActor [weak self] in
                    self?.locationManager.requestLocation()
                }
            }
        }
    
    func stopFetchingWeatherData() {
        // Invalidate the timer to stop fetching data
        timer?.invalidate()
        timer = nil
    }
    
    func getWeather(for location: CLLocationCoordinate2D) {
        state = .loading
        
        Task {
            do {
                let response = try await weatherManager.getCurrentWeather(
                    latitude: location.latitude,
                    longitude: location.longitude
                )
                state = .succes(response)
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
extension TodayViewModel {
    enum State {
        case loading
        case missingLocation
        case succes(CurrentResponse)
        case error(String)
        case errorNetwork(String)
    }
}
