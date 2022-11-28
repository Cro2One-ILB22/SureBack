//
//  CustomerPurchaseViewController.swift
//  SureBack
//
//  Created by Muhamad Fahmi Al Kautsar on 27/11/22.
//

import PusherSwift
import UIKit

class CustomerPurchaseViewController: UIViewController {
    var purchasePusherService: PurchasePusherSerivce?
    let merchantId: Int
    let userViewModel = UserViewModel.shared
    let apiRequest = RequestFunction()
    var isTokenActive = true

    let balanceLabel: UILabel = {
        let label = UILabel()
        label.text = "Balance"
        label.font = UIFont.systemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let balanceTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 17)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    let getTokenLabel: UILabel = {
        let label = UILabel()
        label.text = "Get Token"
        label.font = UIFont.systemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let getTokenSwitch: UISwitch = {
        let switcher = UISwitch()
        switcher.isOn = true
        switcher.translatesAutoresizingMaskIntoConstraints = false
        return switcher
    }()

    let buttonGenerate: UIButton = {
        let button = UIButton(frame: CGRect(x: 100, y: 100, width: 200, height: 50))
        button.backgroundColor = .blue
        button.layer.cornerRadius = 15
        button.setTitle("Purchase", for: .normal)
        return button
    }()

    lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [balanceLabel,
                                                       balanceTextField,
                                                       getTokenLabel,
                                                       getTokenSwitch,
                                                       buttonGenerate])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }()

    let alert = UIAlertController(title: "Alert", message: "Message", preferredStyle: .alert)

    @objc func switchStateDidChange(_ sender: UISwitch!) {
        isTokenActive = sender.isOn
    }

    @objc func makePurchase() {
        guard let coinsUsed = balanceTextField.text, let coinsUsed = Int(coinsUsed) else { return }
        apiRequest.requestPurchase(merchantId: merchantId, usedCoins: coinsUsed, isRequestingForToken: getTokenSwitch.isOn) { [weak self] _ in
            guard let self = self else { return }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        purchasePusherService = PurchasePusherSerivce(delegate: self)

        mainStackView.translatesAutoresizingMaskIntoConstraints = false

        view.backgroundColor = .white
        view.addSubview(mainStackView)

        mainStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        mainStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true

        getTokenSwitch.addTarget(self, action: #selector(switchStateDidChange(_:)), for: .valueChanged)
        getTokenSwitch.setOn(true, animated: false)

        buttonGenerate.addTarget(self, action: #selector(makePurchase), for: .touchUpInside)

        guard let user = userViewModel.user else { return }

        apiRequest.getMerchantById(id: merchantId) { [weak self] response in
            switch response {
            case let .success(merchant):
                self?.balanceTextField.text = String(merchant.individualCoins?.filter({ $0.coinType == "local" }).first?.outstanding ?? 0)
            case let .failure(failure):
                print(failure)
            }
        }

        purchasePusherService?.purchase(customerId: user.id, merchantId: merchantId) { [weak self] response in
            guard let self = self, let coins = self.balanceTextField.text, let coins = Int(coins), let _ = response.purchase else { return }
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

extension CustomerPurchaseViewController: PusherDelegate {}
