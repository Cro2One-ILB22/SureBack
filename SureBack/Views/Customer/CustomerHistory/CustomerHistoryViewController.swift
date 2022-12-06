//
//  CustomerHistoryViewController.swift
//  SureBack
//
//  Created by Ditha Nurcahya Avianty on 10/11/22.
//

import UIKit
import SDWebImage

class CustomerHistoryViewController: UIViewController {
    let headerView = HeaderCustomerHistoryView()

    let customSegmentedControl: CustomSegmentedControl = {
        let codeSegmented = CustomSegmentedControl(frame: CGRect(x: 0, y: 200, width: UIScreen.screenWidth, height: 50), buttonTitle: ["Token Status History", "Coin Balance History"])
        codeSegmented.backgroundColor = .clear
        return codeSegmented
    }()

    var tokenStatusView: UIView = UIView()
    var coinHistoryView: UIView = UIView()
    var isFirstTimeOpenCoinHistory = true

    var user: UserInfoResponse?
    var merchantData: UserInfoResponse?
    var tokenData: Token?

    let request = RequestFunction()

    var countdown: DateComponents {
        return Calendar.current.dateComponents([.day, .hour, .minute, .second], from: Date(), to: self.tokenData?.expiresAt.stringToDate() ?? Date())
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tabBarController?.tabBar.isHidden = true

        setupLayout()
        configureHeader()
        showCoinHistoryView(false)

        guard let user = user, let merchantData = merchantData else {
            return
        }

        if tokenData == nil {
            headerView.redeemButtonView.isHidden = true
        }

        runCountdown()
    }

    func configureHeader() {
        headerView.profileImage.sd_imageIndicator = SDWebImageActivityIndicator.gray
        headerView.profileImage.sd_setImage(
            with: URL(string: merchantData?.profilePicture ?? ""),
            placeholderImage: UIImage(named: "person.crop.circle"),
            options: .progressiveLoad,
            completed: nil
        )
        headerView.userNameLabel.text = "\(user?.name ?? "") @"
        headerView.merchantLabel.text = merchantData?.name
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(redeemButtonTapped))
        headerView.redeemButtonView.isUserInteractionEnabled = true
        headerView.redeemButtonView.addGestureRecognizer(tapGesture)
        var outstandingCoins = 0
        if let individualCoins = merchantData?.individualCoins, individualCoins.count == 2, let localCoins = individualCoins.filter({$0.coinType == "local"}).first {
            outstandingCoins = localCoins.outstanding
        }
        headerView.loyaltCoinsValueLabel.text = "\(outstandingCoins)"
        headerView.openLinkButton.addTarget(self, action: #selector(openLinkTapped), for: .touchUpInside)
        guard let coolDownDate = merchantData?.merchantDetail?.cooldownUntil else {return}
        headerView.lockImage.image = UIImage(named: coolDownDate.stringToDate() < Date() ? "lock.status.available" : "lock.status.unavailable")
        headerView.statusLabel.text = coolDownDate.stringToDate() < Date() ? "Available" :  "\(coolDownDate.formatTodMMMyyy())"
    }

    @objc func openLinkTapped() {
        guard let username = merchantData?.instagramUsername else {return}
        UIApplication.shared.open(URL(string: "https://instagram.com/\(username)")!)
    }

    @objc func redeemButtonTapped(sender: UITapGestureRecognizer) {
        print("redeem button tapped")
        let submitStoryVC = SubmitStoryViewController()
        submitStoryVC.title = "Submit Story"
        submitStoryVC.tokenData = tokenData
        submitStoryVC.user = user
        navigationController?.pushViewController(submitStoryVC, animated: true)
    }

    private func showCoinHistoryView(_ isShowing: Bool) {
        tokenStatusView.isHidden = isShowing
        coinHistoryView.isHidden = !isShowing
    }

    // MARK: Timer
    func runCountdown() {
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }

    @objc func updateTimer() {
        let countdown = self.countdown
        let hours = countdown.hour!
        let minutes = countdown.minute!
        let seconds = countdown.second!

        self.headerView.timerLabel.text = String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
}

extension CustomerHistoryViewController: CustomSegmentedControlDelegate {
    func change(to index: Int) {
        switch index {
        case 0:
            showCoinHistoryView(false)
        case 1:
            if isFirstTimeOpenCoinHistory {
                isFirstTimeOpenCoinHistory = false
                setupCoinHistoryView()
            }
            showCoinHistoryView(true)
        default:
            break
        }
    }
}

extension CustomerHistoryViewController {
    public func setupLayout() {
        setupHeaderView()
        setupCustomSegmentedControl()
        setupTokenStatusView()
    }

    private func setupHeaderView() {
        view.addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.setTopAnchorConstraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
    }

    private func setupTokenStatusView() {
        view.addSubview(tokenStatusView)
        tokenStatusView.translatesAutoresizingMaskIntoConstraints = false
        tokenStatusView.setTopAnchorConstraint(equalTo: customSegmentedControl.bottomAnchor)
        tokenStatusView.setLeadingAnchorConstraint(equalTo: view.leadingAnchor)
        tokenStatusView.setTrailingAnchorConstraint(equalTo: view.trailingAnchor)
        tokenStatusView.setBottomAnchorConstraint(equalTo: view.bottomAnchor)
        let tokenStatusVC = TokenStatusViewController()
        self.addChild(tokenStatusVC)
        tokenStatusVC.merchantData = merchantData
        tokenStatusVC.view.frame = self.tokenStatusView.bounds
        tokenStatusView.addSubview(tokenStatusVC.view)
    }

    private func setupCoinHistoryView() {
        view.addSubview(coinHistoryView)
        coinHistoryView.translatesAutoresizingMaskIntoConstraints = false
        coinHistoryView.setTopAnchorConstraint(equalTo: customSegmentedControl.bottomAnchor)
        coinHistoryView.setLeadingAnchorConstraint(equalTo: view.leadingAnchor)
        coinHistoryView.setTrailingAnchorConstraint(equalTo: view.trailingAnchor)
        coinHistoryView.setBottomAnchorConstraint(equalTo: view.bottomAnchor)
        let coinHistoryVC = CoinHistoryViewController()
        self.addChild(coinHistoryVC)
        coinHistoryVC.merchantData = merchantData
        coinHistoryVC.view.frame = self.coinHistoryView.bounds
        coinHistoryView.addSubview(coinHistoryVC.view)
    }

    private func setupCustomSegmentedControl() {
        view.addSubview(customSegmentedControl)
        customSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        customSegmentedControl.setTopAnchorConstraint(equalTo: headerView.bottomAnchor)
        customSegmentedControl.setLeadingAnchorConstraint(equalTo: view.leadingAnchor)
        customSegmentedControl.setTrailingAnchorConstraint(equalTo: view.trailingAnchor)
        customSegmentedControl.setHeightAnchorConstraint(equalToConstant: 50)
        customSegmentedControl.delegate = self
    }
}
