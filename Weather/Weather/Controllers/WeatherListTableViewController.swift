//
//  WeatherListTableViewController.swift
//  Weather
//
//  Created by Shrimp Hsieh on 2021/11/12.
//

import Foundation
import UIKit

class WeatherListTableViewController: UITableViewController, AddWeatherDelegate {
    
    private var weatherListViewModel = WeatherListViewModel()
    private var lastUnitSelection: Unit!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        let userDefaults = UserDefaults.standard
        if let value = userDefaults.value(forKey: "unit") as? String {
            lastUnitSelection = Unit(rawValue: value)!
        }
    }
    
    func addWeatherDidSave(vm: WeatherViewModel) {
        weatherListViewModel.addWeatherViewModel(vm)
        tableView.reloadData()
    }
        
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherListViewModel.numberOfRows(section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath) as! WeatherCell
        
        let vm = weatherListViewModel.modelAt(indexPath.row)
        cell.configure(vm)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddWeatherCity" {
            prepareSegueForAddWeatherCityViewController(segue: segue)
        } else if segue.identifier == "Settings" {
            prepareSegueForSettingsViewController(segue: segue)
        }
    }
    
    func prepareSegueForAddWeatherCityViewController(segue: UIStoryboardSegue) -> Void {
        guard let nav = segue.destination as? UINavigationController else {
            fatalError("NavigationController not found.")
        }
        
        guard let vc = nav.viewControllers.first as? AddWeatherCityViewController else {
            fatalError("AddWeatherCityViewController not found.")
        }
        
        vc.delegate = self
    }
    
    func prepareSegueForSettingsViewController(segue: UIStoryboardSegue) -> Void {
        guard let nav = segue.destination as? UINavigationController else {
            fatalError("NavigationController not found.")
        }
        
        guard let vc = nav.viewControllers.first as? SettingsTableViewController else {
            fatalError("SettingsTableViewController not found.")
        }
        
        vc.delegate = self
    }
}

extension WeatherListTableViewController: SettingsDelegate {
    
    func settingsDone(vm: SettingsViewModel) {
        if lastUnitSelection.rawValue != vm.selectedUnit.rawValue {
            weatherListViewModel.updateUnit(to: vm.selectedUnit)
            tableView.reloadData()
            lastUnitSelection = Unit(rawValue: vm.selectedUnit.rawValue)!
        }
    }

}
