//
//  LocationManager.swift
//  AppleWeatherSwift
//
//  Created by Filip Štěpánek on 01.12.2023.
//

import Foundation
import CoreLocation
import Combine
import OSLog

enum Status {
    case locationGranted
    case unknown
    case denied
    case notDetermined
}

protocol LocationManaging {
    var location: PassthroughSubject<CLLocationCoordinate2D?, Never> { get }
    var authorizationStatus: PassthroughSubject<Status, Never> { get }
    var lastLocation: CLLocation? { get }
    
    func requestLocation()
    func requestLocationPermission()
}

class LocationManager: NSObject, LocationManaging, CLLocationManagerDelegate {
    private let manager = CLLocationManager()
    private(set) var lastLocation: CLLocation?

    var location: PassthroughSubject<CLLocationCoordinate2D?, Never> = .init()
    var authorizationStatus: PassthroughSubject<Status, Never> = .init()
    
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        startMonitoringLocation()
    }
    
    // MARK: - Request Location
    func requestLocation() {
        Logger.networking.debug("Requested location")
        manager.requestLocation()
    }
    
    // MARK: - Request Location Permission
    func requestLocationPermission() {
        Logger.networking.debug("Request Location Permission")
        manager.requestWhenInUseAuthorization()
    }
    
    // MARK: - Location Manager Delegate Methods
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        Logger.networking.debug("Updated locations: \(locations)")
        if let newLocation = locations.last {
            // If the new location is significantly different from the previous one, send it
            if lastLocation == nil || newLocation.distance(from: lastLocation!) > 100 {
                lastLocation = newLocation
                location.send(newLocation.coordinate)
            }
        }
    }
    
    func handleStatus(status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            Logger.networking.info("Location authorization granted")
            authorizationStatus.send(.locationGranted)
        case .denied, .restricted:
            Logger.networking.info("Location authorization denied or restricted")
            authorizationStatus.send(.denied)
        case .notDetermined:
            Logger.networking.info("Location authorization not determined")
            authorizationStatus.send(.unknown)
        @unknown default:
            authorizationStatus.send(.unknown)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        Logger.networking.debug("Authorization status changed to: \(status.rawValue)")
        handleStatus(status: status)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if let clError = error as? CLError {
            Logger.networking.info("Location Manager Error: \(clError.errorCode) - \(clError.localizedDescription)")
        } else {
            Logger.networking.info("Generic Location Manager Error: \(error.localizedDescription)")
        }
    }
    
    // MARK: - Smart Location Management
    private func startMonitoringLocation() {
        if CLLocationManager.significantLocationChangeMonitoringAvailable() {
            manager.startMonitoringSignificantLocationChanges()
        } else {
            manager.startUpdatingLocation()
        }
    }
    
    func stopMonitoringSignificantLocationChanges() {
        if CLLocationManager.significantLocationChangeMonitoringAvailable() {
            manager.stopMonitoringSignificantLocationChanges()
        } else {
            manager.stopUpdatingLocation()
        }
    }
}
