//
//  AccountDetailViewController.swift
//  accountStatus
//
//  Created by RYAN GREENBURG on 11/13/19.
//  Copyright © 2019 RYAN GREENBURG. All rights reserved.
//

import UIKit

class AccountDetailViewController: UIViewController {
    
    var account: Account?

    @IBOutlet weak var nameLabel: DarkTextLabel!
    @IBOutlet weak var amoutLabel: DarkTextLabel!
    @IBOutlet weak var returnOnInvestmentLabel: DarkTextLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        nameLabel.textColor = .darkText
        amoutLabel.textColor = .darkText
        returnOnInvestmentLabel.textColor = .darkText
    }
    
    @IBAction func dismissButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    // MARK: - Class Methods
    func updateViews() {
        guard let account = account else { return }
        self.view.backgroundColor = account.returnOnInvestment >= 0 ? .customGreen : .customRed
        nameLabel.text = account.name
        amoutLabel.text = account.amount.currencyValue()
        returnOnInvestmentLabel.text = account.returnOnInvestment.percentage()
    }
}
