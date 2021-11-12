//
//  String+Extensions.swift
//  Weather
//
//  Created by Shrimp Hsieh on 2021/11/12.
//

import Foundation

extension String {
    
    func escaped() -> String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? self
    }
    
}
