//
//  Account.swift
//  accountStatus
//
//  Created by RYAN GREENBURG on 11/13/19.
//  Copyright © 2019 RYAN GREENBURG. All rights reserved.
//

import Foundation

/**
 Object to hold information gathered from accounts API
 
 */
struct Account : Decodable {
    enum CodingKeys: String, CodingKey {
        case name
        case amount
        case returnOnInvestment = "ROI"
        case id
    }
    /// String value of the name key of the JSON
    let name: String
    /// Double value of the amout key of the JSON
    let amount: Double
    /// Double value of the ROI key of the JSON
    let returnOnInvestment: Double
    /// Int value of the id key of the JSON
    let id: Int
}
