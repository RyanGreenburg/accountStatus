//
//  AccountTableViewController.swift
//  accountStatus
//
//  Created by RYAN GREENBURG on 11/13/19.
//  Copyright © 2019 RYAN GREENBURG. All rights reserved.
//

import UIKit

class AccountTableViewController: UITableViewController {
    
    var accounts: [Account] = [] {
        didSet {
            self.updateViews()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAllAccounts()
    }
    
    func fetchAllAccounts() {
        AccountController.fetchAccountInfo(for: .allAccounts) { (foundAccounts, error) in
            if let error = error {
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
            }
            
            if let foundAccounts = foundAccounts {
                self.accounts = foundAccounts
            }
        }
    }
    
    func updateViews() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return accounts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "accountCell", for: indexPath)
        let account = accounts[indexPath.row]
        
        cell.textLabel?.text = account.name
        cell.detailTextLabel?.text = "\(account.amount)"
        return cell
    }


    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
}
