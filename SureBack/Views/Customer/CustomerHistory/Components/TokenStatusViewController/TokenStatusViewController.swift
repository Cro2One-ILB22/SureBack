//
//  TokenStatusViewController.swift
//  SureBack
//
//  Created by Ditha Nurcahya Avianty on 28/11/22.
//

import UIKit

// extension Date {
//    var month: Int? {
//        let components = Calendar.current.dateComponents([.month], from: self)
//        return components.month
//    }
// }

class TokenStatusViewController: UIViewController {
    private var loadingService: LoadingService?
    var page = 1
    var totalPage: Int?

    let request = RequestFunction()
    var merchantData: UserInfoResponse?

    var transactionData: [MyStoryData] = [] {
        didSet {
            tableView.reloadData()
//            dict = Dictionary(grouping: transactionData) { model -> Int in
//                model.updatedAt.stringToDate().month ?? 0
//            }
        }
    }

//    var dict: [Int: [MyStoryData]] = [:]

    var tableView: UITableView = {
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

        loadingService = LoadingService()

        guard let merchantData = merchantData else { return }
        getTokenStatusData(merchantData: merchantData, page: page)
        setupLayout()
    }

    func getTokenStatusData(merchantData: UserInfoResponse, page: Int) {
        //TODO: change request to Get Token where finished_at != nil
        loadingService?.setState(state: .loading)
        request.getMyStoryCustomer(merchantId: merchantData.id, page: page) { [weak self] data in
            guard let self = self else { return }
            switch data {
            case let .success(result):
                do {
                    self.transactionData = result.data.filter {
                        $0.submittedAt == nil && $0.token.expiresAt.stringToDate() < Date() ||
                            $0.submittedAt != nil && $0.instagramStoryStatus == "validated"
                    }
                    self.totalPage = result.lastPage
                    self.tableView.isHidden = false
                    self.loadingIndicator.stopAnimating()
                    self.loadingIndicator.isHidden = true
                    self.loadingService?.setState(state: .success)
//                    if self.transactionData.count == 0 && page < self.totalPage ?? 1 {
//                        self.getTokenStatusData(merchantData: merchantData, page: page+1)
//                    }
                } catch let error as NSError {
                    print(error.description)
                }
            case let .failure(error):
                self.loadingService?.setState(state: .failed)
                print(error)
                print("failed to get list token status in merchant \(merchantData.name)")
            }
        }
    }
}

extension TokenStatusViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if transactionData.count == 0 {
            self.tableView.setEmptyMessage(
                image: UIImage(named: "empty.merchant")!,
                title: "Empty",
                message: "You don’t have any record with us.\nDon’t you want to visit us?",
                centerYAnchorConstant: -50)
        } else {
            self.tableView.restore()
        }
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

    // number of section based on dict keys
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return dict.keys.count
//    }

    // view for header in section
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let view = UIView()
//        view.backgroundColor = .white
//
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.font = UIFont(name: "Poppins-SemiBold", size: 14)
//        label.textColor = .black
//
//        view.addSubview(label)
//
//        NSLayoutConstraint.activate([
//            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
//            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//        ])
//
//        // get key from dict
//        let key = dict.keys.sorted()[section]
//
//        // get value from dict
//        let value = dict[key]
//
//        // set label text
//        // label.text = value?.first?.updatedAt.formatTodMMMyyy()
//
//        //label text only month
//        label.text = value?.first?.updatedAt.formatToMMM()
//
//        return view
//    }

    // number of row based on section
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // get key from dict
//        let key = dict.keys.sorted()[section]
//
//        // get value from dict
//        let value = dict[key]
//
//        return value?.count ?? 0
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: ItemCustomerHistoryTableViewCell.id, for: indexPath) as? ItemCustomerHistoryTableViewCell else { return UITableViewCell() }
//
//        // get key from dict
//        let key = dict.keys.sorted()[indexPath.section]
//
//        // get value from dict
//        let value = dict[key]
//
//        cell.dateLabel.text = value?[indexPath.row].updatedAt.formatTodMMMyyy()
//
//        if value?[indexPath.row].submittedAt == nil {
//            cell.statusImage.image = UIImage(named: "multiply.circle.fill.red")?.sd_tintedImage(with: .red)
//            cell.statusLabel.text = "\(value?[indexPath.row].id ?? 0) - Token Expired"
//        } else {
//            switch value?[indexPath.row].approvalStatus {
//            case 0:
//                cell.statusImage.image = UIImage(named: "multiply.circle.fill.red")?.sd_tintedImage(with: .red)
//                cell.statusLabel.text = "\(value?[indexPath.row].id ?? 0) - Story Rejected"
//
//            case 1:
//                cell.statusImage.image = UIImage(named: "checkmark.circle.fill")?.sd_tintedImage(with: .green)
//                cell.statusLabel.text = "\(value?[indexPath.row].id ?? 0) - Story Approved"
//            default:
//                break
//            }
//        }
//
//        cell.coinsLabel.text = "Rp\(String(value?[indexPath.row].token.purchase?.purchaseAmount ?? 0))"
//
//        return cell
//    }

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
                getTokenStatusData(merchantData: merchantData, page: page)
                tableView.reloadData()
            }
        }
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
