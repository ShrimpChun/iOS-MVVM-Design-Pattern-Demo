//
//  Constants.swift
//  Weather
//
//  Created by Shrimp Hsieh on 2021/11/12.
//

import Foundation

struct Constants {
    
    struct Urls {
        
        static func urlForWeatherByCity(city: String) -> URL {
            
            // Get the default settings for temperature
            let userDefaults = UserDefaults.standard
            let unit = (userDefaults.value(forKey: "unit") as? String) ?? "imperial"
        
            // https://openweathermap.org/api
            let appid: String = "__OpenWeatherMapAPI__"
            return URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city.escaped())&appid=\(appid)&units=\(unit)")!
            
        }
    }
    
}
