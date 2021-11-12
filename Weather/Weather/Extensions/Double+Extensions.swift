//
//  Double+Extensions.swift
//  Weather
//
//  Created by Shrimp Hsieh on 2021/11/12.
//

import Foundation

extension Double {
    
    func formatAsDegree() -> String {
        return String(format: "%.0f°", self)
    }
    
}
