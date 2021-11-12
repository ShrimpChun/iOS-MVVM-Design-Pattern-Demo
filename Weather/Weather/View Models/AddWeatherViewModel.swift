//
//  AddWeatherViewModel.swift
//  Weather
//
//  Created by Shrimp Hsieh on 2021/11/12.
//

import Foundation

class AddWeatherViewModel {
    
    func addWeather(for city: String, completion: @escaping (WeatherViewModel) -> Void) {
        
        let weatherURL = Constants.Urls.urlForWeatherByCity(city: city)
        
        let weatherResource = Resource<WeatherResponse>(url: weatherURL) { data in
            let weatherResponse = try? JSONDecoder().decode(WeatherResponse.self, from: data)
            return weatherResponse
        }
        
        Webservice().load(resource: weatherResource) { result in
            
            if let resource = result {
                let vm = WeatherViewModel(weather: resource)
                completion(vm)
            }
        }
    }
    
    
    
}
