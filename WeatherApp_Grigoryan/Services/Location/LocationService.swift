//
//  LocationService.swift
//  WeatherApp_Grigoryan
//
//  Created by Артём Григорян on 13.05.2025.
//

import CoreLocation

final class LocationService: NSObject, CLLocationManagerDelegate, LocationProtocol {
    private let locationManager = CLLocationManager()
    private var authorizationChangeHandler: ((Bool) -> Void)?
    private var continuation: CheckedContinuation<CLLocationCoordinate2D?, Never>?

    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    func getCurrentLocation() async -> CLLocationCoordinate2D? {
        return await withCheckedContinuation { [weak self] continuation in
            guard let self = self else { return }
            self.continuation = continuation
            
            switch locationManager.authorizationStatus {
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
            case .authorizedWhenInUse, .authorizedAlways:
                locationManager.startUpdatingLocation()
            default:
                continuation.resume(returning: nil)
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        locationManager.stopUpdatingLocation()
        continuation?.resume(returning: location.coordinate)
        continuation = nil
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        continuation?.resume(returning: nil)
        continuation = nil
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
            authorizationChangeHandler?(true)
        case .denied, .restricted:
            continuation?.resume(returning: nil)
            continuation = nil
            authorizationChangeHandler?(false)
        default:
            break
        }
    }
    
    func observeAuthorizationChanges(handler: @escaping (Bool) -> Void) {
        authorizationChangeHandler = handler
    }
    
    func isAuthorized() -> Bool {
        let status = locationManager.authorizationStatus
        return status == .authorizedWhenInUse || status == .authorizedAlways
    }
}
