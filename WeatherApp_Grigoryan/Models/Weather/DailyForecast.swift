//
//  DailyForecast.swift
//  WeatherApp_Grigoryan
//
//  Created by Артём Григорян on 13.05.2025.
//

import Foundation

struct DailyForecast {
    let day: Day
    let dayOfWeek: String
    private let dateFormatterService = DateFormatterService()
    
    init(from forecastDay: ForecastDay) {
        day = forecastDay.day

        let dateOnlyFormatter = dateFormatterService.formatter(.dateOnly)
        let dayOfWeekFormatter = dateFormatterService.formatter(.dayOfWeek)

        let date = dateOnlyFormatter.date(from: forecastDay.date)
        // Проверяем, является ли дата — сегодняшней
        let isToday = date.map { Calendar.current.isDateInToday($0) } ?? false
        
        if !isToday {
            dayOfWeek = date.map { dayOfWeekFormatter.string(from: $0) } ?? forecastDay.date
        } else {
            dayOfWeek = "Сегодня"
        }
    }
    
    var maxTempString: String {
        return "\(Int(day.maxtemp_c))°"
    }
    
    var minTempString: String {
        return "\(Int(day.mintemp_c))°"
    }
}
