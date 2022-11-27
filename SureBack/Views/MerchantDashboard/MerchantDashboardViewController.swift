//
//  MerchantDashboardViewController.swift
//  SureBack
//
//  Created by Tubagus Adhitya Permana on 09/11/22.
//

import UIKit

class MerchantDashboardViewController: UIViewController {
    var user: UserInfoResponse?
    var listCustomerStory: [MyStoryData] = []

    let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(StoryTableViewCell.self, forCellReuseIdentifier: StoryTableViewCell.id)
        table.backgroundColor = .porcelain
        table.separatorColor = UIColor.clear
        return table
    }()
    let loadingIndicator: UIActivityIndicatorView = {
        let loading = UIActivityIndicatorView()
        loading.style = .gray
        loading.translatesAutoresizingMaskIntoConstraints = false
        loading.isHidden = true
        return loading
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Hi, bestie"
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.isHidden = true
        loadingIndicator.show(true)
        configTableView()
        getCustomerStory()
        setupLayout()
    }

    @objc func seeAllCustomers() {
        print("See all customer tapped")
    }
    private func getCustomerStory() {
        let rf = RequestFunction()
        rf.getCustomerStory { data in
            self.listCustomerStory = data.data
            self.tableView.isHidden = false
            self.loadingIndicator.show(false)
            self.loadingIndicator.isHidden = true
            self.tableView.reloadData()
        }
    }
    private func configTableView() {
        let headerView = HeaderMerchantDashboardView(frame: CGRect(x: 0, y: 0, width: UIScreen.screenWidth, height: 250))
        headerView.seeAllCustomersButton.addTarget(self, action: #selector(seeAllCustomers), for: .touchUpInside)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableHeaderView = headerView
    }
}

extension MerchantDashboardViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if listCustomerStory.count == 0 {
            self.tableView.setEmptyMessage(
                image: UIImage(named: "empty.customers")!,
                title: "Empty Customer",
                message: "No customers mentioned you at this time. Don't worry, Let's find them!")
            return 0
        } else {
            self.tableView.restore()
            return 1
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StoryTableViewCell.id, for: indexPath) as? StoryTableViewCell else { return UITableViewCell() }
        cell.listCustomerStory = self.listCustomerStory
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
}
