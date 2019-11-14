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
        configureCollectionView()
    }
    
    // MARK: - Class Methods
    func configureCollectionView() {
        accountCollectionView.delegate = self
        let layout = createLayout()
        accountCollectionView.setCollectionViewLayout(layout, animated: false)
        fetchAllAccounts()
        setUpDataSource()
        updateCollectionView(animated: false)
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
            self.accountCollectionView.reloadData()
        }
    }
    
    func showDetailView(for account: Account) {
        let storyboard = UIStoryboard(name: "AccountDetail", bundle: nil)
        guard let viewController = storyboard.instantiateInitialViewController() as? AccountDetailViewController else { return }
        viewController.account = account
        self.present(viewController, animated: true)
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
    
    func createLayout() -> UICollectionViewLayout {
        let section = createSectionLayout()
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        configuration.interSectionSpacing = 20
        let layout = UICollectionViewCompositionalLayout(section: section, configuration: configuration)
        return layout
    }
    
    func createSectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(self.view.frame.height / 10))
        
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50))
        
        let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [layoutItem])
        
        
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.interGroupSpacing = self.view.frame.height / 50
        return layoutSection
    }
}

extension AccountListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let dataSource = dataSource,
            let account = dataSource.itemIdentifier(for: indexPath)
            else { return }
        showDetailView(for: account)
    }
}
