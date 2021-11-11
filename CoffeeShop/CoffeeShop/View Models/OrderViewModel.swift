//
//  OrderViewModel.swift
//  CoffeeShop
//
//  Created by Shrimp Hsieh on 2021/11/11.
//

import Foundation

// Provide data to the entire view, which is controllered by orders.
class OrderListViewModel {
    var ordersViewModel: [OrderViewModel]
    
    init() {
        self.ordersViewModel = [OrderViewModel]()
    }
}

extension OrderListViewModel {
    
    func orderViewModel(at index: Int) -> OrderViewModel {
        return self.ordersViewModel[index]
    }
}

struct OrderViewModel {
    let order: Order
}

// Which object do you want to display in TableView.
extension OrderViewModel {
    
    var name: String {
        return self.order.name
    }
    
    var coffeeName: String {
        return self.order.coffeeName.rawValue.capitalized
    }
    
    var size: String {
        return self.order.size.rawValue.capitalized
    }
    
    var total: Double {
        return self.order.total
    }
    
}
