//
//  CoinHistoryViewController.swift
//  SureBack
//
//  Created by Ditha Nurcahya Avianty on 28/11/22.
//

import UIKit

class CoinHistoryViewController: UIViewController {
    private var loadingService: LoadingService?
    var page = 1
    var totalPage: Int?

    let request = RequestFunction()
    var merchantData: UserInfoResponse?

    var transactionData: [Transaction] = [] {
        didSet {
            tableView.reloadData()
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

    private func createSpinnerFooter() -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 70))
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        spinner.startAnimating()
        return footerView
    }

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

        loadingService = LoadingService()

        guard let merchantData = merchantData else { return }
        getCoinHistoryData(merchantData: merchantData, page: page)
        setupLayout()
    }

    func getCoinHistoryData(merchantData: UserInfoResponse, page: Int) {
        loadingService?.setState(state: .loading)
        request.getListTransaction(merchantId: merchantData.id, status: "success", page: page) { [weak self] data in
            guard let self = self else {return}
            switch data {
            case let .success(result):
                do {
                    print(result.data)
                    self.transactionData = result.data
                    self.totalPage = result.lastPage
                    self.tableView.isHidden = false
                    self.loadingIndicator.stopAnimating()
                    self.loadingIndicator.isHidden = true
                    self.loadingService?.setState(state: .success)
                } catch let error as NSError {
                    print(error.description)
                }
            case let .failure(error):
                self.loadingService?.setState(state: .failed)
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

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let transactionDetailVC = TransactionDetailViewController()
        transactionDetailVC.title = "Coin Balance History Detail"
        transactionDetailVC.configureCoin(transactionData[indexPath.row])
        navigationController?.pushViewController(transactionDetailVC, animated: true)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        tableView.tableFooterView = createSpinnerFooter()

        guard loadingService?.loadingState == .success || loadingService?.loadingState == .failed else { return }

        tableView.tableFooterView = nil

        guard let totalPage = totalPage else { return }

        if offsetY > contentHeight - scrollView.frame.height {
            if page <= (totalPage - 1) {
                page += 1
                guard let merchantData = merchantData else { return }
                getCoinHistoryData(merchantData: merchantData, page: page)
                tableView.reloadData()
            }
        }
    }
}

extension CoinHistoryViewController {
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
