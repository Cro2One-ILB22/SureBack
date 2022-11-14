//
//  CustomerDashboardViewController.swift
//  SureBack
//
//  Created by Ditha Nurcahya Avianty on 09/11/22.
//

import SDWebImage
import UIKit

class CustomerDashboardViewController: UIViewController {
    let request = RequestFunction()
    var user: UserInfoResponse!
    var merchantData = [UserInfoResponse]()
    var activeTokenData = [GenerateTokenOnlineResponse]()

    var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(ItemMerchantTableViewCell.self, forCellReuseIdentifier: ItemMerchantTableViewCell.id)
        table.backgroundColor = .white
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        request.getListMerchant { data in
            switch data {
            case let .success(result):
                do {
                    self.merchantData = result.data
                    self.tableView.reloadData()
                    self.setupView()
                } catch let error as NSError {
                    print(error.description)
                }
            case let .failure(error):
                print(error)
                print("failed to get list merchant")
            }
        }

        request.getListToken(expired: 0, submitted: 0, redeemed: 1) { data in
            switch data {
            case let .success(result):
                do {
                    print(result.data.count)
//                    self.activeTokenData = result.data

                    let height = result.data.count > 0 ? 270 : 150
                    let headerView = HeaderCustomerDashboardView(count: result.data.count, activeTokenData: result.data, frame: CGRect(x: 0, y: 0, width: Int(UIScreen.screenWidth), height: height))
                    self.setupView2(headerView: headerView)
                } catch let error as NSError {
                    print(error.description)
                }
            case let .failure(error):
                print(error)
                print("failed to get active token")
            }
        }
    }

    @objc func redeemTokenTapped() {
        print("redeem token tapped")
        let submitStoryVC = SubmitStoryViewController()
        submitStoryVC.title = "Submit Story"
        navigationController?.pushViewController(submitStoryVC, animated: true)
    }

    @objc func seeAllMerchantTapped() {
        print("see All Merchant tapped")
    }
}

extension CustomerDashboardViewController {
    private func setupView() {
        setupTableView()
        tableView.delegate = self
        tableView.dataSource = self
    }

    private func setupView2(headerView: HeaderCustomerDashboardView) {
        view.addSubview(headerView)
        headerView.profileLabel.text = "Hi, \(user.name)!"
        headerView.totalCoinsLabel.text = " \(user.coins![0].outstanding)"
        tableView.tableHeaderView = headerView
        headerView.activeTokenCard.redeemButton.addTarget(self, action: #selector(redeemTokenTapped), for: .touchUpInside)
        headerView.seeAllMerchantButton.addTarget(self, action: #selector(seeAllMerchantTapped), for: .touchUpInside)
    }

    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.setTopAnchorConstraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        tableView.setLeadingAnchorConstraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
        tableView.setTrailingAnchorConstraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        tableView.setBottomAnchorConstraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    }
}

extension CustomerDashboardViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return merchantData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ItemMerchantTableViewCell.id, for: indexPath) as? ItemMerchantTableViewCell else { return UITableViewCell() }

        cell.merchantImage.sd_setImage(
            with: URL(string: merchantData[indexPath.row].profilePicture),
            placeholderImage: UIImage(named: "system.photo"),
            options: .progressiveLoad,
            completed: nil
        )
        cell.merchantNameLabel.text = merchantData[indexPath.row].name
        cell.merchantTodayTokenLabel.text = "\(merchantData[indexPath.row].merchantDetail!.todaysTokenCount) visit"
//        cell.merchantTagLabel.text = merchantData[indexPath.row].merchantTag
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selected = indexPath.row
        print(selected)

        let merchantDetailVC = CustomerHistoryViewController()
        merchantDetailVC.title = "Merchant"
        merchantDetailVC.user = user
        merchantDetailVC.merchantData = merchantData[indexPath.row]
        navigationController?.pushViewController(merchantDetailVC, animated: true)
    }
}
