//
//  CustomerListAllMerchantViewController.swift
//  SureBack
//
//  Created by Ditha Nurcahya Avianty on 23/11/22.
//

import UIKit
import SDWebImage

class CustomerListAllMerchantViewController: UIViewController {
    var user: UserInfoResponse?
    var merchantData = [UserInfoResponse]()
    var activeTokenData = [Token]()

    lazy var searchBar: UISearchBar = {
        let search = UISearchBar()
        search.searchBarStyle = .default
        search.placeholder = "Search.."
        search.sizeToFit()
        return search
    }()

    lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(ItemMerchantTableViewCell.self, forCellReuseIdentifier: ItemMerchantTableViewCell.id)
        table.backgroundColor = .white
        table.separatorColor = .clear
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true
        setupSearch()
        setupView()
    }
}

extension CustomerListAllMerchantViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if merchantData.count == 0 {
            self.tableView.setEmptyMessage(
                image: UIImage(named: "empty.merchant")!,
                title: "Empty Merchant",
                message: "Let’s Get Going! Which Merchant will be your First Visit?")
        } else {
            self.tableView.restore()
        }
        return merchantData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ItemMerchantTableViewCell.id, for: indexPath) as? ItemMerchantTableViewCell else { return UITableViewCell() }

        cell.selectionStyle = .none

        cell.merchantImage.sd_imageIndicator = SDWebImageActivityIndicator.gray
        cell.merchantImage.sd_setImage(
            with: URL(string: merchantData[indexPath.row].profilePicture),
            placeholderImage: UIImage(named: "system.photo"),
            options: .progressiveLoad,
            completed: nil
        )
        cell.merchantNameLabel.text = merchantData[indexPath.row].name
        cell.totalCoinsLabel.text = "\(merchantData[indexPath.row].balance) coin(s)"
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let merchantDetailVC = CustomerHistoryViewController()
        merchantDetailVC.title = "Merchant"
        merchantDetailVC.user = user
        merchantDetailVC.merchantData = merchantData[indexPath.row]
        for i in activeTokenData {
            if i.merchant.id == merchantData[indexPath.row].id {
                merchantDetailVC.tokenData = i
                break
            }
        }
        navigationController?.pushViewController(merchantDetailVC, animated: true)
    }
}

extension CustomerListAllMerchantViewController {
    private func setupView() {
        setupTableView()
        tableView.delegate = self
        tableView.dataSource = self
    }

    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.setTopAnchorConstraint(equalTo: searchBar.bottomAnchor)
        tableView.setLeadingAnchorConstraint(equalTo: view.leadingAnchor, constant: 15)
        tableView.setTrailingAnchorConstraint(equalTo: view.trailingAnchor, constant: -15)
        tableView.setBottomAnchorConstraint(equalTo: view.bottomAnchor)
    }

    private func setupSearch() {
        view.addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.setTopAnchorConstraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10)
        searchBar.setLeadingAnchorConstraint(equalTo: view.leadingAnchor, constant: 15)
        searchBar.setTrailingAnchorConstraint(equalTo: view.trailingAnchor, constant: -15)
    }
}
