//
//  NetworkingConstants.swift
//  WeatherApp_Grigoryan
//
//  Created by Артём Григорян on 13.05.2025.
//

import Foundation

struct NetworkingConstants {
    struct API {
        static let scheme = "https"
        static let host = "api.weatherapi.com"
        static let iconsHost = "cdn.weatherapi.com"
        static let apiVersion = "/v1"
        static let forecastWeatherEndpoint = "/forecast.json"
        static let apiKey = "bd08e48791b44367917181940251305"

        static func forecastWeatherURL(from location: LocationCoordinate, days: Int, lang: String) -> URL? {
            var components = URLComponents()
            components.scheme = scheme
            components.host = host
            components.path = "\(apiVersion)\(forecastWeatherEndpoint)"

            components.queryItems = [
                URLQueryItem(name: "key", value: apiKey),
                URLQueryItem(name: "q", value: "\(location.latitude),\(location.longitude)"),
                URLQueryItem(name: "days", value: "\(days)"),
                URLQueryItem(name: "lang", value: "\(days)"),
            ]

            return components.url
        }
        
        static func weatherIconURL(from path: String) -> URL? {
            var components = URLComponents()
            components.scheme = scheme
            components.host = iconsHost
            components.path = String(path.dropFirst(2)).replacingOccurrences(of: iconsHost, with: "")
            
            return components.url
        }
    }
}
