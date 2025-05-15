//
//  LocalizationHelper.swift
//  WeatherApp_Grigoryan
//
//  Created by Артём Григорян on 13.05.2025.
//

import Foundation

final class LocalizationHelper {
    static let shared = LocalizationHelper()
    
    private init() {}
    // Преобразует название страны в код (например "Russia" -> "RU")
    func countryNameToCode(countryName: String) -> String? {
        let locales: [Locale] = Locale.availableIdentifiers.map { Locale(identifier: $0) }
        
        for locale in locales {
            if let code = locale.regionCode, locale.localizedString(forRegionCode: code)?.lowercased() == countryName.lowercased() {
                return code
            }
        }
        
        return nil
    }
    // Возвращает локализованное название страны
    func getLocalizedCountryName(for countryName: String, localeIdentifier: String = "ru_RU") -> String {
        guard let countryCode = countryNameToCode(countryName: countryName) else {
            return countryName
        }
        
        let locale = Locale(identifier: localeIdentifier)
        
        return locale.localizedString(forRegionCode: countryCode) ?? countryName
    }
}
