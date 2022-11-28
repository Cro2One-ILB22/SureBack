//
//  CustomerNotificationViewController.swift
//  SureBack
//
//  Created by Ditha Nurcahya Avianty on 27/11/22.
//

import UIKit

struct CustomerNotificationsData {
    var isHidden: Bool
    var tokenHistoryData: Token
}

class CustomerNotificationViewController: UIViewController {

    var user: UserInfoResponse?
    var custNotifData = [CustomerNotificationsData]() {
        didSet {
            tableView.reloadData()
        }
    }

    var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(ItemNotifTableViewCell.self, forCellReuseIdentifier: ItemNotifTableViewCell.id)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .clear
        return table
    }()

    var loadingIndicator: UIActivityIndicatorView = {
        let loading = UIActivityIndicatorView()
        loading.style = .gray
        loading.translatesAutoresizingMaskIntoConstraints = false
        loading.hidesWhenStopped = true
        return loading
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tabBarController?.tabBar.isHidden = true
        tableView.isHidden = true
        loadingIndicator.show(true)
        setupLayout()
        getNotificationsData()
    }

    func getNotificationsData() {
        let request = RequestFunction()
        request.getListToken { data in
            switch data {
            case let .success(result):
                do {
                    for i in result.data {
                        self.custNotifData.append(CustomerNotificationsData(isHidden: true, tokenHistoryData: i))
                    }
                    // TODO: why loading indicator can not be hide!
                    self.tableView.isHidden = false
                    //                        self?.loadingIndicator.show(false)
                    self.loadingIndicator.stopAnimating()
                    self.loadingIndicator.isHidden = true
                } catch let error as NSError {
                    print(error.description)
                }
            case let .failure(error):
                print(error)
                print("failed to get notif data")
            }
        }
    }
}

extension CustomerNotificationViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return custNotifData.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let isHidden = custNotifData[section].isHidden
        if isHidden {
            return 0
        }
        return custNotifData[section].tokenHistoryData.statusHistory.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: ItemNotifTableViewCell.id, for: indexPath) as? ItemNotifTableViewCell else { return UITableViewCell() }

        cell.configure(custNotifData[indexPath.section].tokenHistoryData.statusHistory[indexPath.row], index: indexPath.row, allData: custNotifData[indexPath.section])

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "sectionHeader") as! SectionNotifHeader // swiftlint:disable:this force_cast

        view.expandButton.tag = section
        view.configure(custNotifData[section])
        view.expandButton.addTarget(self, action: #selector(collapse), for: .touchUpInside)

        return view
    }

    @objc func collapse(sender: UIButton) {
        var selectedSection = custNotifData[sender.tag]
        selectedSection.isHidden = !selectedSection.isHidden
        custNotifData[sender.tag] = selectedSection
        tableView.reloadData()
    }
}

extension CustomerNotificationViewController {
    func setupLayout() {
        setupTableView()
        setupLoadingIndicator()
    }

    private func setupLoadingIndicator() {
        view.addSubview(loadingIndicator)
        loadingIndicator.setCenterXAnchorConstraint(equalTo: view.centerXAnchor)
        loadingIndicator.setCenterYAnchorConstraint(equalTo: view.centerYAnchor)
    }

    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(SectionNotifHeader.self, forHeaderFooterViewReuseIdentifier: "sectionHeader")
        view.addSubview(tableView)
        tableView.setTopAnchorConstraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10)
        tableView.setLeadingAnchorConstraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
        tableView.setTrailingAnchorConstraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        tableView.setBottomAnchorConstraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    }
}
