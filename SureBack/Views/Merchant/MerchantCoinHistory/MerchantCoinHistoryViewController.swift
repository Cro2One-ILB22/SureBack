//
//  MerchantCoinHistoryViewController.swift
//  SureBack
//
//  Created by Tubagus Adhitya Permana on 18/11/22.
//

import UIKit

// MARK: BELOM SELESAI
class MerchantCoinHistoryViewController: UIViewController {
    var merchant: MerchantDetailResponse?
    private var listTransaction: [Transaction] = []
    private let apiRequest = RequestFunction()
    let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(ItemCustomerHistoryTableViewCell.self, forCellReuseIdentifier: ItemCustomerHistoryTableViewCell.id)
        table.backgroundColor = .porcelain
        table.separatorColor = UIColor.clear
        return table
    }()
    let loadingIndicator: UIActivityIndicatorView = {
        let loading = UIActivityIndicatorView()
        loading.style = .gray
        loading.isHidden = true
        return loading
    }()
    var snackBarMessage: SnackBarMessage?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
        configTableView()
        getTransaction()
        snackBarMessage = SnackBarMessage(view: view)
    }
    private func getTransaction() {
        showLoadingIndicator(true)
        apiRequest.getListTransaction {[weak self] data, statusCode in
            guard let self = self else {return}
            guard let statusCode = statusCode else {return}
            self.showLoadingIndicator(false)
            if statusCode != 200 {
                self.snackBarMessage?.showResponseMessage(statusCode: statusCode)
                return
            }
            self.listTransaction = data?.data ?? []
        }
    }
    private func showLoadingIndicator(_ isShow: Bool) {
        self.tableView.isHidden = isShow
        self.loadingIndicator.show(isShow)
        self.loadingIndicator.isHidden = !isShow
    }
    private func configTableView() {
        let headerView = HeaderCoinHistoryView(frame: CGRect(x: 0, y: 0, width: UIScreen.screenWidth, height: 270))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableHeaderView = headerView
        tableView.register(SectionMonth.self, forHeaderFooterViewReuseIdentifier: SectionMonth.id)
    }
}

extension MerchantCoinHistoryViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if listTransaction.isEmpty {
            self.tableView.setEmptyMessage(
                image: UIImage(named: "empty.customers")!,
                title: "Kosong",
                message: "Kosong ini datanya bro",
                centerYAnchorConstant: 100)
        } else {
            self.tableView.restore()
        }
        return listTransaction.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ItemCustomerHistoryTableViewCell.id, for: indexPath) as? ItemCustomerHistoryTableViewCell else { return UITableViewCell() }

        cell.totalPurchaseLabel.isHidden = true
        cell.backgroundColor = .porcelain
        return cell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: SectionMonth.id) as? SectionMonth else {return UIView()}
        view.monthLabel.text = "This Month"
        return view
    }
}
