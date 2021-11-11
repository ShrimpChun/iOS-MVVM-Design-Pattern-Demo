//
//  Order.swift
//  CoffeeShop
//
//  Created by Shrimp Hsieh on 2021/11/11.
//

import Foundation

enum CoffeeName: String, Codable, CaseIterable {
    case cappuccino
    case lattee
    case expressino
    case cortado
}

enum CoffeeSize: String, Codable, CaseIterable {
    case small
    case medium
    case large
}

struct Order: Codable {
    let name: String
    let coffeeName: CoffeeName
    let size: CoffeeSize
    let total: Double
}

extension Order {
    
    static var all: Resource<[Order]> = {
        guard let url = URL(string: "https://island-bramble.glitch.me/orders") else {
            fatalError("URL is incorrect.")
        }
        return Resource<[Order]>(url: url)
    }()
    
    static var clean: Resource<[Order]> = {
        guard let url = URL(string: "https://island-bramble.glitch.me/clear-orders") else {
            fatalError("URL is incorrect.")
        }
        return Resource<[Order]>(url: url)
    }()
    
    static func create(vm: AddCoffeeOrderViewModel) -> Resource<Order?> {
        let order = Order(vm)
        
        guard let url = URL(string: "https://island-bramble.glitch.me/orders") else {
            fatalError("URL is incorrect.")
        }
        
        guard let data = try? JSONEncoder().encode(order) else {
            fatalError("Error encoding order.")
        }
        
        var resouce = Resource<Order?>(url: url)
        resouce.httpMethod = HttpMethod.post
        resouce.body = data
        return resouce
    }
    
}

extension Order {
    
    init?(_ vm: AddCoffeeOrderViewModel) {
        guard let name = vm.name,
              let selectedCoffeeName = CoffeeName(rawValue: vm.selectedCoffeeName!.lowercased()),
              let selectedSize = CoffeeSize(rawValue: vm.selectedSize!.lowercased()) else {
                  return nil
              }
        
        self.name = name
        self.coffeeName = selectedCoffeeName
        self.size = selectedSize
        self.total = 1
    }
    
}
