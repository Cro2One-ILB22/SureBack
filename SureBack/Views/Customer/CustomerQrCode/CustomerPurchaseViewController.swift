//
//  CustomerPurchaseViewController.swift
//  SureBack
//
//  Created by Ditha Nurcahya Avianty on 03/12/22.
//

import PusherSwift
import UIKit

class CustomerPurchaseViewController: UIViewController {
    var purchasePusherService: PurchasePusherSerivce?
    let merchantId: Int
    let userViewModel = UserViewModel.shared
    let merchantsProcessViewModel = MerchantsProcessViewModel.shared
    let activeTokensViewModel = ActiveTokensViewModel.shared
    let apiRequest = RequestFunction()
    var isGetTokenActive = true
    var isUseCoinActive = true

    let instructionLabel: UILabel = {
        let label = UILabel()
        label.text = "Do you want to use coin at this trade?"
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textAlignment = .justified
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let firstView: CustomerPurchaseFirstView = {
        let view = CustomerPurchaseFirstView()
        return view
    }()

    let secondView: CustomerPurchaseSecondView = {
        let view = CustomerPurchaseSecondView()
        return view
    }()

    let alertSuccess = UIAlertController(title: "Alert", message: "Message", preferredStyle: .alert)

    let alertWaiting: UIAlertController = {
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        alert.view.tintColor = UIColor.black
        let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(10, 5, 50, 50)) as UIActivityIndicatorView
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating()
        alert.view.addSubview(loadingIndicator)
        return alert
    }()

    @objc func switchCoinStateDidChange(_ sender: UISwitch!) {
        isUseCoinActive = sender.isOn
        secondView.isHidden = isUseCoinActive ? false : true
    }

    @objc func switchTokenStateDidChange(_ sender: UISwitch!) {
        isGetTokenActive = sender.isOn
    }

    @objc func makePurchase() {
        guard let coinsUsed = secondView.coinUsedValue.text, let coinsUsed = Int(coinsUsed) else { return }
        present(alertWaiting, animated: true, completion: nil)

        apiRequest.requestPurchase(merchantId: merchantId, coinsUsed: isUseCoinActive ? coinsUsed : 0, isRequestingForToken: isGetTokenActive) { [weak self] _ in
            guard let self = self else { return }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        purchasePusherService = PurchasePusherSerivce(delegate: self)
        view.backgroundColor = .porcelain

        setupLayout()
        firstView.useCoinSwitch.addTarget(self, action: #selector(switchCoinStateDidChange(_:)), for: .valueChanged)
        firstView.useCoinSwitch.setOn(true, animated: false)
        firstView.getTokenSwitch.addTarget(self, action: #selector(switchTokenStateDidChange(_:)), for: .valueChanged)
        firstView.getTokenSwitch.setOn(true, animated: false)

        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(makePurchase))
        navigationItem.rightBarButtonItem = doneButton
        navigationItem.title = "Use Coin"

        guard let user = userViewModel.user else { return }

        firstView.dateLabel.text = Date().dateToString()
        firstView.usernameLabel.text = "@\(user.instagramUsername)"
//
        apiRequest.getMerchantById(id: merchantId) { [weak self] response in
            switch response {
            case let .success(merchant):
                self?.secondView.coinUsedValue.text = String(merchant.individualCoins?.filter({ $0.coinType == "local" }).first?.outstanding ?? 0)
                self?.firstView.merchantNameValue.text = merchant.name
            case let .failure(failure):
                print(failure)
            }
        }

        purchasePusherService?.purchase(customerId: user.id, merchantId: merchantId) { [weak self] response in
            guard let self = self, let coins = self.secondView.coinUsedValue.text, let coins = Int(coins), let purchase = response.purchase else { return }
            self.apiRequest.requestPurchase(merchantId: self.merchantId, coinsUsed: self.isUseCoinActive ? coins : 0, isRequestingForToken: self.isGetTokenActive) { [weak self] response in
                guard let self = self else { return }
                switch response {
                case .success:
                    self.purchasePusherService?.disconnect()
                    self.merchantsProcessViewModel.fetchMerchants()
                    self.activeTokensViewModel.fetchTokens()
                    self.alertWaiting.dismiss(animated: true, completion: {
                        self.alertSuccess.title = "Congratulations!"
                        self.alertSuccess.message = "Transaction success"
                        self.alertSuccess.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                            self.navigationController?.popViewController(animated: true)
                        }))
                        self.present(self.alertSuccess, animated: true, completion: nil)
                    })
                case let .failure(failure):
                    print(failure)
                }
            }
        }
    }

    init(merchantId: Int) {
        self.merchantId = merchantId
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CustomerPurchaseViewController: PusherDelegate {}

extension CustomerPurchaseViewController {
    func setupLayout() {
        setupLabel()
        setupFirstView()
        setupSecondView()
    }
    func setupLabel() {
        view.addSubview(instructionLabel)
        instructionLabel.setTopAnchorConstraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)
        instructionLabel.setLeadingAnchorConstraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30)
        instructionLabel.setTrailingAnchorConstraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30)
    }
    func setupFirstView() {
        view.addSubview(firstView)
        firstView.translatesAutoresizingMaskIntoConstraints = false
        firstView.useCoinSwitch.isUserInteractionEnabled = true
        firstView.setTopAnchorConstraint(equalTo: instructionLabel.bottomAnchor, constant: 20)
        firstView.setLeadingAnchorConstraint(equalTo: view.leadingAnchor, constant: 20)
        firstView.setTrailingAnchorConstraint(equalTo: view.trailingAnchor, constant: -20)
    }
    func setupSecondView() {
        view.addSubview(secondView)
        secondView.translatesAutoresizingMaskIntoConstraints = false
        secondView.setTopAnchorConstraint(equalTo: firstView.useCoinSwitch.bottomAnchor, constant: 30)
        secondView.setLeadingAnchorConstraint(equalTo: view.leadingAnchor, constant: 20)
        secondView.setTrailingAnchorConstraint(equalTo: view.trailingAnchor, constant: -20)
    }
}
