//
//  AccountCollectionViewCell.swift
//  accountStatus
//
//  Created by RYAN GREENBURG on 11/13/19.
//  Copyright © 2019 RYAN GREENBURG. All rights reserved.
//

import UIKit

class AccountCollectionViewCell: UICollectionViewCell {
    
    override func awakeFromNib() {
        self.clipsToBounds = true
        self.addCornerRadius()
        returnOnInvestmentLabel.addCornerRadius(self.contentView.frame.height / 10)
        returnOnInvestmentLabel.clipsToBounds = true
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var returnOnInvestmentLabel: DarkTextLabel!
    
    func updateCell(with account: Account) {
        self.backgroundColor = .secondarySystemBackground
        nameLabel.text = account.name
        amountLabel.text = account.amount.currencyValue()
        returnOnInvestmentLabel.text = account.returnOnInvestment.percentage()
        returnOnInvestmentLabel.backgroundColor = account.returnOnInvestment >= 0 ? .customGreen : .customRed
    }
}
