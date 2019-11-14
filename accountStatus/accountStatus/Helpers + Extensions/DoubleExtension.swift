//
//  DoubleExtension.swift
//  accountStatus
//
//  Created by RYAN GREENBURG on 11/13/19.
//  Copyright © 2019 RYAN GREENBURG. All rights reserved.
//

import Foundation

extension Double {
    func currencyValue() -> String {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = Locale.current
        let numberValue = NSNumber(value: self)
        
        return currencyFormatter.string(from: numberValue) ?? String(self)
    }
    
    func percentage() -> String {
        return String("\(self)%")
    }
}
