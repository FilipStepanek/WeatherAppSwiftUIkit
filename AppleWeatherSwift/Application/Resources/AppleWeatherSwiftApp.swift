//
//  AppleWeatherSwiftApp.swift
//  AppleWeatherSwift
//
//  Created by Filip Štěpánek on 01.11.2023.
//

import SwiftUI
import Factory
import UIKit


@main
@MainActor
struct AppleWeatherSwiftApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            ContentView()
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


class AppDelegate: UIResponder, UIApplicationDelegate {

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Ensure the idle timer is not disabled
        application.isIdleTimerDisabled = false
    }
}
