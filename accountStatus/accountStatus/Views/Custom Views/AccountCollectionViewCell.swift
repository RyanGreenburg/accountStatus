//
//  AccountCollectionViewCell.swift
//  accountStatus
//
//  Created by RYAN GREENBURG on 11/13/19.
//  Copyright © 2019 RYAN GREENBURG. All rights reserved.
//

import UIKit

class AccountCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var returnOnInvestmentLabel: UILabel!
    
    func updateCell(with account: Account) {
        self.backgroundColor = .secondarySystemBackground
        nameLabel.text = account.name
        amountLabel.text = account.amount.currencyValue()
        returnOnInvestmentLabel.text = account.returnOnInvestment.percentage()
    }
}
