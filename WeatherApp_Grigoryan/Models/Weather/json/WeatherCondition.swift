//
//  WeatherCondition.swift
//  WeatherApp_Grigoryan
//
//  Created by Артём Григорян on 13.05.2025.
//

struct WeatherCondition: Decodable {
    let text: String
    let icon: String
    let code: Int
}

extension WeatherCondition {
    var localizedDescription: String {
        switch code {
        case 1000: return "Ясно"
            
        case 1003: return "Переменная облачность"
        case 1006: return "Облачно"
        case 1009: return "Пасмурно"
        case 1030: return "Дымка"
            
        case 1063: return "Возможен дождь"
        case 1066: return "Возможен снег"
        case 1069: return "Возможен мокрый снег"
        case 1072: return "Возможен ледяной дождь"
        case 1087: return "Возможна гроза"
        case 1114: return "Метель"
        case 1117: return "Метель"
        case 1135: return "Туман"
        case 1147: return "Ледяной туман"
        case 1150: return "Морось"
        case 1153: return "Легкая морось"
        case 1168: return "Ледяная морось"
        case 1171: return "Сильная ледяная морось"
        case 1180: return "Небольшой дождь"
        case 1183: return "Умеренный дождь"
        case 1186: return "Дождь"
        case 1189: return "Умеренный дождь"
        case 1192: return "Сильный дождь"
        case 1195: return "Ливень"
        case 1198: return "Ледяной дождь"
        case 1201: return "Сильный ледяной дождь"
        case 1204: return "Мокрый снег"
        case 1207: return "Сильный мокрый снег"
        case 1210: return "Небольшой снег"
        case 1213: return "Умеренный снег"
        case 1216: return "Снег"
        case 1219: return "Умеренный снег"
        case 1222: return "Сильный снег"
        case 1225: return "Снегопад"
        case 1237: return "Ледяная крупа"
        case 1240: return "Небольшой ливень"
        case 1243: return "Умеренный ливень"
        case 1246: return "Сильный ливень"
        case 1249: return "Ливень с мокрым снегом"
        case 1252: return "Сильный ливень с мокрым снегом"
        case 1255: return "Небольшой снегопад"
        case 1258: return "Умеренный снегопад"
        case 1261: return "Сильный снегопад"
        case 1264: return "Ледяной ливень"
            
        case 1273: return "Небольшая гроза с дождем"
        case 1276: return "Гроза с сильным дождем"
        case 1279: return "Небольшая гроза со снегом"
        case 1282: return "Гроза с сильным снегом"
            
        default: return text 
        }
    }
}
