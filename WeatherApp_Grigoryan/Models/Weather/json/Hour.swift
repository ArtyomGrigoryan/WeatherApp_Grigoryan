//
//  Hour.swift
//  WeatherApp_Grigoryan
//
//  Created by Артём Григорян on 13.05.2025.
//

struct Hour: Decodable {
    let time: String
    let temp_c: Double
    let condition: WeatherCondition
    let chance_of_rain: Int
    let will_it_rain: Int
}
