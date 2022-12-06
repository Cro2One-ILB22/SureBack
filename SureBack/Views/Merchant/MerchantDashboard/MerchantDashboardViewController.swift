//
//  MerchantDashboardViewController.swift
//  SureBack
//
//  Created by Tubagus Adhitya Permana on 09/11/22.
//

import UIKit
import RxSwift

class MerchantDashboardViewController: UIViewController {
    var user: UserInfoResponse? {
        didSet {
            configHeaderView()
        }
    }
    private let apiRequest = RequestFunction()
    private let viewModel = CustomerStoryViewModel.shared
    private let dispose = DisposeBag()
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
    private let refreshControl = UIRefreshControl()
    var snackBarMessage: SnackBarMessage?
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = .systemGreen
        view.backgroundColor = .white
        navigationItem.title = "Hi, " + (user?.name ?? "")
        showLoadingIndicator(true)
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        configTableView()
        viewModel.fetchCustomerStory()
        viewModel.customerStorySubject.subscribe(onNext: {
            [weak self] customerStory in
            if customerStory.loadingState == .success {
                self?.showLoadingIndicator(false)
            }
            self?.tableView.reloadData()
        }).disposed(by: dispose)
        setupLayout()
        snackBarMessage = SnackBarMessage()
    }
    @objc func refreshData() {
        DispatchQueue.main.async {
            self.refreshControl.endRefreshing()
            self.viewModel.fetchCustomerStory()
            self.tableView.reloadData()
        }
    }
    @objc func seeAllCustomers() {
        let merchantListAllCustomerVC = MerchantListAllCustomerViewController()
        merchantListAllCustomerVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(merchantListAllCustomerVC, animated: true)
    }
    private func showLoadingIndicator(_ isShow: Bool) {
        self.tableView.isHidden = isShow
        self.loadingIndicator.show(isShow)
        self.loadingIndicator.isHidden = !isShow
    }
    private func configTableView() {
        configHeaderView()
        tableView.delegate = self
        tableView.dataSource = self
    }
    private func configHeaderView() {
        let headerView = HeaderMerchantDashboardView(frame: CGRect(x: 0, y: 0, width: UIScreen.screenWidth, height: 250))
        headerView.seeAllCustomersButton.addTarget(self, action: #selector(seeAllCustomers), for: .touchUpInside)
        headerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(cardSummaryAction)))
        guard let coin = user?.coins?[0].coinType == "local" ? user?.coins?[0] : user?.coins?[1] else {return}
        let totalTokenToday = user?.merchantDetail?.todaysTokenCount ?? 0
        headerView.businessStatusCard.totalOutstandingCoinLabel.text = "\(coin.outstanding)"
        headerView.businessStatusCard.totalExchangedCoinLabel.text = "\(coin.exchanged)"
        headerView.businessStatusCard.totalTokenLabel.text = "\(totalTokenToday) Tokens"
        tableView.tableHeaderView = headerView
    }
    @objc func cardSummaryAction() {
        let coinHistoryVC = MerchantCoinHistoryViewController()
        coinHistoryVC.merchant = user
        coinHistoryVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(coinHistoryVC, animated: true)
    }
}
extension MerchantDashboardViewController: StoryTableViewCellCellDelegate {
    func didSelectItem(with storyData: MyStoryData) {
        let detailStoryVC = MerchantDetailStoryViewController()
        detailStoryVC.storyData = storyData
        detailStoryVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(detailStoryVC, animated: true)
    }
}

extension MerchantDashboardViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.customerStory.stories.count == 0 {
            self.tableView.setEmptyMessage(
                image: UIImage(named: "empty.customers")!,
                title: "Empty Customer",
                message: "No customers mentioned you at this time. Don't worry, Let's find them!",
            centerYAnchorConstant: 50)
            return 0
        } else {
            self.tableView.restore()
            return 1
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StoryTableViewCell.id, for: indexPath) as? StoryTableViewCell else { return UITableViewCell() }
        cell.delegate = self
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
}
