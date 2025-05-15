//
//  StringExtensions.swift
//  WeatherApp_Grigoryan
//
//  Created by Артём Григорян on 14.05.2025.
//

import Foundation

extension String {
    // Строку вида "2025-05-14 17:00" преобразует в 17
    var hourValue: Int {
        let dateOnlyFormatter = DateFormatterService().formatter(.dateTime)
        let date = dateOnlyFormatter.date(from: self)
       
        guard let date = date else { return 0 }
        
        return Calendar.current.component(.hour, from: date)
    }
}
