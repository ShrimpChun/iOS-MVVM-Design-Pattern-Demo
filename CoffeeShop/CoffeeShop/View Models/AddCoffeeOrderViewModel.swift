//
//  AddCoffeeOrderViewModel.swift
//  CoffeeShop
//
//  Created by Shrimp Hsieh on 2021/11/11.
//

import Foundation

struct AddCoffeeOrderViewModel {
    
    var coffeeNames: [String] {
        return CoffeeName.allCases.map { $0.rawValue.capitalized }
    }
    
    var sizes: [String] {
        return CoffeeSize.allCases.map { $0.rawValue.capitalized }
    }
    
    var name: String?
    var selectedCoffeeName: String?
    var selectedSize: String?
    var total: Double?
    
}
