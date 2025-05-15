//
//  HourlyForecast.swift
//  WeatherApp_Grigoryan
//
//  Created by Артём Григорян on 13.05.2025.
//

import Foundation

struct HourlyForecast {
    let hour: Hour
    let isCurrentHour: Bool
    
    init(from hour: Hour, isCurrentHour: Bool = false) {
        self.hour = hour
        self.isCurrentHour = isCurrentHour
    }
    
    var timeString: String {
        if isCurrentHour {
            return "Сейчас"
        }
        
        return "\(hour.time.hourValue)"
    }
    
    var temperatureString: String {
        return "\(Int(hour.temp_c))°"
    }
    
    var rainChanceString: String {
        return hour.will_it_rain == 1 ? "\(hour.chance_of_rain)%" : ""
    }
}
