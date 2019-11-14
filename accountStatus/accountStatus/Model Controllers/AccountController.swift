//
//  AccountController.swift
//  accountStatus
//
//  Created by RYAN GREENBURG on 11/13/19.
//  Copyright © 2019 RYAN GREENBURG. All rights reserved.
//

import Foundation

struct AccountController {
    
    //let accountCache = NSCache<String, Account>
    
    static func fetchAccountInfo(for route: AccountRoute, completion: @escaping (_ accounts: [Account]?, _ error: Error?) -> Void) {
        
        guard let url = route.fullUrl else {
            print("URL nil")
            completion(nil, nil)
            return
        }
        
        NetworkService.fetchInfo(for: url) { foundData, error  in
            if let error = error {
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                completion(nil, error)
            }
            guard let data = foundData else {
                print("Data is nil in \(#function)")
                completion(nil, nil)
                return
            }
            if let decodedAccounts = self.decodeAccounts(from: data) {
                print("Accounts decoded successfully")
                completion(decodedAccounts, nil)
            }
            print("Unable to decode accounts")
            completion(nil, nil)
        }
    }
    
    private static func decodeAccounts(from data: Data) -> [Account]? {
        do {
            let decoder = JSONDecoder()
            let accounts = try decoder.decode([Account].self, from: data)
            return accounts
        } catch {
            print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
            return nil
        }
    }
}
