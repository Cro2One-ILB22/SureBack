//
//  MerchantDetailStoryViewController.swift
//  SureBack
//
//  Created by Tubagus Adhitya Permana on 17/11/22.
//

import UIKit

class MerchantDetailStoryViewController: UIViewController {
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(ListCustomerStoryTableViewCell.self, forCellReuseIdentifier: ListCustomerStoryTableViewCell.id)
        table.backgroundColor = .white
        table.separatorColor = UIColor.clear
        return table
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let headerView = HeaderMerchantDetailStoryView(frame: CGRect(x: 0, y: 0, width: UIScreen.screenWidth, height: 120))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableHeaderView = headerView
        setupTableView()
    }
}

extension MerchantDetailStoryViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListCustomerStoryTableViewCell.id, for: indexPath) as? ListCustomerStoryTableViewCell else { return UITableViewCell() }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 600
    }
}

extension MerchantDetailStoryViewController {
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.setTopAnchorConstraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        tableView.setLeadingAnchorConstraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
        tableView.setTrailingAnchorConstraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        tableView.setBottomAnchorConstraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    }
}
