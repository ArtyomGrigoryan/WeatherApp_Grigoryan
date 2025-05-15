//
//  ForecastDay.swift
//  WeatherApp_Grigoryan
//
//  Created by Артём Григорян on 13.05.2025.
//

struct ForecastDay: Decodable {
    let date: String
    let day: Day
    let hour: [Hour]
}
