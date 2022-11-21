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
    var transactionData = [Transaction]() {
        didSet {
            tableView.reloadData()
        }
    }

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
        tabBarController?.tabBar.isHidden = true

        guard let user = user, let merchantData = merchantData else {
            return
        }

        self.view.addSubview(self.headerView)
        self.headerView.merchantLabel.text = self.merchantData?.name
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.redeemButtonTapped))
        self.headerView.redeemButton.addGestureRecognizer(tapGesture)
        self.headerView.loyaltCoinsLabel.text = "\(self.merchantData?.coins?[0].outstanding ?? 0) Loyalty Coins"
        self.footerView.totalLabel.text = String(self.merchantData?.coins?[0].allTimeReward ?? 0)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableHeaderView = self.headerView
        self.setupTableView()

        request.getListTransaction(merchantId: merchantData.id) { data in
            switch data {
            case let .success(result):
                do {
                    self.tableView.tableFooterView = self.footerView
                    self.transactionData = result.data
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
        return transactionData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ItemCustomerHistoryTableViewCell.id, for: indexPath) as? ItemCustomerHistoryTableViewCell else { return UITableViewCell() }

        // string to date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = dateFormatter.date(from: transactionData[indexPath.row].updatedAt)
        dateFormatter.dateFormat = "dd MMM yyyy"
        let dateString = dateFormatter.string(from: date!)

        // date to string
        let dateToString = DateFormatter()
        dateToString.dateFormat = "dd/MM/YY"

        cell.categoryLabel.text = transactionData[indexPath.row].category.rawValue
        cell.statusLabel.text = transactionData[indexPath.row].status.rawValue
        cell.coinsLabel.text = String(transactionData[indexPath.row].amount)
        cell.dateLabel.text = dateString

        return cell
    }
}
