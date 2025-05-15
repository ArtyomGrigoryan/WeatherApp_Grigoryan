//
//  LocationProvider.swift
//  WeatherApp_Grigoryan
//
//  Created by Артём Григорян on 15.05.2025.
//

final class LocationProvider {
    private var location: LocationCoordinate!
    private var locationService: LocationProtocol

    init(locationService: LocationProtocol = LocationService()) {
        self.locationService = locationService
    }

    func fetchLocation() async -> LocationCoordinate {
        let coordinate = await locationService.getCurrentLocation()
        
        if let coordinate = coordinate {
            location = LocationCoordinate(latitude: coordinate.latitude, longitude: coordinate.longitude)
        } else {
            let moscow = LocationConstants.City.Moscow.self
            location = LocationCoordinate(latitude: moscow.latitude, longitude: moscow.longitude)
        }
        
        return location
    }
}
