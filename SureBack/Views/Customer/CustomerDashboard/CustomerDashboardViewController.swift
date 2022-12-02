//
//  CustomerDashboardViewController.swift
//  SureBack
//
//  Created by Ditha Nurcahya Avianty on 09/11/22.
//

import CoreLocation
import SDWebImage
import UIKit
import RxSwift

class CustomerDashboardViewController: UIViewController, UIViewToController {
    private var loadingService: LoadingService?
    private let locationSubject: ReplaySubject<CLLocationCoordinate2D?>
    private let disposeBag = DisposeBag()
    let request = RequestFunction()
    var user: UserInfoResponse!
    var merchantData = [UserInfoResponse]() {
        didSet {
            tableView.reloadData()
        }
    }

    var activeTokenData = [Token]() {
        didSet {
            tableView.reloadData()
        }
    }

    var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(ActiveTokenTableViewCell.self, forCellReuseIdentifier: ActiveTokenTableViewCell.id)
        table.register(ItemMerchantTableViewCell.self, forCellReuseIdentifier: ItemMerchantTableViewCell.id)
        table.separatorColor = .clear
        return table
    }()

    lazy var loadingIndicator: UIActivityIndicatorView = {
        let loading = UIActivityIndicatorView()
        loading.style = .gray
        loading.translatesAutoresizingMaskIntoConstraints = false
        loading.isHidden = true
        return loading
    }()

    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .porcelain
        setupLoadingIndicator()
        loadingService = LoadingService(loadingIndicator: loadingIndicator)
        locationSubject.subscribe(onNext: { [weak self] location in
            self?.setupContent(location: location)
        }).disposed(by: disposeBag)

        tableView.isHidden = true

        let headerView = HeaderCustomerDashboardView(frame: CGRect(x: 0, y: 0, width: Int(UIScreen.screenWidth), height: 50))
        headerView.notifButton.addTarget(self, action: #selector(notifButtonTapped), for: .touchUpInside)
        setupView2(headerView: headerView)

        request.getListToken(expired: 0, submitted: 0, redeemed: 1) { [weak self]data in
            guard let self = self else {return}
            switch data {
            case let .success(result):
                do {
                    print("result data count: \(result.data.count)")
                    self.activeTokenData = result.data
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

    func didToRedeemTapButton(data: Token, user: UserInfoResponse) {
        let submitStoryVC = SubmitStoryViewController()
        submitStoryVC.title = "Submit Story"
        submitStoryVC.tokenData = data
        submitStoryVC.user = user
        navigationController?.pushViewController(submitStoryVC, animated: true)
    }

    @objc func notifButtonTapped() {
        print("notif button tapped")
        let notifVC = CustomerNotificationViewController()
        notifVC.title = "Token Notification"
        notifVC.user = user
        navigationController?.pushViewController(notifVC, animated: true)
    }

    @objc func seeAllMerchantTapped() {
        print("see All Merchant tapped")
        let allMerchantVC = CustomerListAllMerchantViewController()
        allMerchantVC.title = "All Merchant"
        allMerchantVC.user = user
//        allMerchantVC.merchantData = merchantData
        allMerchantVC.activeTokenData = activeTokenData
        navigationController?.pushViewController(allMerchantVC, animated: true)
    }

    @objc func bookmarkTapped(_ sender: UITapGestureRecognizer) {
        guard let tag = sender.view?.tag else {return}
        request.toggleMerchantFavorited(id: merchantData[tag].id) { response in
//            guard let self = self else {return}
            switch response {
            case .success(let result):
                let indexPath = IndexPath(row: tag, section: 1)
                let cell = self.tableView.cellForRow(at: indexPath) as? ItemMerchantTableViewCell
                self.merchantData[tag].isFavorite = result.isFavorite
                guard let isFavorite = result.isFavorite else {return print("return")}
                let image = isFavorite ? "bookmark.on" : "bookmark.off"
                cell?.bookmarkImage.image = UIImage(named: image)
            case let .failure(error):
                print(error)
                print("failed to bookmarked the merchant")
            }
        }
    }

    init(locationSubject: ReplaySubject<CLLocationCoordinate2D?>) {
        self.locationSubject = locationSubject
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
            cell.delegate = self
            cell.activateTokenData = activeTokenData
            cell.user = user
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ItemMerchantTableViewCell.id, for: indexPath) as? ItemMerchantTableViewCell else { return UITableViewCell() }

            cell.selectionStyle = .none
            cell.backgroundColor = .porcelain

            cell.merchantImage.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell.merchantImage.sd_setImage(
                with: URL(string: merchantData[indexPath.row].profilePicture ?? ""),
                placeholderImage: UIImage(named: "system.photo"),
                options: .progressiveLoad,
                completed: nil
            )
            cell.merchantNameLabel.text = merchantData[indexPath.row].name
            cell.totalCoinsLabel.text = "\(merchantData[indexPath.row].balance) coin(s)"
            cell.bookmarkImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(bookmarkTapped)))
            cell.bookmarkImage.tag = indexPath.row
            cell.bookmarkImage.isUserInteractionEnabled = true
            if let isFavorite = merchantData[indexPath.row].isFavorite {
                let image = isFavorite ? "bookmark.on" : "bookmark.off"
                cell.bookmarkImage.image = UIImage(named: image)
            }

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
        for i in activeTokenData {
            if i.purchase?.merchant?.id == merchantData[indexPath.row].id {
                merchantDetailVC.tokenData = i
                break
            }
        }
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

extension CustomerDashboardViewController {
    private func setupView() {
        setupTableView()
        tableView.delegate = self
        tableView.dataSource = self
    }

    private func setupLoadingIndicator() {
        view.addSubview(loadingIndicator)
        loadingIndicator.setCenterXAnchorConstraint(equalTo: view.centerXAnchor)
        loadingIndicator.setCenterYAnchorConstraint(equalTo: view.centerYAnchor)
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

    private func setupContent(location: CLLocationCoordinate2D?) {
        guard loadingService?.loadingState == .notStarted else { return }
        loadingService?.setState(state: .loading)
        let coordinate = (location != nil) ? (location!.latitude, location!.longitude) : nil
        request.getListMerchant(locationCoordinate: coordinate) { data in
            switch data {
            case let .success(result):
                self.merchantData = result.data
                self.tableView.isHidden = false
                self.loadingService?.setState(state: .success)
            case let .failure(error):
                self.loadingService?.setState(state: .failed)
                print(error)
                print("failed to get list merchant")
            }
        }
    }
}
