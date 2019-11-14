//
//  UIViewControllerExtension.swift
//  accountStatus
//
//  Created by RYAN GREENBURG on 11/13/19.
//  Copyright © 2019 RYAN GREENBURG. All rights reserved.
//

import UIKit

extension UIViewController {
    /**
     Presents an alertController when an error occurs to inform the user that there was a problem
     
     - Parameters:
        - error: The error that occured
     */
    func presentErrorAllert(for error: Error) {
        let title = error.localizedDescription
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel)
        alert.addAction(action)
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    /// Presents an alertController to inform the user that something went wrong when parsing data
    func presentParseAlert() {
        let alert = UIAlertController(title: "There was an error fetching your account information", message: "Pull down to refresh and try again", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel)
        alert.addAction(action)
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
}
