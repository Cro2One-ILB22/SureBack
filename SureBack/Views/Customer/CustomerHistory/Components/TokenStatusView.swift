//
//  TokenStatusView.swift
//  SureBack
//
//  Created by Ditha Nurcahya Avianty on 22/11/22.
//

import UIKit

class TokenStatusView: UIView {
    var transactionData: [MyStoryData] = []
    {
        didSet {
            tableView.reloadData()
            print(transactionData)
            print("condata token: \(transactionData.count)")
            if transactionData.count == 0 {
                self.tableView.setEmptyMessage(
                    image: UIImage(named: "empty.merchant")!,
                    title: "Empty",
                    message: "You don’t have any record with us.\nDon’t you want to visit us?")
            }
        }
    }
    lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.register(ItemCustomerHistoryTableViewCell.self, forCellReuseIdentifier: ItemCustomerHistoryTableViewCell.id)
        table.backgroundColor = .clear
        return table
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        tableView.delegate = self
        tableView.dataSource = self
        setupTableView()

        tableView.reloadData()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TokenStatusView: UITableViewDataSource, UITableViewDelegate {
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

        cell.dateLabel.text = dateString

        cell.statusImage.image = UIImage(named: "arrow.down.left.circle.fill")?.sd_tintedImage(with: .green)
        cell.statusLabel.text = "\(transactionData[indexPath.row].approvalStatus)"
        cell.coinsLabel.text = "Rp\(transactionData[indexPath.row].token.purchase.purchaseAmount)"

        return cell
    }
}

extension TokenStatusView {
    private func setupTableView() {
        addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.setTopAnchorConstraint(equalTo: topAnchor, constant: 10)
        tableView.setLeadingAnchorConstraint(equalTo: leadingAnchor, constant: 16)
        tableView.setTrailingAnchorConstraint(equalTo: trailingAnchor, constant: -16)
        tableView.setBottomAnchorConstraint(equalTo: bottomAnchor)
    }
}
