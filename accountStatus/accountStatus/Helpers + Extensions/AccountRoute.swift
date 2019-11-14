//
//  AccountConstants.swift
//  accountStatus
//
//  Created by RYAN GREENBURG on 11/13/19.
//  Copyright © 2019 RYAN GREENBURG. All rights reserved.
//

import Foundation

enum AccountRoute {
    /// Static constant containing the base URL for the Accounts API
    static let baseURL = "https://glacial-bayou-77287.herokuapp.com/"
    /// 
    case allAccounts
    
    var path: String {
        switch self {
        case .allAccounts:
            return "listAccounts"
        }
    }
    
        
    var fullUrl: URL? {
        guard let url = URL(string: AccountRoute.baseURL)?.appendingPathComponent(path) else { return nil }
        
        let components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        
        return components?.url
    }
}
