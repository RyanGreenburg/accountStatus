//
//  UIColorExtension.swift
//  accountStatus
//
//  Created by RYAN GREENBURG on 11/14/19.
//  Copyright © 2019 RYAN GREENBURG. All rights reserved.
//

import UIKit

extension UIColor {
    static var customGreen: UIColor {
        if #available(iOS 13, *) {
            return UIColor { (traitCollection: UITraitCollection) -> UIColor in
                if traitCollection.userInterfaceStyle == .dark {
                    return .green
                } else {
                    return .systemGreen
                }
            }
        } else {
            return .systemGreen
        }
    }
    
    static var customRed: UIColor {
        if #available(iOS 13, *) {
            return UIColor { (traitCollection: UITraitCollection) -> UIColor in
                if traitCollection.userInterfaceStyle == .dark {
                    return .red
                } else {
                    return .systemRed
                }
            }
        } else {
            return .systemRed
        }
    }
}
