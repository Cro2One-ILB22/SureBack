//
//  TokenStatusViewController.swift
//  SureBack
//
//  Created by Ditha Nurcahya Avianty on 28/11/22.
//

import UIKit

class TokenStatusViewController: UIViewController {
    let request = RequestFunction()
    var merchantData: UserInfoResponse?

    var transactionData: [MyStoryData] = [] {
        didSet {
            tableView.reloadData()
            print(transactionData)
            print("condata token: \(transactionData.count)")
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
        loading.isHidden = true
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
        getTokenStatusData(merchantData: merchantData)
        setupLayout()
    }

    func getTokenStatusData(merchantData: UserInfoResponse) {
        request.getMyStoryCustomer(merchantId: merchantData.id) { data in
            switch data {
            case let .success(result):
                do {
                    for i in result.data {
                        if i.submittedAt == nil {
                            if i.token.expiresAt.stringToDate() < Date() {
                                self.transactionData.append(i)
                            }
                        } else {
                            if i.instagramStoryStatus == "validated" {
                                self.transactionData.append(i)
                            }
                        }
                    }
                    self.tableView.isHidden = false
                    self.loadingIndicator.stopAnimating()
                    self.loadingIndicator.isHidden = true
                } catch let error as NSError {
                    print(error.description)
                }
            case let .failure(error):
                print(error)
                print("failed to get list token status in merchant \(merchantData.name)")
            }
        }
    }
}

extension TokenStatusViewController: UITableViewDataSource, UITableViewDelegate {
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
                cell.statusLabel.text = "Story Approved"
            default:
                break
            }
        }

        cell.coinsLabel.text = "Rp\(String(transactionData[indexPath.row].token.purchase?.purchaseAmount ?? 0))"

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        var status = ""

        if transactionData[indexPath.row].submittedAt == nil {
            status = "expired"
        } else {
            switch transactionData[indexPath.row].approvalStatus {
            case 0:
                status = "rejected"
            case 1:
                status = "approved"
            default:
                break
            }
        }

        let transactionDetailVC = TransactionDetailViewController()
        transactionDetailVC.title = "Token Status History Detail"
        transactionDetailVC.configureToken(transactionData[indexPath.row], status: status)
        navigationController?.pushViewController(transactionDetailVC, animated: true)

    }
}

extension TokenStatusViewController {
    private func setupLayout() {
        setupLoadingIndicator()
        setupTableView()
    }

    private func setupLoadingIndicator() {
        view.addSubview(loadingIndicator)
        loadingIndicator.setCenterXAnchorConstraint(equalTo: view.centerXAnchor)
        loadingIndicator.setCenterYAnchorConstraint(equalTo: view.centerYAnchor)
    }

    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.setTopAnchorConstraint(equalTo: view.topAnchor, constant: 10)
        tableView.setLeadingAnchorConstraint(equalTo: view.leadingAnchor, constant: 16)
        tableView.setTrailingAnchorConstraint(equalTo: view.trailingAnchor, constant: -16)
        tableView.setBottomAnchorConstraint(equalTo: view.bottomAnchor)
    }
}
