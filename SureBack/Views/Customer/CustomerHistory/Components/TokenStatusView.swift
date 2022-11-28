//
//  TokenStatusView.swift
//  SureBack
//
//  Created by Ditha Nurcahya Avianty on 22/11/22.
//

import UIKit

class TokenStatusView: UIView {
    var transactionData: [MyStoryData] = [] {
        didSet {
            tableView.reloadData()
            print(transactionData)
            print("condata token: \(transactionData.count)")
            if transactionData.count == 0 {
                self.tableView.setEmptyMessage(
                    image: UIImage(named: "empty.merchant")!,
                    title: "Empty",
                    message: "You don’t have any record with us.\nDon’t you want to visit us?")
//                self.showLoadingIndicator(true)
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
        loading.isHidden = true
        return loading
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        //TODO: not hiding
//        showLoadingIndicator(false)
        tableView.delegate = self
        tableView.dataSource = self
        setupLayout()
        tableView.reloadData()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func showLoadingIndicator(_ isShow: Bool) {
        self.tableView.isHidden = isShow
        loadingIndicator.show(isShow)
    }
}

extension TokenStatusView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactionData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ItemCustomerHistoryTableViewCell.id, for: indexPath) as? ItemCustomerHistoryTableViewCell else { return UITableViewCell() }

        cell.dateLabel.text = transactionData[indexPath.row].updatedAt.formatTodMMMyyy()

        if transactionData[indexPath.row].submittedAt == nil {
            cell.statusImage.image = UIImage(named: "multiply.circle.fill.red")?.sd_tintedImage(with: .red)
            cell.statusLabel.text = "Token Expired"
        } else {
            switch transactionData[indexPath.row].approvalStatus {
            case 0:
                cell.statusImage.image = UIImage(named: "multiply.circle.fill.red")?.sd_tintedImage(with: .red)
                cell.statusLabel.text = "Story Rejected"
            case 1:
                cell.statusImage.image = UIImage(named: "checkmark.circle.fill")?.sd_tintedImage(with: .green)
                cell.statusLabel.text = "Story Accepted"
            default:
                break
            }
        }
        
        cell.coinsLabel.text = "Rp\(transactionData[indexPath.row].token.purchase.purchaseAmount)"

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         
    }
}

extension TokenStatusView {
    private func setupLayout() {
//        setupLoadingIndicator()
        setupTableView()
    }
    private func setupLoadingIndicator() {
        addSubview(loadingIndicator)
        loadingIndicator.setCenterXAnchorConstraint(equalTo: centerXAnchor)
        loadingIndicator.setCenterYAnchorConstraint(equalTo: centerYAnchor)
    }
    private func setupTableView() {
        addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.setTopAnchorConstraint(equalTo: topAnchor, constant: 10)
        tableView.setLeadingAnchorConstraint(equalTo: leadingAnchor, constant: 16)
        tableView.setTrailingAnchorConstraint(equalTo: trailingAnchor, constant: -16)
        tableView.setBottomAnchorConstraint(equalTo: bottomAnchor)
    }
}
