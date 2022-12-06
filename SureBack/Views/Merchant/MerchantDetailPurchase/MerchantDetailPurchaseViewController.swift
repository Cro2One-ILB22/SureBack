//
//  MerchantDetailPurchase.swift
//  SureBack
//
//  Created by Tubagus Adhitya Permana on 05/12/22.
//

import UIKit

class MerchantDetailPurchaseViewController: UIViewController {
    private weak var presenter: UIViewController?
    var purchasePusherService: PurchasePusherSerivce?
    var totalPurchase: Int = 0 {
        didSet {
            totalPurchaseValueLabel.text = String(totalPurchase)
        }
    }
    let customerId: Int
    var customer: UserInfoResponse?
    var qrScanPurchase: QRScanPurchase?
    let apiRequest = RequestFunction()
    let userViewModel = UserViewModel.shared
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
        apiRequest.getCustomerById(id: customerId) { [weak self] response in
            switch response {
            case .success(let customer):
            guard let self = self, let merchant = self.userViewModel.user else { return }
                self.setupContent(customer: customer, merchant: merchant)
                self.customer = customer
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
                let percentCashback = self.userViewModel.user?.merchantDetail?.cashbackPercent ?? 0
                let coinsUsed = purchaseRequest.coinsUsed
                self.exchangedCoinValueLabel.text = String(coinsUsed)
                self.exchangedCoinValueLabel.font = .systemFont(ofSize: 15)
                self.exchangedCoinValueLabel.textColor = .black
                self.makePurchaseButton.isEnabled = true
                self.makePurchaseButton.backgroundColor = .tealishGreen
                self.totalPaymentValueLabel.text = String(self.totalPurchase - coinsUsed)
                self.cashbackCoinValueLabel.text = String(Int(self.userViewModel.user?.merchantDetail?.cashbackCalculationMethod == "payment_amount" ? (Float(self.totalPaymentValueLabel.text ?? "") ?? 0) * percentCashback : Float(self.totalPurchase) * percentCashback) / 100)
            }
        }
        view.backgroundColor = .porcelain
        makePurchaseButton.addTarget(self, action: #selector(generateTokenAction), for: .touchUpInside)
        setupLayout()
        snackBarMessage = SnackBarMessage()
        editImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapEdit)))
    }
    @objc func didTapEdit() {
        let sheetInputTotalPurchase = TotalPurchaseFormViewController(presenter: self, customerId: customerId)
        sheetInputTotalPurchase.totalPurchase = ""
        present(sheetInputTotalPurchase, animated: true)
    }
    @objc func generateTokenAction() {
        present(alertWaiting, animated: true)
        guard let purchaseRequest = qrScanPurchase?.purchaseRequest else { return }
        guard let purchaseAmount = totalPurchaseValueLabel.text, let purchaseAmount = Int(purchaseAmount) else { return }
        let isRequestingToken = purchaseRequest.isRequestingForToken ? 1 : 0
        let coinUsed = purchaseRequest.coinsUsed
        generateToken(purchaseAmount: purchaseAmount, coinUsed: coinUsed, isRequestingToken: isRequestingToken)
    }

    private func generateToken(purchaseAmount: Int, coinUsed: Int, isRequestingToken: Int) {
        apiRequest.postGenerateTokenOffline(
            customerId: self.customerId, purchaseAmount: purchaseAmount, coinUsed: coinUsed, isRequestingToken: isRequestingToken) {[weak self] data, statusCode in
            guard let self = self else {return}
            guard let statusCode = statusCode else {return}
                self.userViewModel.fetchUser()
                self.alertWaiting.dismiss(animated: true) {
                    if statusCode != 200 {
                        self.snackBarMessage?.showResponseMessage(statusCode: statusCode)
                        return
                    }
                    let detailTransactionVC = MerchantTransactionHistoryViewController()
                    detailTransactionVC.customer = self.customer
                    detailTransactionVC.purchaseData = data
                    detailTransactionVC.onDismiss = {
                        self.navigationController?.popToRootViewController(animated: true)
                    }
                    self.present(detailTransactionVC, animated: true)
                }
        }
    }

    func setupContent(customer: UserInfoResponse, merchant: UserInfoResponse) {
        customerNameValueLabel.text = customer.name
        percentageValueLabel.text = String(merchant.merchantDetail?.cashbackPercent ?? 0)
    }

    init(presenter: UIViewController, customerId: Int) {
        self.presenter = presenter
        self.customerId = customerId
        self.totalPurchaseValueLabel.text = String(totalPurchase)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
