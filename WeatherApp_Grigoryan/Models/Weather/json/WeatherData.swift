//
//  WeatherData.swift
//  WeatherApp_Grigoryan
//
//  Created by Артём Григорян on 13.05.2025.
//

struct WeatherData: Decodable {
    let location: Location
    let current: CurrentWeather
    let forecast: Forecast?
    
    var fullLocationString: String {
        return "\(location.name), \(LocalizationHelper.shared.getLocalizedCountryName(for: location.country))"
    }
    
    var currentTempCString: String {
        return "\(Int(current.temp_c))°C"
    }
    
    var tempRangeString: String {
        if let todayForecast = forecast?.forecastday.first {
            let maxTemp = Int(todayForecast.day.maxtemp_c)
            let minTemp = Int(todayForecast.day.mintemp_c)
            return "Макс.: \(maxTemp)°, мин.: \(minTemp)°"
        } else {
            return ""
        }
    }
}
