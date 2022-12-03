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

    let request = RequestFunction()

    var user: UserInfoResponse?
    var custNotifData = [CustomerNotificationsData]() {
        didSet {
            tableView.reloadData()
        }
    }

    private var loadingService: LoadingService?
    var page = 1
    var totalPage: Int?

    var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(ItemNotifTableViewCell.self, forCellReuseIdentifier: ItemNotifTableViewCell.id)
        table.translatesAutoresizingMaskIntoConstraints = false
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
        loadingService = LoadingService()
        tableView.isHidden = true
        loadingIndicator.show(true)
        setupLayout()
        getNotificationsData(page: page)
    }

    func getNotificationsData(page: Int) {
        loadingService?.setState(state: .loading)
        request.getListToken(page: page) { [weak self] data in
            guard let self = self else {return}
            switch data {
            case let .success(result):
                do {
                    for i in result.data {
                        self.custNotifData.append(CustomerNotificationsData(isHidden: true, tokenHistoryData: i))
                    }
                    self.tableView.isHidden = false
                    self.loadingIndicator.stopAnimating()
                    self.loadingIndicator.isHidden = true
                    self.totalPage = result.lastPage
                    self.loadingService?.setState(state: .success)
                    self.tableView.tableFooterView = nil
                } catch let error as NSError {
                    print(error.description)
                }
            case let .failure(error):
                self.loadingService?.setState(state: .failed)
                print(error)
                print("failed to get notif data")
            }
        }
    }
}

extension CustomerNotificationViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        if custNotifData.count == 0 {
            self.tableView.setEmptyMessage(
                image: UIImage(named: "empty.notification")!,
                title: "Empty",
                message: "You don’t have any notification. Don’t you want to visit some merchants?",
                centerYAnchorConstant: -50)
        } else {
            self.tableView.restore()
        }
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

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        tableView.tableFooterView = createSpinnerFooter()

//        guard loadingService?.loadingState == .success || loadingService?.loadingState == .failed else { return }

        guard loadingService?.loadingState != .loading else { return }

        tableView.tableFooterView = nil

        guard let totalPage = totalPage else { return }

        if offsetY > contentHeight - scrollView.frame.height {
            if page <= (totalPage - 1) {
                page += 1
                getNotificationsData(page: page)
                tableView.reloadData()
            }
        }
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
