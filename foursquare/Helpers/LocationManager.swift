//
//  LocationManager.swift
//  foursquare
//
//  Created by Ahmed Ragab Issa on 8/15/20.
//  Copyright © 2020 Ahmed Ragab Issa. All rights reserved.
//

import CoreLocation

final class LocationManager: NSObject, CLLocationManagerDelegate {

    struct Location {
        let latitude: Double
        let longitude: Double
    }

    let manager: CLLocationManager
    var didReciveLocationUpdate: ((Location?, LocationError?) -> Void)?

    override init() {
        manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        super.init()
        manager.delegate = self
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .denied || status == .restricted {
            manager.stopUpdatingLocation()
            didReciveLocationUpdate?(nil, .permissionDenied)
        } else if status != .notDetermined {
            manager.startUpdatingLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        manager.stopUpdatingLocation()
        let location = Location(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
        didReciveLocationUpdate?(location, nil)
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        manager.stopUpdatingLocation()
    }

    func startUpdatingLocation() {
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }

    func stopUpdatingLocation() {
        manager.stopUpdatingLocation()
    }

    func startMonitoringSignificantLocationChanges() {
        manager.startMonitoringSignificantLocationChanges()
    }

    func stopMonitoringSignificantLocationChanges() {
        manager.stopMonitoringSignificantLocationChanges()
    }
}

enum LocationError {
    case disabled
    case permissionDenied
    case error(Error)

    var category: String {
        switch self {
        case .disabled:
            return "Disabled"
        case .permissionDenied:
            return "Permission Denied"
        case .error:
            return "Error"
        }
    }

    var reason: String {
        switch self {
        case .disabled:
            return "The location service is disabled"
        case .permissionDenied:
            return "The permission for location service is denied"
        case .error(let error):
            return error.localizedDescription
        }
    }
}
