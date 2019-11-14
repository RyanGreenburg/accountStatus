//
//  AccountListViewController.swift
//  accountStatus
//
//  Created by RYAN GREENBURG on 11/13/19.
//  Copyright © 2019 RYAN GREENBURG. All rights reserved.
//

import UIKit

class AccountListViewController: UIViewController {
    // MARK: - Class Properties
    private var accounts: [Account] = [] {
        didSet {
            self.updateCollectionView(animated: true)
        }
    }
    private var dataSource: UICollectionViewDiffableDataSource<ROISection, Account>?
    // MARK: - Outlets
    @IBOutlet weak var accountCollectionView: UICollectionView!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAllAccounts()
        setUpDataSource()
        updateCollectionView(animated: false)
    }
    
    // MARK: - Class Methods
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
            self.accountCollectionView.reloadData()
        }
    }
}

// MARK: - CollectionView Diffable DataSource
extension AccountListViewController {
    func setUpDataSource() {
        dataSource = UICollectionViewDiffableDataSource<ROISection, Account>(collectionView: accountCollectionView) { (collectionView, indexPath, acount) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "accountCell", for: indexPath) as? AccountCollectionViewCell
            
            cell?.updateCell(with: acount)
            return cell ?? UICollectionViewCell()
        }
    }
    
    func updateCollectionView(animated: Bool) {
        var snapshot = NSDiffableDataSourceSnapshot<ROISection, Account>()
        snapshot.appendSections([.positive, .negative])
        snapshot.appendItems(self.accounts.filter({ $0.returnOnInvestment >= 0 }), toSection: .positive)
        snapshot.appendItems(self.accounts.filter({ $0.returnOnInvestment < 0 }), toSection: .negative)
        
        dataSource?.apply(snapshot)
    }
}