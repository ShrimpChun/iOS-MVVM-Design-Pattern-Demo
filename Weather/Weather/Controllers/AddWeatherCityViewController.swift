//
//  AddWeatherCityViewController.swift
//  Weather
//
//  Created by Shrimp Hsieh on 2021/11/12.
//

import Foundation
import UIKit

protocol AddWeatherDelegate {
    func addWeatherDidSave(vm: WeatherViewModel)
}

class AddWeatherCityViewController: UIViewController {
    
    @IBOutlet weak var cityNameTextField: UITextField!
    
    private var addWeatherVM = AddWeatherViewModel()
    
    var delegate: AddWeatherDelegate?
    
    @IBAction func saveCityButtonPressed() -> Void {
        
        if let city = cityNameTextField.text {
            addWeatherVM.addWeather(for: city) { vm in
                self.delegate?.addWeatherDidSave(vm: vm)
                self.dismiss(animated: true, completion: nil)
            }
        }
        
    }
    
    @IBAction func close() -> Void {
        self.dismiss(animated: true, completion: nil)
    }
    
}
