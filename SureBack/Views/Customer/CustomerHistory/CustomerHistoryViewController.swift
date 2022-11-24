//
//  CustomerHistoryViewController.swift
//  SureBack
//
//  Created by Ditha Nurcahya Avianty on 10/11/22.
//

import UIKit

class CustomerHistoryViewController: UIViewController {
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

    let request = RequestFunction()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tabBarController?.tabBar.isHidden = true

        setupLayout()
        setupHeaderValue()
        showCoinHistoryView(false)

        guard let user = user, let merchantData = merchantData else {
            return
        }
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

    func setupHeaderValue() {
        headerView.profileImage.sd_setImage(
            with: URL(string: merchantData?.profilePicture ?? ""),
            placeholderImage: UIImage(named: "person.crop.circle"),
            options: .progressiveLoad,
            completed: nil
        )
        headerView.merchantLabel.text = merchantData?.name
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(redeemButtonTapped))
        headerView.redeemButton.addGestureRecognizer(tapGesture)
        headerView.loyaltCoinsValueLabel.text = "\(merchantData?.coins?[0].outstanding ?? 0)"
        headerView.lockImage.image = UIImage(named: "system.photo")
    }

    @objc func redeemButtonTapped(sender: UITapGestureRecognizer) {
        print("redeem button tapped")
    }

    private func showCoinHistoryView(_ isShowing: Bool) {
        tokenStatusView.isHidden = isShowing
        coinHistoryView.isHidden = !isShowing
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
//        headerView.setTopAnchorConstraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100)
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
