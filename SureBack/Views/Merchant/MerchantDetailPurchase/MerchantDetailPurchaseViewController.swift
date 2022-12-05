//
//  MerchantDetailPurchase.swift
//  SureBack
//
//  Created by Tubagus Adhitya Permana on 05/12/22.
//

import UIKit

class MerchantDetailPurchaseViewController: UIViewController {
//    var purchasePusherService: PurchasePusherSerivce?
//    let customerId: Int
//    var customer: UserInfoResponse?
//    var qrScanPurchase: QRScanPurchase?
//    let apiRequest = RequestFunction()
//    let userViewModel = UserViewModel.shared
    let totalPurchaseTextLabel: UILabel = {
        let label = UILabel()
        label.text = "Total Purchase"
        label.font = .systemFont(ofSize: 15)
        label.textColor = .osloGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let editImage: UIImageView = {
        let image = UIImageView()
        image.isUserInteractionEnabled = true
        image.image = UIImage(named: "edit")
        return image
    }()
    let customerNameTextLabel: UILabel = {
        let label = UILabel()
        label.text = "Customer name"
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
    let exchangedCoinTextLabel: UILabel = {
        let label = UILabel()
        label.text = "Exchanged Coins"
        label.font = .systemFont(ofSize: 15)
        label.textColor = .osloGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let totalPaymentTextLabel: UILabel = {
        let label = UILabel()
        label.text = "Total Payment"
        label.font = .systemFont(ofSize: 15)
        label.textColor = .osloGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let cashbackCoinsTextLabel: UILabel = {
        let label = UILabel()
        label.text = "Cashback Coins"
        label.font = .systemFont(ofSize: 15)
        label.textColor = .osloGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let totalPurchaseValueLabel: UILabel = {
        let label = UILabel()
        label.text = "-"
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
    let percentageValueLabel: UILabel = {
        let label = UILabel()
        label.text = "-"
        label.font = .systemFont(ofSize: 15)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let exchangedCoinValueLabel: UILabel = {
        let label = UILabel()
        label.text = "Waiting for customer input"
        label.font = .italicSystemFont(ofSize: 15)
        label.textColor = .red
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let totalPaymentValueLabel: UILabel = {
        let label = UILabel()
        label.text = "-"
        label.font = .systemFont(ofSize: 15)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let cashbackCoinValueLabel: UILabel = {
        let label = UILabel()
        label.text = "-"
        label.font = .systemFont(ofSize: 15)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let makePurchaseButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .pastelGray
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Make Purchase", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.layer.cornerRadius = 10
        button.isEnabled = false
        return button
    }()
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
    var snackBarMessage: SnackBarMessage?
    override func viewDidLoad() {
        super.viewDidLoad()
//        apiRequest.getCustomerById(id: customerId) { [weak self] response in
//            switch response {
//            case .success(let customer):
//            guard let self = self, let merchant = self.userViewModel.user else { return }
//                self.setupContent(customer: customer, merchant: merchant)
//                self.customer = customer
//            case .failure(let error):
//                print(error)
//            }
//        }
//        purchasePusherService = PurchasePusherSerivce(delegate: self)
//        guard let user = userViewModel.user else { return }
//        purchasePusherService?.purchase(customerId: customerId, merchantId: user.id) { [weak self] response in
//            guard let self = self else { return }
//            self.qrScanPurchase = response
//            if let purchaseRequest = response.purchaseRequest {
//                self.exchangedCoinValueLabel.text = String(purchaseRequest.usedCoins)
//                self.exchangedCoinValueLabel.font = .systemFont(ofSize: 15)
//                self.exchangedCoinValueLabel.textColor = .black
//                self.generateTokenButton.isEnabled = true
//                self.generateTokenButton.backgroundColor = .tealishGreen
//            }
//        }
        view.backgroundColor = .porcelain
        makePurchaseButton.addTarget(self, action: #selector(generateTokenAction), for: .touchUpInside)
        setupLayout()
        snackBarMessage = SnackBarMessage()
        editImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapEdit)))
    }
    @objc func didTapEdit() {
        let sheetInputTotalPurchase = TotalPurchaseFormViewController()
        sheetInputTotalPurchase.totalPurchase = ""
        present(sheetInputTotalPurchase, animated: true)
    }
    @objc func generateTokenAction() {
        present(alertWaiting, animated: true)
//        guard let purchaseRequest = qrScanPurchase?.purchaseRequest else { return }
//        guard let purchaseAmount = totalPurchaseField.text, let purchaseAmount = Int(purchaseAmount) else { return }
//        let isRequestingToken = purchaseRequest.isRequestingForToken ? 1 : 0
//        let coinUser = purchaseRequest.usedCoins
//        generateToken(purchaseAmount: purchaseAmount, coinUser: coinUser, isRequestingToken: isRequestingToken)
    }
    private func generateToken(purchaseAmount: Int, coinUser: Int, isRequestingToken: Int) {
//        apiRequest.postGenerateTokenOffline(
//            customerId: self.customerId, purchaseAmount: purchaseAmount, isRequestingToken: isRequestingToken) {[weak self] data, statusCode in
//            guard let self = self else {return}
//            guard let statusCode = statusCode else {return}
//            self.alertWaiting.dismiss(animated: true)
//            if statusCode != 200 {
//                self.snackBarMessage?.showResponseMessage(statusCode: statusCode)
//                return
//            }
//            self.navigationController?.popToRootViewController(animated: true)
//            let detailTransactionVC = MerchantTransactionHistoryViewController()
//            detailTransactionVC.customer = self.customer
//            detailTransactionVC.purchaseData = data
//            self.present(detailTransactionVC, animated: true)
//        }
    }
//    init(customerId: Int) {
//        self.customerId = customerId
//        super.init(nibName: nil, bundle: nil)
//    }

//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }

    func setupContent(customer: UserInfoResponse, merchant: UserInfoResponse) {
        customerNameValueLabel.text = customer.name
//        purchaseDateValueLabel.text = String(DateFormatter.localizedString(from: Date(), dateStyle: .medium, timeStyle: .short))
        percentageValueLabel.text = String(merchant.merchantDetail?.cashbackPercent ?? 0)
//        expiredDateValueLabel.text = String(DateFormatter.localizedString(from: Date().addingTimeInterval(18 * 60 * 60), dateStyle: .medium, timeStyle: .short))
    }
}
