//
//  MerchantGenerateTokenFormViewController.swift
//  SureBack
//
//  Created by Tubagus Adhitya Permana on 28/11/22.
//

import UIKit

class MerchantGenerateTokenFormViewController: UIViewController {
    var purchasePusherService: PurchasePusherSerivce?
    let customerId: Int
    var customer: UserInfoResponse?
    var qrScanPurchase: QRScanPurchase?
    let apiRequest = RequestFunction()
    let userViewModel = UserViewModel.shared

    let coinTransactionTextLabel: UILabel = {
        let label = UILabel()
        label.text = "Coin Transaction"
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let customerNameTextLabel: UILabel = {
        let label = UILabel()
        label.text = "Customer name"
        label.font = .systemFont(ofSize: 15)
        label.textColor = .osloGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let purchaseDateTextLabel: UILabel = {
        let label = UILabel()
        label.text = "Purchase date"
        label.font = .systemFont(ofSize: 15)
        label.textColor = .osloGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let percentageTextLabel: UILabel = {
        let label = UILabel()
        label.text = "Percentage"
        label.font = .systemFont(ofSize: 15)
        label.textColor = .osloGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let expiredDateTextLabel: UILabel = {
        let label = UILabel()
        label.text = "Expired Date"
        label.font = .systemFont(ofSize: 15)
        label.textColor = .osloGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let exchangedCoinTextLabel: UILabel = {
        let label = UILabel()
        label.text = "Exchanged Coins"
        label.font = .systemFont(ofSize: 15)
        label.textColor = .osloGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let totalPurchaseTextLabel: UILabel = {
        let label = UILabel()
        label.text = "Total Purchase"
        label.font = .systemFont(ofSize: 15)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let customerNameValueLabel: UILabel = {
        let label = UILabel()
        label.text = "-"
        label.font = .systemFont(ofSize: 15)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let purchaseDateValueLabel: UILabel = {
        let label = UILabel()
        label.text = "-"
        label.font = .systemFont(ofSize: 15)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let percentageValueLabel: UILabel = {
        let label = UILabel()
        label.text = "-"
        label.font = .systemFont(ofSize: 15)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let expiredDateValueLabel: UILabel = {
        let label = UILabel()
        label.text = "-"
        label.font = .systemFont(ofSize: 15)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let exchangedCoinValueLabel: UILabel = {
        let label = UILabel()
        label.text = "-"
        label.font = .systemFont(ofSize: 15)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let totalPurchaseField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Total Purchase"
        textField.textContentType = .telephoneNumber
        textField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        textField.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width - 60).isActive = true
        return textField
    }()
    let generateTokenButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .tealishGreen
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Generate Token", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.layer.cornerRadius = 10
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        apiRequest.getCustomerById(id: customerId) { [weak self] response in
            switch response {
            case .success(let customer):
            guard let self = self, let merchant = self.userViewModel.user else { return }
                self.setupContent(customer: customer, merchant: merchant)
            case .failure(let error):
                print(error)
            }
        }

        purchasePusherService = PurchasePusherSerivce(delegate: self)

        guard let user = userViewModel.user else { return }
        purchasePusherService?.purchase(customerId: customerId, merchantId: user.id) { [weak self] response in

            guard let self = self else { return }
            self.qrScanPurchase = response
            if let purchaseRequest = response.purchaseRequest {
                self.exchangedCoinValueLabel.text = String(purchaseRequest.usedCoins)
            }
        }

        view.backgroundColor = .porcelain
        generateTokenButton.addTarget(self, action: #selector(generateTokenAction), for: .touchUpInside)
        setupLayout()
    }
    @objc func generateTokenAction() {
        print("Tapped")
        guard let purchaseRequest = qrScanPurchase?.purchaseRequest else { return }
        guard let purchaseAmount = totalPurchaseField.text, let purchaseAmount = Int(purchaseAmount) else { return }
        self.apiRequest.postGenerateTokenOffline(customerId: self.customerId, purchaseAmount: purchaseAmount, isRequestingToken: purchaseRequest.isRequestingForToken ? 1 : 0) { [weak self] response in
            switch response {
            case .success(let data):
                let detailTransactionVC = MerchantTransactionHistoryViewController()
                self?.present(detailTransactionVC, animated: true)
            case .failure(let error):
                print(error)
            }
        }
    }

    init(customerId: Int) {
        self.customerId = customerId
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupContent(customer: UserInfoResponse, merchant: UserInfoResponse) {
        customerNameValueLabel.text = customer.name
        purchaseDateValueLabel.text = String(DateFormatter.localizedString(from: Date(), dateStyle: .medium, timeStyle: .short))
        percentageValueLabel.text = String(merchant.merchantDetail?.cashbackPercent ?? 0)
        expiredDateValueLabel.text = String(DateFormatter.localizedString(from: Date().addingTimeInterval(18 * 60 * 60), dateStyle: .medium, timeStyle: .short))
    }
}
