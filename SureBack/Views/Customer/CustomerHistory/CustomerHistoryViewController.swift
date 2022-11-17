//
//  CustomerHistoryViewController.swift
//  SureBack
//
//  Created by Ditha Nurcahya Avianty on 10/11/22.
//

import UIKit

class CustomerHistoryViewController: UIViewController {
    let request = RequestFunction()

    var user: UserInfoResponse?
    var merchantData: UserInfoResponse?
    var transactionData = [Transaction]()

//    var totalRewardsRedeem = 0

    let headerView = HeaderCustomerHistoryView(frame: CGRect(x: 0, y: 0, width: UIScreen.screenWidth, height: 130))
    let footerView = FooterCustomerHistoryView(frame: CGRect(x: 0, y: 0, width: UIScreen.screenWidth, height: 50))

    var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(ItemCustomerHistoryTableViewCell.self, forCellReuseIdentifier: ItemCustomerHistoryTableViewCell.id)
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        guard let user = user, let merchantData = merchantData else {
            return
        }

        request.getListTransaction(merchantId: merchantData.id) { data in
            switch data {
            case let .success(result):
                do {
                    self.view.addSubview(self.headerView)
                    self.headerView.merchantLabel.text = self.merchantData?.name
                    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.redeemButtonTapped))
                    self.headerView.redeemButton.addGestureRecognizer(tapGesture)
                    self.tableView.delegate = self
                    self.tableView.dataSource = self
                    self.tableView.tableHeaderView = self.headerView
                    self.tableView.tableFooterView = self.footerView
                    self.setupTableView()
                    print("result data transactiom: \(result.data)")
                    self.transactionData = result.data
                    self.tableView.reloadData()
                } catch let error as NSError {
                    print(error.description)
                }
            case let .failure(error):
                print(error)
                print("failed to get list transaction in merchant \(merchantData.name)")
            }
        }


    }

    @objc func redeemButtonTapped(sender: UITapGestureRecognizer) {
        print("redeem button tapped")
    }
}

extension CustomerHistoryViewController {
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.setTopAnchorConstraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        tableView.setLeadingAnchorConstraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
        tableView.setTrailingAnchorConstraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        tableView.setBottomAnchorConstraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    }
}

extension CustomerHistoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactionData.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ItemCustomerHistoryTableViewCell.id, for: indexPath) as? ItemCustomerHistoryTableViewCell else { return UITableViewCell() }

        cell.statusLabel.text = transactionData[indexPath.row].category.rawValue
        cell.coinsLabel.text = String(transactionData[indexPath.row].amount)

        return cell
    }
}
