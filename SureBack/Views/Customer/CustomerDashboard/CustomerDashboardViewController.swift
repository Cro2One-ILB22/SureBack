//
//  CustomerDashboardViewController.swift
//  SureBack
//
//  Created by Ditha Nurcahya Avianty on 09/11/22.
//

import CoreLocation
import RxSwift
import SDWebImage
import UIKit

class CustomerDashboardViewController: UIViewController, UIViewToController, SendBookmark {
//    private let locationSubject = ReplaySubject<CLLocationCoordinate2D?>.create(bufferSize: 1)

    private var loadingService: LoadingService?
    private let locationSubject: ReplaySubject<CLLocationCoordinate2D?>
    private let disposeBag = DisposeBag()
    let request = RequestFunction()
    var user: UserInfoResponse!

    let activeTokensViewModel = ActiveTokensViewModel.shared
    let merchantsProcessViewModel = MerchantsProcessViewModel.shared

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
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .porcelain
        setupLoadingIndicator()
        loadingService = LoadingService(loadingIndicator: loadingIndicator)
        loadingService?.setState(state: .loading)
        locationSubject.subscribe(onNext: { [weak self] location in
            if let location = location {
                self?.merchantsProcessViewModel.setLocation(location: location)
            }
            self?.merchantsProcessViewModel.fetchMerchants()
        }).disposed(by: disposeBag)

        activeTokensViewModel.fetchTokens()

        activeTokensViewModel.activeTokensSubject.subscribe(onNext: { [weak self] tokens in
            self?.tableView.reloadData()
            self?.loadingService?.setState(state: tokens.loadingState)
        }).disposed(by: disposeBag)

        merchantsProcessViewModel.merchantsProcessSubject.subscribe(onNext: { [weak self] merchantsProcess in
            if merchantsProcess.loadingState == .success {
                self?.tableView.isHidden = false
            }
            self?.tableView.reloadData()
            self?.loadingService?.setState(state: merchantsProcess.loadingState)
        }).disposed(by: disposeBag)

        tableView.isHidden = true

        let headerView = HeaderCustomerDashboardView(frame: CGRect(x: 0, y: 0, width: Int(UIScreen.screenWidth), height: 50))
        headerView.notifButton.addTarget(self, action: #selector(notifButtonTapped), for: .touchUpInside)
        setupView2(headerView: headerView)

        setupView()
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
        allMerchantVC.activeTokenData = activeTokensViewModel.activeTokens.tokens
        allMerchantVC.delegate = self
        navigationController?.pushViewController(allMerchantVC, animated: true)
    }

    @objc func bookmarkTapped(_ sender: UITapGestureRecognizer) {
        guard let tag = sender.view?.tag else { return }
        let indexPath = IndexPath(row: tag, section: 1)
        let cell = tableView.cellForRow(at: indexPath) as? ItemMerchantTableViewCell
        cell?.bookmarkImage.isUserInteractionEnabled = false

        request.toggleMerchantFavorited(id: merchantsProcessViewModel.merchantsProcess.merchants[tag].id) { response in
//            guard let self = self else {return}
            switch response {
            case let .success(result):
                self.merchantsProcessViewModel.merchantsProcess.merchants[tag].isFavorite = result.isFavorite
                guard let isFavorite = result.isFavorite else { return print("return") }
                let image = isFavorite ? "bookmark.on" : "bookmark.off"
                cell?.bookmarkImage.image = UIImage(named: image)
                cell?.bookmarkImage.isUserInteractionEnabled = true
            case let .failure(error):
                print(error)
                print("failed to bookmarked the merchant")
            }
        }
    }

    //TODO: fix no cell detected
    func didTapBookmark(merchantId: Int, isFavorite: Bool) {
        var tag = 0
        let dashboardVC = CustomerDashboardViewController(locationSubject: locationSubject)
        for i in 0 ... merchantsProcessViewModel.merchantsProcess.merchants.count {
            let cell = tableView.cellForRow(at: IndexPath(row: i, section: 1))
            if merchantsProcessViewModel.merchantsProcess.merchants[i].id == merchantId {
                tag = i
                break
            }
        }

        let indexPath = IndexPath(row: tag, section: 1)
        let cell = dashboardVC.tableView.cellForRow(at: indexPath) as? ItemMerchantTableViewCell
        let image = isFavorite ? "bookmark.on" : "bookmark.off"
        guard let cell = cell else {return print("no cell")}
        cell.bookmarkImage.image = UIImage(named: image)
        tableView.reloadData()
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
            return activeTokensViewModel.activeTokens.tokens.count == 0 ? 0 : 1
        } else {
            if merchantsProcessViewModel.merchantsProcess.merchants.count == 0 {
                self.tableView.setEmptyMessage(
                    image: UIImage(named: "empty.merchant")!,
                    title: "Empty Merchant",
                    message: "Let’s Get Going! Which Merchant will be your First Visit?",
                    centerYAnchorConstant: -50)
            } else {
                self.tableView.restore()
            }
            return merchantsProcessViewModel.merchantsProcess.merchants.count > 5 ? 5 : merchantsProcessViewModel.merchantsProcess.merchants.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ActiveTokenTableViewCell.id, for: indexPath) as? ActiveTokenTableViewCell else { return UITableViewCell() }
            cell.delegate = self
            cell.user = user
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ItemMerchantTableViewCell.id, for: indexPath) as? ItemMerchantTableViewCell else { return UITableViewCell() }

            cell.selectionStyle = .none
            cell.backgroundColor = .porcelain

            cell.merchantImage.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell.merchantImage.sd_setImage(
                with: URL(string: merchantsProcessViewModel.merchantsProcess.merchants[indexPath.row].profilePicture ?? ""),
                placeholderImage: UIImage(named: "system.photo"),
                options: .progressiveLoad,
                completed: nil
            )
            cell.merchantNameLabel.text = merchantsProcessViewModel.merchantsProcess.merchants[indexPath.row].name
            var outstandingCoins = 0
            if let individualCoins = merchantsProcessViewModel.merchantsProcess.merchants[indexPath.row].individualCoins, individualCoins.count == 2, let localCoins = individualCoins.filter({$0.coinType == "local"}).first {
                outstandingCoins = localCoins.outstanding
            }
            cell.totalCoinsLabel.text = "\(outstandingCoins) Coin(s)"
            cell.bookmarkImage.tag = indexPath.row
            cell.bookmarkImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(bookmarkTapped)))
            cell.bookmarkImage.isUserInteractionEnabled = true
            if let isFavorite = merchantsProcessViewModel.merchantsProcess.merchants[indexPath.row].isFavorite {
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
        merchantDetailVC.merchantData = merchantsProcessViewModel.merchantsProcess.merchants[indexPath.row]
        for i in activeTokensViewModel.activeTokens.tokens {
            if i.purchase?.merchant?.id == merchantsProcessViewModel.merchantsProcess.merchants[indexPath.row].id {
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
            if activeTokensViewModel.activeTokens.tokens.count == 0 {
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
        headerView.totalCoinsLabel.text = " \(user.coins?[1].exchanged ?? 0)"
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
