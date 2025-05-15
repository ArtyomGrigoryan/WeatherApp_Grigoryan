//
//  NetworkProtocols.swift
//  WeatherApp_Grigoryan
//
//  Created by Артём Григорян on 13.05.2025.
//

import Foundation

protocol NetworkServiceProtocol {
    func request(with url: URL?) async throws -> Data
}

protocol WeatherDataFetcherProtocol {
    func fetchWeatherData(from location: LocationCoordinate, days: Int, lang: String) async throws -> WeatherData
    func fetchWeatherIcon(with path: String) async throws -> Data
}
