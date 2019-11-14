//
//  FloatingButton.swift
//  accountStatus
//
//  Created by RYAN GREENBURG on 11/14/19.
//  Copyright © 2019 RYAN GREENBURG. All rights reserved.
//

import UIKit

class FloatingButton: UIButton {
    override func awakeFromNib() {
        self.setTitleColor(.label, for: .normal)
        self.backgroundColor = .systemBackground
        self.addCornerRadius()
        self.addDropShadow()
    }
}
