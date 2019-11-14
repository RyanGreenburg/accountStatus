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
    private var cellHeight: CGFloat {
        return view.frame.height >= 500 ? (self.view.frame.height / 6) : (self.view.frame.height / 3)
    }
    private var horizontalBuffer: CGFloat {
        return self.view.frame.width / 20
    }
    private var verticalBuffer: CGFloat {
        return self.view.frame.height / 50
    }
    private var accounts: [Account] = [] {
        didSet {
            self.updateCollectionView(animated: true)
            self.findTotal()
        }
    }
    private var dataSource: UICollectionViewDiffableDataSource<ROISection, Account>?
    // MARK: - Outlets
    @IBOutlet weak var accountCollectionView: UICollectionView!
    @IBOutlet weak var totalBalanceLabel: UILabel!
    @IBOutlet weak var totalsStackView: UIStackView!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "My Accounts"
        navigationController?.navigationBar.prefersLargeTitles = true
        setViewsForDeviceType()
        fetchAllAccounts()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        layoutCollectionView()
    }
    
    // MARK: - Class Methods
    func setViewsForDeviceType() {
        if UIDevice.current.userInterfaceIdiom == .pad {
            totalBalanceLabel.isHidden = false
            totalsStackView.isHidden = false
        } else {
            totalBalanceLabel.isHidden = true
            totalsStackView.isHidden = true
        }
        configureCollectionView()
    }
    
    func findTotal() {
        DispatchQueue.main.async {
            let amounts = self.accounts.map({ $0.amount })
            let total = amounts.reduce(Double(), +)
            self.totalBalanceLabel.text = "Accounts Total:\n\(total.currencyValue())"
        }
    }
    
    func configureCollectionView() {
        accountCollectionView.delegate = self
        layoutCollectionView()
        setUpDataSource()
    }
    
    func layoutCollectionView() {
        let section = createSectionLayout()
        let layout = createLayout(with: section)
        accountCollectionView.setCollectionViewLayout(layout, animated: false)
        accountCollectionView.layoutIfNeeded()
    }
    
    func fetchAllAccounts() {
        AccountController.fetchAccountInfo(for: .allAccounts) { (foundAccounts, error) in
            if let error = error {
                self.presentErrorAllert(for: error)
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
    
    func createLayout(with sectionLayout: NSCollectionLayoutSection) -> UICollectionViewLayout {
        let section = sectionLayout
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        configuration.interSectionSpacing = 20
        let layout = UICollectionViewCompositionalLayout(section: section, configuration: configuration)
        return layout
    }
    
    func createSectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .fractionalHeight(1))
        
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: horizontalBuffer, bottom: 0, trailing: -horizontalBuffer)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(cellHeight))
        
        let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [layoutItem])
        
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.interGroupSpacing = verticalBuffer
        
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
