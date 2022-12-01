//
//  ConfirmRegistrationViewController+SetupUI.swift
//  SureBack
//
//  Created by Tubagus Adhitya Permana on 24/11/22.
//

import UIKit

extension ConfirmRegistrationViewController {
    func setupLayout() {
        setupTitle1()
        setupTitle2()
        setupOTP()
        setupExpiresAndRenewCode()
        setupCheckOTPButton()
        setupSurebackAccountButton()
        setupLoadingIndicator()
    }
    private func setupTitle1() {
        view.addSubview(title1Label)
        title1Label.translatesAutoresizingMaskIntoConstraints = false
        title1Label.setTopAnchorConstraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50)
        title1Label.setLeadingAnchorConstraint(equalTo: view.leadingAnchor)
        title1Label.setTrailingAnchorConstraint(equalTo: view.trailingAnchor)
    }
    private func setupTitle2() {
        view.addSubview(title2Label)
        title2Label.translatesAutoresizingMaskIntoConstraints = false
        title2Label.setTopAnchorConstraint(equalTo: title1Label.bottomAnchor, constant: 16)
        title2Label.setLeadingAnchorConstraint(equalTo: view.leadingAnchor)
        title2Label.setTrailingAnchorConstraint(equalTo: view.trailingAnchor)
    }
    private func setupOTP() {
        let stackViewOTP = UIStackView(arrangedSubviews: [otpLabel, copyToClipboard])
        stackViewOTP.axis = .horizontal
        stackViewOTP.distribution = .fill
        stackViewOTP.backgroundColor = .white
        stackViewOTP.layer.cornerRadius = 10
        stackViewOTP.alignment = .center
        stackViewOTP.spacing = 10
        stackViewOTP.layoutMargins = UIEdgeInsets(top: 9, left: 41, bottom: 9, right: 41)
        stackViewOTP.isLayoutMarginsRelativeArrangement = true
        view.addSubview(stackViewOTP)
        stackViewOTP.translatesAutoresizingMaskIntoConstraints = false
        stackViewOTP.setTopAnchorConstraint(equalTo: title2Label.topAnchor, constant: 64)
        stackViewOTP.setCenterXAnchorConstraint(equalTo: view.centerXAnchor)
    }
    private func setupExpiresAndRenewCode() {
        let stackViewHorizontal = UIStackView(arrangedSubviews: [expiresLabel, renewCodeButton])
        stackViewHorizontal.axis = .horizontal
        stackViewHorizontal.distribution = .fill
        stackViewHorizontal.layer.cornerRadius = 10
        stackViewHorizontal.alignment = .center
        stackViewHorizontal.spacing = 45
        view.addSubview(stackViewHorizontal)
        stackViewHorizontal.translatesAutoresizingMaskIntoConstraints = false
        stackViewHorizontal.setTopAnchorConstraint(equalTo: otpLabel.topAnchor, constant: 64)
        stackViewHorizontal.setCenterXAnchorConstraint(equalTo: view.centerXAnchor)
    }
    private func setupCheckOTPButton() {
        view.addSubview(checkOtpButton)
        checkOtpButton.translatesAutoresizingMaskIntoConstraints = false
        checkOtpButton.setBottomAnchorConstraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        checkOtpButton.setLeadingAnchorConstraint(equalTo: view.leadingAnchor, constant: 32)
        checkOtpButton.setTrailingAnchorConstraint(equalTo: view.trailingAnchor, constant: -32)
    }
    private func setupSurebackAccountButton() {
        view.addSubview(surebackInstagramAccountButton)
        surebackInstagramAccountButton.translatesAutoresizingMaskIntoConstraints = false
        surebackInstagramAccountButton.setBottomAnchorConstraint(equalTo: checkOtpButton.topAnchor, constant: -10)
        surebackInstagramAccountButton.setLeadingAnchorConstraint(equalTo: view.leadingAnchor, constant: 32)
        surebackInstagramAccountButton.setTrailingAnchorConstraint(equalTo: view.trailingAnchor, constant: -32)
    }
    private func setupLoadingIndicator() {
        view.addSubview(loadingIndicator)
        loadingIndicator.setCenterXAnchorConstraint(equalTo: view.centerXAnchor)
        loadingIndicator.setCenterYAnchorConstraint(equalTo: view.centerYAnchor)
    }
}
