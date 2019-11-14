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
    /// Case that will build URL for all accounts
    case allAccounts
    /// Computed string value of pathExtensions for needed endpoints
    var path: String {
        switch self {
        case .allAccounts:
            return "listAccounts"
        }
    }
    
    /// Computed URL that builds a url for the given case
    var fullUrl: URL? {
        guard let url = URL(string: AccountRoute.baseURL)?.appendingPathComponent(path) else { return nil }
        
        let components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        
        return components?.url
    }
}
