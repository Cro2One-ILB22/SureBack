//
//  MerchantDashboardViewController.swift
//  SureBack
//
//  Created by Tubagus Adhitya Permana on 09/11/22.
//

import UIKit

class MerchantDashboardViewController: UIViewController {
    var user: UserInfoResponse?

    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(StoryTableViewCell.self, forCellReuseIdentifier: StoryTableViewCell.id)
        table.backgroundColor = .white
        table.separatorColor = UIColor.clear
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Hi, bestie"
        let headerView = HeaderMerchantDashboardView(frame: CGRect(x: 0, y: 0, width: UIScreen.screenWidth, height: 250))
        setupTableView()
        headerView.seeAllCustomersButton.addTarget(self, action: #selector(seeAllCustomers), for: .touchUpInside)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableHeaderView = headerView
    }

    @objc func seeAllCustomers() {
        print("See all customer tapped")
    }
}

extension MerchantDashboardViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StoryTableViewCell.id, for: indexPath) as? StoryTableViewCell else { return UITableViewCell() }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
}

extension MerchantDashboardViewController {
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.setTopAnchorConstraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        tableView.setLeadingAnchorConstraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
        tableView.setTrailingAnchorConstraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        tableView.setBottomAnchorConstraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    }
}
