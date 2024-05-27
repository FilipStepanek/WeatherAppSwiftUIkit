//
//  LocationManager.swift
//  AppleWeatherSwift
//
//  Created by Filip Štěpánek on 01.12.2023.
//

//import Foundation
//import CoreLocation
//import OSLog
//import Combine
//
//enum Status {
//    case locationGranted
//    case unknown
//    case denied
//    case notDetermined
//}
//
//protocol LocationManaging {
//    var location: PassthroughSubject<CLLocationCoordinate2D?, Never> { get }
//    var authorizationStatus: PassthroughSubject<Status, Never> { get }
//    
//    func requestLocation()
//    func requestLocationPermission()
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
//    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus)
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
//}
//
//class LocationManager: NSObject, LocationManaging, CLLocationManagerDelegate {
//    let manager = CLLocationManager()
//    
//    var location: PassthroughSubject<CLLocationCoordinate2D?, Never> = .init()
//    var authorizationStatus: PassthroughSubject<Status, Never> = .init()
//    
//    override init() {
//        super.init()
//        manager.delegate = self
//        manager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
//        //MARK: debug Location status
//        handleStatus(status: manager.authorizationStatus)
//    }
//    
//    // MARK: - Request Location
//    func requestLocation() {
//        Logger.networking.debug("Requested location")
//        manager.requestLocation()
//    }
//    // MARK: - Request Location Permission
//    func requestLocationPermission() {
//        Logger.networking.debug("Request Location Permission")
//        manager.requestWhenInUseAuthorization()
//    }
//    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        Logger.networking.debug("Updated locations: \(locations)")
//        location.send(locations.first?.coordinate)
//    }
//    
//    func handleStatus(status: CLAuthorizationStatus) {
//        switch status {
//        case .authorizedWhenInUse, .authorizedAlways:
//            // Handle authorized status
//            Logger.networking.info("Location authorization granted")
//            authorizationStatus.send(.locationGranted)
//        case .denied, .restricted:
//            // Handle denied or restricted status
//            Logger.networking.info("Location authorization denied or restricted")
//            authorizationStatus.send(.denied)
//        case .notDetermined:
//            // Handle not determined status
//            Logger.networking.info("Location authorization not determined")
//            authorizationStatus.send(.unknown)
//            
//        @unknown default:
//            authorizationStatus.send(.unknown)
//        }
//    }
//    
//        func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//            Logger.networking.debug("Handle status")
//            //MARK: debug Location satus
//            handleStatus(status: status)
//        }
//    
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        if let clError = error as? CLError {
//            Logger.networking.info("Location Manager Error: \(clError.errorCode) - \(clError.localizedDescription)")
//        } else {
//            Logger.networking.info("Generic Location Manager Error: \(error.localizedDescription)")
//        }
//    }
//    
//    func startMonitoringSignificantLocationChanges() {
//        if CLLocationManager.significantLocationChangeMonitoringAvailable() {
//            manager.startMonitoringSignificantLocationChanges()
//        } else {
//            manager.startUpdatingLocation()
//        }
//    }
//    
//    func stopMonitoringSignificantLocationChanges() {
//        if CLLocationManager.significantLocationChangeMonitoringAvailable() {
//            manager.stopMonitoringSignificantLocationChanges()
//        } else {
//            manager.stopUpdatingLocation()
//        }
//    }
//}

import Foundation
import CoreLocation
import OSLog
import Combine

enum Status {
    case locationGranted
    case unknown
    case denied
    case notDetermined
}

protocol LocationManaging {
    var location: PassthroughSubject<CLLocationCoordinate2D?, Never> { get }
    var authorizationStatus: PassthroughSubject<Status, Never> { get }
    
    func requestLocation()
    func requestLocationPermission()
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus)
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
}

class LocationManager: NSObject, LocationManaging, CLLocationManagerDelegate {
    let manager = CLLocationManager()
    var lastLocation: CLLocation?
    
    var location: PassthroughSubject<CLLocationCoordinate2D?, Never> = .init()
    var authorizationStatus: PassthroughSubject<Status, Never> = .init()
    
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        //MARK: debug Location status
        handleStatus(status: manager.authorizationStatus)
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
            // Handle authorized status
            Logger.networking.info("Location authorization granted")
            authorizationStatus.send(.locationGranted)
        case .denied, .restricted:
            // Handle denied or restricted status
            Logger.networking.info("Location authorization denied or restricted")
            authorizationStatus.send(.denied)
        case .notDetermined:
            // Handle not determined status
            Logger.networking.info("Location authorization not determined")
            authorizationStatus.send(.unknown)
            
        @unknown default:
            authorizationStatus.send(.unknown)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        Logger.networking.debug("Handle status")
        //MARK: debug Location status
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
    
    func startMonitoringLocation() {
        if CLLocationManager.significantLocationChangeMonitoringAvailable() {
            manager.startMonitoringSignificantLocationChanges()
        } else {
            manager.startUpdatingLocation()
        }
    }
}

