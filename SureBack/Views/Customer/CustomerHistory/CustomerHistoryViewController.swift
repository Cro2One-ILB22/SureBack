//
//  CustomerHistoryViewController.swift
//  SureBack
//
//  Created by Ditha Nurcahya Avianty on 10/11/22.
//

import UIKit
import SDWebImage

class CustomerHistoryViewController: UIViewController {
//    let headerView = HeaderCustomerHistoryView(frame: CGRect(x: 0, y: 90, width: UIScreen.screenWidth, height: 200))
    let headerView = HeaderCustomerHistoryView(frame: CGRect(x: 0, y: 64, width: UIScreen.screenWidth, height: 200))

    let customSegmentedControl: CustomSegmentedControl = {
        let codeSegmented = CustomSegmentedControl(frame: CGRect(x: 0, y: 200, width: UIScreen.screenWidth, height: 50), buttonTitle: ["Token Status History", "Coin Balance History"])
        codeSegmented.backgroundColor = .clear
        return codeSegmented
    }()

    var tokenStatusView: TokenStatusView = {
        let segmented = TokenStatusView()
        return segmented
    }()

    let coinHistoryView: CoinHistoryView = {
        let segmented = CoinHistoryView()
        return segmented
    }()

    var user: UserInfoResponse?
    var merchantData: UserInfoResponse?
    var tokenData: GenerateTokenOnlineResponse?

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
            headerView.timerLabel.isHidden = true
            headerView.redeemLabel.isHidden = true
        }

        runCountdown()
        getCoinHistoryData(user: user, merchantData: merchantData)
        getTokenStatusData(merchantData: merchantData)
    }

    func getTokenStatusData(merchantData: UserInfoResponse) {
        request.getMyStoryCustomer(merchantId: merchantData.id) { data in
            switch data {
            case let .success(result):
                do {
                    for i in result.data {
                        if i.submittedAt == nil {
                            if i.token.expiresAt.stringToDate() < Date() {
                                self.tokenStatusView.transactionData.append(i)
                            }
                        } else {
                            if i.instagramStoryStatus == "validated"{
                                self.tokenStatusView.transactionData.append(i)
                            }
                        }
                    }
                } catch let error as NSError {
                    print(error.description)
                }
            case let .failure(error):
                print(error)
                print("failed to get list token status in merchant \(merchantData.name)")
            }
        }
    }

    func getCoinHistoryData(user: UserInfoResponse, merchantData: UserInfoResponse) {
        request.getListTransaction(merchantId: merchantData.id, status: "success") { data in
            switch data {
            case let .success(result):
                print("coin balance data: \(result)")
                do {
                    print(result.data)
                    self.coinHistoryView.transactionData = result.data
                } catch let error as NSError {
                    print(error.description)
                }
            case let .failure(error):
                print(error)
                print("failed to get list coins balance in merchant \(merchantData.name)")
            }
        }
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
        headerView.stackRedeemButton.addGestureRecognizer(tapGesture)
        headerView.loyaltCoinsValueLabel.text = "\(merchantData?.coins?[0].outstanding ?? 0)"
        headerView.lockImage.image = UIImage(named: "system.photo")
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
        print("change to", index)
        switch index {
        case 0:
            showCoinHistoryView(false)
        case 1:
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
        setupCoinHistoryView()
    }

    private func setupHeaderView() {
        view.addSubview(headerView)
//        headerView.setTopAnchorConstraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 200)
    }

    private func setupTokenStatusView() {
        view.addSubview(tokenStatusView)
        tokenStatusView.translatesAutoresizingMaskIntoConstraints = false
        tokenStatusView.setTopAnchorConstraint(equalTo: customSegmentedControl.bottomAnchor)
        tokenStatusView.setLeadingAnchorConstraint(equalTo: view.leadingAnchor)
        tokenStatusView.setTrailingAnchorConstraint(equalTo: view.trailingAnchor)
        tokenStatusView.setBottomAnchorConstraint(equalTo: view.bottomAnchor)
    }

    private func setupCoinHistoryView() {
        view.addSubview(coinHistoryView)
        coinHistoryView.translatesAutoresizingMaskIntoConstraints = false
        coinHistoryView.setTopAnchorConstraint(equalTo: customSegmentedControl.bottomAnchor)
        coinHistoryView.setLeadingAnchorConstraint(equalTo: view.leadingAnchor)
        coinHistoryView.setTrailingAnchorConstraint(equalTo: view.trailingAnchor)
        coinHistoryView.setBottomAnchorConstraint(equalTo: view.bottomAnchor)
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
