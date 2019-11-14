//
//  NetworkController.swift
//  accountStatus
//
//  Created by RYAN GREENBURG on 11/13/19.
//  Copyright © 2019 RYAN GREENBURG. All rights reserved.
//

import Foundation

struct NetworkService {
    
    static func fetchInfo(for url: URL, completion: @escaping (_ data: Data?, _ error: Error?) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: url) { (data, nil, error) in
            if let error = error {
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                completion(nil, error)
            }
            guard let unwrappedData = data else {
                print("Data is nil in \(#function)")
                completion(nil, nil)
                return
            }
            completion(unwrappedData, nil)
        }
        dataTask.resume()
        
    }
}
