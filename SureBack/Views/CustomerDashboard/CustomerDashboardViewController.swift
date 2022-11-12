//
//  CustomerDashboardViewController.swift
//  SureBack
//
//  Created by Ditha Nurcahya Avianty on 09/11/22.
//

import SDWebImage
import UIKit

struct MerchantData {
    var merchantImage: UIImage?
    var merchantName: String?
    var merchantTodayToken: Int?
    var merchantTag: String?
}

class CustomerDashboardViewController: UIViewController {

    let request = RequestFunction()
    var user: UserInfoResponse?
    var merchantData = [MerchantData]()

    var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(ItemMerchantTableViewCell.self, forCellReuseIdentifier: ItemMerchantTableViewCell.id)
        table.backgroundColor = .white
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        request.getUserInfo { data in
            switch data {
            case let .success(result):
                do {
                    self.user = result
                    print("login success")
                } catch let error as NSError {
                    print(error.description)
                }
            case let .failure(error):
                print(error)
                print("failed to login")
            }
        }

        addDummyData()
        let headerView = HeaderCustomerDashboard(frame: CGRect(x: 0, y: 0, width: UIScreen.screenWidth, height: 270))
        view.addSubview(headerView)
        setupTableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableHeaderView = headerView
        headerView.activeTokenCard.redeemButton.addTarget(self, action: #selector(redeemTokenTapped), for: .touchUpInside)
        headerView.seeAllMerchantButton.addTarget(self, action: #selector(seeAllMerchantTapped), for: .touchUpInside)

        getMerchantData()
    }

    @objc func redeemTokenTapped() {
        print("redeem token tapped")
    }
    @objc func seeAllMerchantTapped() {
        print("see All Merchant tapped")
    }

    func getMerchantData() {
        request.getListMerchant { data in
            print(data)
        }
    }

    func addDummyData() {
        merchantData.append(MerchantData(merchantImage: UIImage(named: "person.crop.circle"), merchantName: "Merchant 10", merchantTodayToken: 100, merchantTag: "will run out"))
        merchantData.append(MerchantData(merchantImage: UIImage(named: "person.crop.circle"), merchantName: "Merchant 11", merchantTodayToken: 110, merchantTag: "will run out"))
        merchantData.append(MerchantData(merchantImage: UIImage(named: "person.crop.circle"), merchantName: "Merchant 12", merchantTodayToken: 120, merchantTag: "will run out"))
        merchantData.append(MerchantData(merchantImage: UIImage(named: "person.crop.circle"), merchantName: "Merchant 13", merchantTodayToken: 130, merchantTag: "will run out"))
        merchantData.append(MerchantData(merchantImage: UIImage(named: "person.crop.circle"), merchantName: "Merchant 14", merchantTodayToken: 140, merchantTag: "popular"))
        merchantData.append(MerchantData(merchantImage: UIImage(named: "person.crop.circle"), merchantName: "Merchant 15", merchantTodayToken: 150, merchantTag: "popular"))
        merchantData.append(MerchantData(merchantImage: UIImage(named: "person.crop.circle"), merchantName: "Merchant 16", merchantTodayToken: 160, merchantTag: "will run out"))
        merchantData.append(MerchantData(merchantImage: UIImage(named: "person.crop.circle"), merchantName: "Merchant 17", merchantTodayToken: 170, merchantTag: "popular"))
        merchantData.append(MerchantData(merchantImage: UIImage(named: "person.crop.circle"), merchantName: "Merchant 18", merchantTodayToken: 180, merchantTag: "will run out"))
    }
}

extension CustomerDashboardViewController {
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ItemMerchantTableViewCell.id, for: indexPath) as? ItemMerchantTableViewCell else {return UITableViewCell()}


        cell.merchantImage.sd_setImage(
            with: URL(string: ""),
            placeholderImage: UIImage(named: "system.photo"),
            options: .progressiveLoad,
            completed: nil
        )
        cell.merchantNameLabel.text = merchantData[indexPath.row].merchantName
        cell.merchantTodayTokenLabel.text = String(merchantData[indexPath.row].merchantTodayToken!)
        cell.merchantTagLabel.text = merchantData[indexPath.row].merchantTag
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selected = indexPath.row
        print(selected)

        let merchantDetailVC = MerchantDetailViewController()
//        merchantDetailVC.user = user
        merchantDetailVC.merchantData = merchantData[indexPath.row]
        navigationController?.pushViewController(merchantDetailVC, animated: true)
    }
}
