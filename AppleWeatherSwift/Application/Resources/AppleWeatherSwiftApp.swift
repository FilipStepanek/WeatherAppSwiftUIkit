//
//  AppleWeatherSwiftApp.swift
//  AppleWeatherSwift
//
//  Created by Filip Štěpánek on 01.11.2023.
//

import SwiftUI
import Factory
import OSLog

@main
@MainActor
struct AppleWeatherSwiftApp: App {
    // Use @Environment to track the scene phase
    @Environment(\.scenePhase) private var scenePhase
    
    // Injected ViewModels
    @StateObject private var todayViewModel = TodayViewModel()
    @StateObject private var forecastViewModel = ForecastViewModel()

    var body: some Scene {
        WindowGroup {
            // Inject the ViewModels into ContentView
            ContentView(todayViewModel: todayViewModel, forecastViewModel: forecastViewModel)
                // Add scene phase handling
                .onChange(of: scenePhase) { newScenePhase in
                    switch newScenePhase {
                    case .active:
                        // Start fetching weather data when the app becomes active
                        Logger.viewCycle.info("App is active - resume data fetching")
                        todayViewModel.startFetchingWeatherData()
                        forecastViewModel.startFetchingWeatherData()
                       
                    case .inactive, .background:
                        // Stop fetching weather data when the app becomes inactive or moves to the background
                        Logger.viewCycle.info("App is in background - stop data fetching")
                        todayViewModel.stopFetchingWeatherData()
                        forecastViewModel.stopFetchingWeatherData()
                        
                    @unknown default:
                        break
                    }
                }
        }
    }
}

extension Container {
    var weatherManager: Factory<WeatherManaging> {
        Factory(self) {
            WeatherManager()
        }
    }
    
    var locationManager: Factory<LocationManaging> {
        Factory(self) {
            LocationManager()
        }
    }
}


