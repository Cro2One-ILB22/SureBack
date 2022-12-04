//
//  SegmentedControlView.swift
//  SureBack
//
//  Created by Tubagus Adhitya Permana on 21/11/22.
//

import UIKit

class WaitingViewController: UIViewController {
    var listUserStory: [MyStoryData] = []
    private let apiRequest = RequestFunction()
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
    var snackBarMessage: SnackBarMessage?
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        showLoadingIndicator(true)
        tableView.delegate = self
        tableView.dataSource = self
        getWaitingStoryCustomer()
        setupLayout()
        snackBarMessage = SnackBarMessage(view: view)
    }
    private func getWaitingStoryCustomer(search customerName: String = "") {
        apiRequest.getCustomerStory(submitted: true, searchCustomerByName: customerName) {[weak self] data, statusCode in
            guard let self = self else {return}
            guard let statusCode = statusCode else {return}
            if statusCode != 200 {
                self.snackBarMessage?.showResponseMessage(statusCode: statusCode)
                return
            }
            self.listUserStory = data?.data ?? []
            self.tableView.reloadData()
            self.showLoadingIndicator(false)
        }
    }
    private func showLoadingIndicator(_ isShow: Bool) {
        self.tableView.isHidden = isShow
        loadingIndicator.show(isShow)
    }
}

extension WaitingViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        showLoadingIndicator(true)
        getWaitingStoryCustomer(search: searchText)
    }
}

extension WaitingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailStoryVC = MerchantDetailStoryViewController()
        let storyData = listUserStory[indexPath.row]
        detailStoryVC.storyData = storyData
        navigationController?.pushViewController(detailStoryVC, animated: true)
    }
}

extension WaitingViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        if listUserStory.count == 0 {
            self.tableView.setEmptyMessage(
                image: UIImage(named: "empty.customers")!,
                title: "Empty Customer",
                message: "No customers mentioned you at this time. Don't worry, Let's find them!",
                centerYAnchorConstant: -70
            )
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
