//
//  DateFormatterService.swift
//  WeatherApp_Grigoryan
//
//  Created by Артём Григорян on 14.05.2025.
//

import Foundation

enum DateFormat: String {
    case dateTime = "yyyy-MM-dd HH:mm" 
    case dateOnly = "yyyy-MM-dd"
    case dayOfWeek = "E"
}

final class DateFormatterService {
    func formatter(_ format: DateFormat) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = format.rawValue
        formatter.locale = Locale(identifier: "ru_RU")
        
        return formatter
    }
}
