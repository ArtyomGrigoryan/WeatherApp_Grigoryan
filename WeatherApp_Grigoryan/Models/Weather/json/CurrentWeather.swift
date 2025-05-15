//
//  CurrentWeather.swift
//  WeatherApp_Grigoryan
//
//  Created by Артём Григорян on 13.05.2025.
//

struct CurrentWeather: Decodable {
    let temp_c: Double
    let condition: WeatherCondition
}
