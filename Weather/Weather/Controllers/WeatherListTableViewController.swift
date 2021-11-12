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
    private var dataSource: TableViewDataSource<WeatherCell, WeatherViewModel>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        let userDefaults = UserDefaults.standard
        if let value = userDefaults.value(forKey: "unit") as? String {
            lastUnitSelection = Unit(rawValue: value)!
        }
        
        self.dataSource = TableViewDataSource(cellIdentifier: "WeatherCell", items: self.weatherListViewModel.weatherViewModels) { (cell, vm) in
            cell.cityNameLabel.text = vm.city
            cell.temperatureLabel.text = vm.temperature.formatAsDegree()
        }
        self.tableView.dataSource = self.dataSource
    }
    
    func addWeatherDidSave(vm: WeatherViewModel) {
        weatherListViewModel.addWeatherViewModel(vm)
        self.dataSource.updateItems(self.weatherListViewModel.weatherViewModels)
        tableView.reloadData()
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
