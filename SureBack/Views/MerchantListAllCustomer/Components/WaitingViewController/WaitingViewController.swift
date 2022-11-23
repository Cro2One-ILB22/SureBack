//
//  SegmentedControlView.swift
//  SureBack
//
//  Created by Tubagus Adhitya Permana on 21/11/22.
//

import UIKit

class WaitingViewController: UIViewController {
    var listUserStory: [MyStoryData] = []
    lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.register(ItemCustomerStoryTableCell.self, forCellReuseIdentifier: ItemCustomerStoryTableCell.id)
        table.backgroundColor = .white
        table.separatorColor = UIColor.clear
        return table
    }()
    lazy var searchBar: UISearchBar = {
        let search = UISearchBar()
        search.searchBarStyle = .default
        search.placeholder = "Search.."
        search.sizeToFit()
        return search
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
        tableView.isHidden = true
        tableView.delegate = self
        tableView.dataSource = self
        loadingIndicator.show(true)
        getWaitingStoryCustomer()
        setupLayout()
    }
    private func getWaitingStoryCustomer() {
//        try! KeychainHelper.standard.save(key: .accessToken, value: "158|aZv8kOUYRdqVtYFA7yCScXbqybST2oMaostKG4Pb")
        let rf = RequestFunction()
        rf.getMyStory(submitted: true) { data in
            self.listUserStory = data.data
            self.tableView.reloadData()
            self.tableView.isHidden = false
            self.loadingIndicator.show(false)
        }
    }
}

extension WaitingViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        if listUserStory.count == 0 {
            self.tableView.setEmptyMessage(
                image: UIImage(named: "empty.customers")!,
                title: "Empty Customer",
                message: "No customers mentioned you at this time. Don't worry, Let's find them!")
        } else {
            self.tableView.restore()
        }
        return listUserStory.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ItemCustomerStoryTableCell.id, for: indexPath) as? ItemCustomerStoryTableCell else {return UITableViewCell()}
        cell.isHistory = false
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 93
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = UIView()
        footer.backgroundColor = .clear
        footer.isOpaque = false
        return footer
    }
}
