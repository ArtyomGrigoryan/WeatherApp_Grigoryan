//
//  LocationProtocol.swift
//  WeatherApp_Grigoryan
//
//  Created by Артём Григорян on 15.05.2025.
//

import Foundation
import CoreLocation

protocol LocationProtocol {
    func getCurrentLocation() async -> CLLocationCoordinate2D?
}
