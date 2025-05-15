//
//  Day.swift
//  WeatherApp_Grigoryan
//
//  Created by Артём Григорян on 13.05.2025.
//

struct Day: Decodable {
    let maxtemp_c: Double
    let mintemp_c: Double
    let condition: WeatherCondition
}
