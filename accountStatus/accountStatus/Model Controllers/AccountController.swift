//
//  AccountController.swift
//  accountStatus
//
//  Created by RYAN GREENBURG on 11/13/19.
//  Copyright © 2019 RYAN GREENBURG. All rights reserved.
//

import Foundation

struct AccountController {
    
    func fetchAccounts(for route: AccountRoute, completion: @escaping (_ accounts: [Account]?, _ error: Error?) -> Void) {
        
        guard let url = route.fullUrl else {
            completion(nil, nil)
            return
        }
        
        NetworkService.fetchInfo(for: url) { foundData, error  in
            if let error = error {
                completion(nil, error)
            }
            guard let data = foundData else {
                completion(nil, nil)
                return
            }
            if let decodedAccounts = self.decodeAccounts(from: data) {
                completion(decodedAccounts, nil)
            }
            completion(nil, nil)
        }
    }
    
    private func decodeAccounts(from data: Data) -> [Account]? {
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
