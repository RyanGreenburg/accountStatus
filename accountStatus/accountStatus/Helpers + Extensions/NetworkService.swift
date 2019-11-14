//
//  NetworkController.swift
//  accountStatus
//
//  Created by RYAN GREENBURG on 11/13/19.
//  Copyright © 2019 RYAN GREENBURG. All rights reserved.
//

import Foundation

struct NetworkService {
    /**
     Performs a dataTask for a given URL
     
     - Parameters:
        - url: The URL to pass into the dataTask
        - completion: The completion handler to call when the method is complete.
        - data: Optional data returned from the dataTask
        - error: Optional error returned form the dataTask
     */
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
