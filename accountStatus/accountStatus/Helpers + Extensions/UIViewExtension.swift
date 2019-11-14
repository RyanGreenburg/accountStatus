//
//  UIViewExtension.swift
//  accountStatus
//
//  Created by RYAN GREENBURG on 11/14/19.
//  Copyright © 2019 RYAN GREENBURG. All rights reserved.
//

import UIKit

extension UIView {
    /// Adds a corner radius to a view with a passed in CGFloat or default value of 8
    func addCornerRadius(_ radius: CGFloat = 8) {
        self.layer.cornerRadius = radius
    }
    /**
     Adds a drop shadow to a view
     
     - Parameters:
        - size: The CGSize of the shadow
        - opacity: Float value to use for the opacity of the shadow
        - radius: CGFloat value of the radius for the shadow
     */
    func addDropShadow(_ size: CGSize = CGSize(width: 0, height: 1.0), _ opacity: Float = 0.5, _ radius: CGFloat = 8) {
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowOffset = size
        layer.shadowOpacity = opacity
        layer.shadowRadius = radius
    }
}
