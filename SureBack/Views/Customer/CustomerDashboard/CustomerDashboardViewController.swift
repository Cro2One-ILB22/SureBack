//
//  CustomerDashboardViewController.swift
//  SureBack
//
//  Created by Ditha Nurcahya Avianty on 09/11/22.
//

import SDWebImage
import UIKit

class CustomerDashboardViewController: UIViewController, UIViewToController {
    let locationManager = CLLocationManager()
    let request = RequestFunction()
    var user: UserInfoResponse!
    var merchantData = [UserInfoResponse]() {
        didSet {
            tableView.reloadData()
        }
    }

    var activeTokenData = [GenerateTokenOnlineResponse]() {
        didSet {
            tableView.reloadData()
        }
    }

    var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(ActiveTokenTableViewCell.self, forCellReuseIdentifier: ActiveTokenTableViewCell.id)
        table.register(ItemMerchantTableViewCell.self, forCellReuseIdentifier: ItemMerchantTableViewCell.id)
        table.backgroundColor = .white
        table.separatorColor = .clear
        return table
    }()

    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        initAndStartUpdatingLocation()
        view.backgroundColor = .white

        request.getListMerchant { data in
            switch data {
            case let .success(result):
                do {
                    self.merchantData = result.data
                } catch let error as NSError {
                    print(error.description)
                }
            case let .failure(error):
                print(error)
                print("failed to get list merchant")
            }
        }

        let headerView = HeaderCustomerDashboardView(frame: CGRect(x: 0, y: 0, width: Int(UIScreen.screenWidth), height: 50))
        headerView.notifButton.addTarget(self, action: #selector(notifButtonTapped), for: .touchUpInside)
        self.setupView2(headerView: headerView)

        request.getListToken(expired: 0, submitted: 0, redeemed: 1) { data in
            switch data {
            case let .success(result):
                do {
                    print("result data count: \(result.data.count)")
                    self.activeTokenData = result.data
//                    let headerView = HeaderCustomerDashboardView(count: result.data.count, activeTokenData: result.data, frame: CGRect(x: 0, y: 0, width: Int(UIScreen.screenWidth), height: height))
//                    let headerView = HeaderCustomerDashboardView(frame: CGRect(x: 0, y: 0, width: Int(UIScreen.screenWidth), height: 50))
//                    self.setupView2(headerView: headerView)
                } catch let error as NSError {
                    print(error.description)
                }
            case let .failure(error):
                print(error)
                print("failed to get active token")
            }
        }

        self.setupView()
    }

    func didToRedeemTapButton(data: GenerateTokenOnlineResponse, user: UserInfoResponse) {
        let submitStoryVC = SubmitStoryViewController()
        submitStoryVC.title = "Submit Story"
        submitStoryVC.tokenData = data
        submitStoryVC.user = user
        navigationController?.pushViewController(submitStoryVC, animated: true)
    }

    @objc func notifButtonTapped() {
        print("notif button tapped")
    }

    @objc func seeAllMerchantTapped() {
        print("see All Merchant tapped")
        let allMerchantVC = CustomerListAllMerchantViewController()
        allMerchantVC.title = "All Merchant"
        allMerchantVC.user = user
        allMerchantVC.merchantData = merchantData
        navigationController?.pushViewController(allMerchantVC, animated: true)
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
        headerView.profileLabel.text = "Hi, @\(user.instagramUsername)!"
        headerView.totalCoinsLabel.text = " \(user.coins![0].outstanding)"
        tableView.tableHeaderView = headerView
        tableView.register(SectionDashboardHeader.self, forHeaderFooterViewReuseIdentifier: "sectionHeader")
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
        if section == 0 {
            return activeTokenData.count == 0 ? 0 : 1
        } else {
            return merchantData.count > 5 ? 5 : merchantData.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ActiveTokenTableViewCell.id, for: indexPath) as? ActiveTokenTableViewCell else { return UITableViewCell() }
            cell.backgroundColor = .red
            cell.delegate = self
            cell.activateTokenData = activeTokenData
            cell.user = user
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ItemMerchantTableViewCell.id, for: indexPath) as? ItemMerchantTableViewCell else { return UITableViewCell() }

            cell.selectionStyle = .none

            cell.merchantImage.sd_setImage(
                with: URL(string: merchantData[indexPath.row].profilePicture),
                placeholderImage: UIImage(named: "system.photo"),
                options: .progressiveLoad,
                completed: nil
            )
            cell.merchantNameLabel.text = merchantData[indexPath.row].name
            cell.totalCoinsLabel.text = "\(merchantData[indexPath.row].balance) coin(s)"
            return cell
        }
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

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "sectionHeader") as! SectionDashboardHeader // swiftlint:disable:this force_cast

        if section == 0 {
            view.seeAllMerchantButton.isHidden = true
            view.merchantLabel.text = "Token"
            if activeTokenData.count == 0 {
                return nil
            }
        } else {
            view.merchantLabel.text = "Recommended"
            view.seeAllMerchantButton.isHidden = false
        }
        view.seeAllMerchantButton.addTarget(self, action: #selector(seeAllMerchantTapped), for: .touchUpInside)
        return view
    }
}

import CoreLocation

extension CustomerDashboardViewController: CLLocationManagerDelegate {
    func initAndStartUpdatingLocation() {
        DispatchQueue.global(qos: .utility).async {
            self.locationManager.requestWhenInUseAuthorization()
            if CLLocationManager.locationServicesEnabled() {
                self.locationManager.delegate = self
                self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
                self.locationManager.startUpdatingLocation()
            }
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue)")
        self.locationManager.stopUpdatingLocation()
    }
}
