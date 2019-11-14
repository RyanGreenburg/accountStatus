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

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var amoutLabel: UILabel!
    @IBOutlet weak var returnOnInvestmentLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    @IBAction func dismissButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    // MARK: - Class Methods
    func updateViews() {
        guard let account = account else { return }
        self.view.backgroundColor = account.returnOnInvestment >= 0 ? .systemGreen : .systemRed
        self.view.backgroundColor?.withAlphaComponent(90)
        nameLabel.text = account.name
        amoutLabel.text = account.amount.currencyValue()
        returnOnInvestmentLabel.text = account.returnOnInvestment.percentage()
    }
}
