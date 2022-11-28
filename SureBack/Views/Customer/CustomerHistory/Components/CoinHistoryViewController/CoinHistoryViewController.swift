//
//  CoinHistoryViewController.swift
//  SureBack
//
//  Created by Ditha Nurcahya Avianty on 28/11/22.
//

import UIKit

class CoinHistoryViewController: UIViewController {
    let request = RequestFunction()
    var merchantData: UserInfoResponse?

    var transactionData: [Transaction] = [] {
        didSet {
            tableView.reloadData()
            print(transactionData)
            print("condata coin: \(transactionData.count)")
            if transactionData.count == 0 {
                self.tableView.setEmptyMessage(
                    image: UIImage(named: "empty.merchant")!,
                    title: "Empty",
                    message: "You don’t have any record with us.\nDon’t you want to visit us?",
                    centerYAnchorConstant: -50)
            }
        }
    }

    lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.register(ItemCustomerHistoryTableViewCell.self, forCellReuseIdentifier: ItemCustomerHistoryTableViewCell.id)
        table.backgroundColor = .clear
        return table
    }()

    lazy var loadingIndicator: UIActivityIndicatorView = {
        let loading = UIActivityIndicatorView()
        loading.style = .gray
        loading.translatesAutoresizingMaskIntoConstraints = false
        return loading
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

        tableView.isHidden = true
        loadingIndicator.startAnimating()
        loadingIndicator.isHidden = false

        guard let merchantData = merchantData else { return }
        getCoinHistoryData(merchantData: merchantData)
        setupTableView()
    }

    func getCoinHistoryData(merchantData: UserInfoResponse) {
        request.getListTransaction(merchantId: merchantData.id, status: "success") { data in
            switch data {
            case let .success(result):
                print("coin balance data: \(result)")
                do {
                    print(result.data)
                    self.transactionData = result.data
                    self.tableView.isHidden = false
                    self.loadingIndicator.stopAnimating()
                    self.loadingIndicator.isHidden = true
                } catch let error as NSError {
                    print(error.description)
                }
            case let .failure(error):
                print(error)
                print("failed to get list coins balance in merchant \(merchantData.name)")
            }
        }
    }
}

extension CoinHistoryViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactionData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ItemCustomerHistoryTableViewCell.id, for: indexPath) as? ItemCustomerHistoryTableViewCell else { return UITableViewCell() }

        cell.totalPurchaseLabel.isHidden = true
        cell.dateLabel.text = transactionData[indexPath.row].createdAt.formatTodMMMyyy()

        if transactionData[indexPath.row].createdAt.stringToDate() < Date() {
            print(transactionData[indexPath.row].createdAt.stringToDate())
            print("datena: \(Date())")
        }

        switch transactionData[indexPath.row].accountingEntry {
        case .c:
            cell.statusImage.image = UIImage(named: "arrow.down.left.circle.fill")?.sd_tintedImage(with: .green)
            cell.statusLabel.text = "Reward Credited"
            cell.coinsLabel.text = "+\(transactionData[indexPath.row].amount) coins"
        case .d:
            cell.statusImage.image = UIImage(named: "arrow.up.forward.circle.fill")?.sd_tintedImage(with: .red)
            cell.statusLabel.text = "Coins Used"
            cell.coinsLabel.text = "-\(transactionData[indexPath.row].amount) coins"
        }
        return cell
    }
}

extension CoinHistoryViewController {
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.setTopAnchorConstraint(equalTo: view.topAnchor, constant: 10)
        tableView.setLeadingAnchorConstraint(equalTo: view.leadingAnchor, constant: 16)
        tableView.setTrailingAnchorConstraint(equalTo: view.trailingAnchor, constant: -16)
        tableView.setBottomAnchorConstraint(equalTo: view.bottomAnchor)
    }
}
