//
//  MerchantFormBusinessSettingViewController.swift
//  SureBack
//
//  Created by Tubagus Adhitya Permana on 01/12/22.
//

import RxSwift
import SDWebImage
import UIKit

class MerchantFormBusinessSettingViewController: UIViewController {
    let apiRequest = RequestFunction()
    let viewModel = UserViewModel.shared
    var percentCashbackCoinLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        label.text = "Percent Cashback Poin(s)"
        return label
    }()
    var maximumCashbackCoinLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        label.text = "Maximum Cashback Poin(s)"
        return label
    }()
    var tokenLimitLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        label.text = "Token Limit"
        return label
    }()
    var cashbackMethodLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        label.text = "Cashback Method"
        return label
    }()
    var percentCashbackCoinField: CustomTextField = {
        let field = CustomTextField(insets: UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12))
        field.keyboardType = .numberPad
        return field
    }()
    var maximumCashbackCoinField: CustomTextField = {
        let field = CustomTextField(insets: UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12))
        field.keyboardType = .numberPad
        return field
    }()
    var tokenLimitField: CustomTextField = {
        let field = CustomTextField(insets: UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12))
        field.keyboardType = .numberPad
        return field
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
    var cashbackMethodField: CustomTextField = CustomTextField(insets: UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12))
    var snackBarMessage: SnackBarMessage?
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Business Setting"
        let saveButton = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveButtonTapped))
        navigationItem.rightBarButtonItem = saveButton
        setupLayout()
        configure()
        snackBarMessage = SnackBarMessage()
    }
    func configure() {
        guard let user = viewModel.user else {return}
        let percentCashbackCoin = user.merchantDetail?.cashbackPercent ?? 0
        let maximumCashbackCoin = user.merchantDetail?.cashbackLimit ?? 0
        let tokenLimit = user.merchantDetail?.dailyTokenLimit ?? 0
        percentCashbackCoinField.text = "\(percentCashbackCoin)"
        maximumCashbackCoinField.text = "\(maximumCashbackCoin)"
        tokenLimitField.text = "\(tokenLimit)"
    }
    @objc func saveButtonTapped() {
        present(alertWaiting, animated: true)
        guard let user = viewModel.user else {return}
        guard let percentCashbackCoin = Float(percentCashbackCoinField.text ?? "0.0") else {return}
        guard let maximumCashbackCoin = Int(maximumCashbackCoinField.text ?? "0") else {return}
        guard let tokenLimit = Int(tokenLimitField.text ?? "0") else {return}
        apiRequest.updateMerchantDetail(cashbackPercent: percentCashbackCoin, cashbackLimit: maximumCashbackCoin, dailyTokenLimit: tokenLimit) {[weak self] _, statusCode in
            guard let self = self else {return}
            self.alertWaiting.dismiss(animated: true)
            guard let statusCode = statusCode else {return}
            if statusCode != 200 {
                self.snackBarMessage?.showResponseMessage(statusCode: statusCode)
                return
            }
            user.merchantDetail?.cashbackPercent = percentCashbackCoin
            user.merchantDetail?.cashbackLimit = maximumCashbackCoin
            user.merchantDetail?.dailyTokenLimit = tokenLimit
            self.viewModel.userSubject.on(.next(user))
            self.navigationController?.popViewController(animated: true)
        }
    }
}

extension MerchantFormBusinessSettingViewController {
    private func setupLayout() {
        setupTextField()
    }

    private func setupTextField() {
        let stackView = UIStackView(arrangedSubviews: [percentCashbackCoinLabel, percentCashbackCoinField, maximumCashbackCoinLabel, maximumCashbackCoinField, tokenLimitLabel, tokenLimitField, cashbackMethodLabel, cashbackMethodField])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stackView)
        stackView.setTopAnchorConstraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30)
        stackView.setLeadingAnchorConstraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20)
        stackView.setTrailingAnchorConstraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)

        percentCashbackCoinField.setHeightAnchorConstraint(equalToConstant: 40)
        maximumCashbackCoinField.setHeightAnchorConstraint(equalToConstant: 40)
        tokenLimitField.setHeightAnchorConstraint(equalToConstant: 40)
        cashbackMethodField.setHeightAnchorConstraint(equalToConstant: 40)
    }
}
