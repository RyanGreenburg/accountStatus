//
//  UIViewExtension.swift
//  accountStatus
//
//  Created by RYAN GREENBURG on 11/14/19.
//  Copyright © 2019 RYAN GREENBURG. All rights reserved.
//

import UIKit

extension UIView {
    func addCornerRadius(_ radius: CGFloat = 8) {
        self.layer.cornerRadius = radius
    }
    
    func addDropShadow(_ size: CGSize = CGSize(width: 0, height: 1.0), _ opacity: Double = 0.5, _ radius: Float = 8) {
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowOffset = size
        layer.shadowOpacity = radius
    }
}
