//
//  CustomerPurchase2ViewController.swift
//  SureBack
//
//  Created by Ditha Nurcahya Avianty on 30/11/22.
//

import PusherSwift
import UIKit

class CustomerPurchase2ViewController: UIViewController {
    var purchasePusherService: PurchasePusherSerivce?
    let merchantId: Int
    let userViewModel = UserViewModel.shared
    let apiRequest = RequestFunction()
    var isCoinActive = true

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

    let useCoinLabel: UILabel = {
        let label = UILabel()
        label.text = "Use Coin?"
        label.font = UIFont.systemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let useCoinSwitch: UISwitch = {
        let switcher = UISwitch()
        switcher.isOn = true
        switcher.translatesAutoresizingMaskIntoConstraints = false
        return switcher
    }()

    let merchantNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Merchant Name"
        label.textColor = .systemGray
        label.font = UIFont.systemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let merchantNameValue: UILabel = {
        let label = UILabel()
        label.text = "Bestie Cafe"
        label.font = UIFont.systemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let totalCoinLabel: UILabel = {
        let label = UILabel()
        label.text = "Total Coin"
        label.textColor = .systemGray
        label.font = UIFont.systemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let totalCoinValue: UILabel = {
        let label = UILabel()
        label.text = "2000 Coin"
        label.font = UIFont.systemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "Monday, 10 November 2022"
        label.font = UIFont.systemFont(ofSize: 17)
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "@Barbara"
        label.font = UIFont.systemFont(ofSize: 17)
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let alert = UIAlertController(title: "Alert", message: "Message", preferredStyle: .alert)

    @objc func switchStateDidChange(_ sender: UISwitch!) {
        isCoinActive = sender.isOn
    }

    @objc func makePurchase() {
        guard let coinsUsed = totalCoinValue.text, let coinsUsed = Int(coinsUsed) else { return }
        apiRequest.requestPurchase(merchantId: merchantId, usedCoins: coinsUsed, isRequestingForToken: useCoinSwitch.isOn) { [weak self] _ in
            guard let self = self else { return }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        purchasePusherService = PurchasePusherSerivce(delegate: self)
        
        view.backgroundColor = .white
        
        setupLayout()
        useCoinSwitch.addTarget(self, action: #selector(switchStateDidChange(_:)), for: .valueChanged)
        useCoinSwitch.setOn(true, animated: false)

        let redeemButton = UIBarButtonItem(title: "Redeem", style: .done, target: self, action: #selector(makePurchase))
        navigationItem.rightBarButtonItem = redeemButton
        navigationItem.rightBarButtonItem?.tintColor = .systemBlue
        navigationItem.title = "Use Coin"

        guard let user = userViewModel.user else { return }

        apiRequest.getMerchantById(id: merchantId) { [weak self] response in
            switch response {
            case let .success(merchant):
                self?.totalCoinValue.text = String(merchant.individualCoins?.filter({ $0.coinType == "local" }).first?.outstanding ?? 0)
            case let .failure(failure):
                print(failure)
            }
        }

        purchasePusherService?.purchase(customerId: user.id, merchantId: merchantId) { [weak self] response in
            guard let self = self, let coins = self.totalCoinValue.text, let coins = Int(coins), let _ = response.purchase else { return }
            self.apiRequest.requestPurchase(merchantId: self.merchantId, usedCoins: coins, isRequestingForToken: true) { [weak self] response in
                guard let self = self else { return }
                switch response {
                case .success:
                    self.purchasePusherService?.disconnect()
                    self.alert.addAction(UIAlertAction(title: "Click", style: .default, handler: nil))
                    self.present(self.alert, animated: true, completion: nil)
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

extension CustomerPurchase2ViewController: PusherDelegate {}

extension CustomerPurchase2ViewController {
    func setupLayout() {
        setupLabel()
//        setupView()
        setupDetails()
    }
    func setupLabel() {
        view.addSubview(instructionLabel)
        instructionLabel.setTopAnchorConstraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        instructionLabel.setLeadingAnchorConstraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20)
        instructionLabel.setTrailingAnchorConstraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
    }
//    func setupView() {
//        view.addSubview(purchaseView)
//        purchaseView.translatesAutoresizingMaskIntoConstraints = false
//        purchaseView.setTopAnchorConstraint(equalTo: instructionLabel.bottomAnchor, constant: 20)
//        purchaseView.setLeadingAnchorConstraint(equalTo: view.leadingAnchor, constant: 15)
//        purchaseView.setTrailingAnchorConstraint(equalTo: view.trailingAnchor, constant: -15)
//    }

    func setupDetails() {
        let stackGetToken = setupGetToken()
        let stackMerchantName = setupMerchantName()
        let stackTotalCoin = setupTotalCoin()
        let stackDateProfile = setupDateProfile()

        let stackview = UIStackView(arrangedSubviews: [stackGetToken, stackMerchantName, stackTotalCoin, stackDateProfile])
        stackview.backgroundColor = .white
        stackview.layer.borderWidth = 1
        stackview.layer.borderColor = UIColor.gray.cgColor
        stackview.layer.cornerRadius = 10
        stackview.axis = .vertical
        stackview.spacing = 30
        stackview.distribution = .fill
        stackview.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        stackview.isLayoutMarginsRelativeArrangement = true
        stackview.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stackview)
        stackview.setTopAnchorConstraint(equalTo: instructionLabel.bottomAnchor, constant: 20)
        stackview.setTrailingAnchorConstraint(equalTo: view.trailingAnchor, constant: -20)
        stackview.setLeadingAnchorConstraint(equalTo: view.leadingAnchor, constant: 20)
    }

    func setupGetToken() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [useCoinLabel, useCoinSwitch])
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }

    func setupMerchantName() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [merchantNameLabel, merchantNameValue])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }

    func setupTotalCoin() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [totalCoinLabel, totalCoinValue])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }

    func setupDateProfile() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [dateLabel, usernameLabel])
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }
}
