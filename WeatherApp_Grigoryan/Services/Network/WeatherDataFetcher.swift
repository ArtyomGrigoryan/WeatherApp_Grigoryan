//
//  WeatherService.swift
//  WeatherApp_Grigoryan
//
//  Created by Артём Григорян on 13.05.2025.
//

import Foundation

final class WeatherDataFetcher: WeatherDataFetcherProtocol {
    private var networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }
    /*
     Этим методом получим как текущий прогноз погоды (используется в CurrentWeatherView), так и на 7 дней.
     В ТЗ сказано, что прогноз погоды на "сейчас" нужно получать из current.json, но forecast.json уже содержит
     прогноз на "сейчас", и делать 2 сетевых запроса - это избыточно.
     */
    func fetchWeatherData(from location: LocationCoordinate, days: Int = 7, lang: String = "ru") async throws -> WeatherData {
        let url = NetworkingConstants.API.forecastWeatherURL(from: location, days: days, lang: lang)
        let data = try await networkService.request(with: url)
        let weatherData = try JSONDecoder().decode(WeatherData.self, from: data)

        return weatherData
    }
    // Этим методом получим иконку прогноза погоды
    func fetchWeatherIcon(with path: String) async throws -> Data {
        let url = NetworkingConstants.API.weatherIconURL(from: path)
        let data = try await networkService.request(with: url)

        return data
    }
}
