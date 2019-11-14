//
//  DoubleExtension.swift
//  accountStatus
//
//  Created by RYAN GREENBURG on 11/13/19.
//  Copyright © 2019 RYAN GREENBURG. All rights reserved.
//

import Foundation

extension Double {
    /// Returns a string formatted for currency
    func currencyValue() -> String {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = Locale.current
        let numberValue = NSNumber(value: self)
        
        return currencyFormatter.string(from: numberValue) ?? String(self)
    }
    
    /// Returns a string with the double and an added percent sign
    func percentage() -> String {
        return String("\(self)%")
    }
}
