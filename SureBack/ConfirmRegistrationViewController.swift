//
//  ConfirmRegistrationViewController.swift
//  SureBack
//
//  Created by Tubagus Adhitya Permana on 08/11/22.
//

import UIKit

class ConfirmRegistrationViewController: UIViewController {
    var responseOTP: RequestInstagramOTPResponse?
    var dataRegister: Register?
    private let title1TextView: UITextView = {
        let title = UITextView()
        title.text = "You're almost there!"
        title.font = UIFont.boldSystemFont(ofSize: 20)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.textAlignment = .center
        title.isEditable = false
        title.isScrollEnabled = false
        return title
    }()
    private let title2TextView: UITextView = {
        let title = UITextView()
        title.text = "Introduce yourself by sending the code \nbelow to our instagram account"
        title.font = UIFont.systemFont(ofSize: 15)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.textAlignment = .center
        title.isEditable = false
        title.isScrollEnabled = false
        return title
    }()
    private let otpTextView: UITextView = {
        let otp = UITextView()
        otp.text = "Kosong"
        otp.font = UIFont.boldSystemFont(ofSize: 40)
        otp.translatesAutoresizingMaskIntoConstraints = false
        otp.textAlignment = .center
        otp.isEditable = false
        otp.isScrollEnabled = false
        return otp
    }()
    private let surebackAccountLabel: UILabel = {
        let label = UILabel()
        label.text = "SuraBack's account"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .blue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let checkOtpButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitle("Already sent it", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.layer.cornerRadius = 10
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTitle1()
        setupTitle2()
        setupOtp()
        setupSurebackAccountLabel()
        setupCheckOTPButton()
        checkOtpButton.addTarget(self, action: #selector(checkOtp), for: .touchUpInside)
    }
    @objc func checkOtp() {
        guard let name = dataRegister?.name, !name.isEmpty else {return}
        guard let usernameIG = dataRegister?.usernameIG, !usernameIG.isEmpty else {return}
        guard let email = dataRegister?.email, !email.isEmpty else {return}
        guard let password = dataRegister?.password, !password.isEmpty else {return}
        guard let role = dataRegister?.role, !role.isEmpty else {return}
        let request = RequestFunction()
        request.register(
            name: name,
            email: email,
            password: password,
            role: role,
            username: usernameIG) { data, error in
                if error != nil {
                    self.showAlert(title: "Error", message: error?.localizedDescription ?? "", action: "Okey")
                    return
                }
                let mainVC = IsLoginViewController()
                self.navigationController?.pushViewController(mainVC, animated: true)
            }
    }
    
}

extension ConfirmRegistrationViewController {
    private func setupTitle1() {
        view.addSubview(title1TextView)
        title1TextView.setTopAnchorConstraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50)
        title1TextView.setLeadingAnchorConstraint(equalTo: view.leadingAnchor)
        title1TextView.setTrailingAnchorConstraint(equalTo: view.trailingAnchor)
    }
    private func setupTitle2() {
        view.addSubview(title2TextView)
        title2TextView.setTopAnchorConstraint(equalTo: title1TextView.bottomAnchor)
        title2TextView.setLeadingAnchorConstraint(equalTo: view.leadingAnchor)
        title2TextView.setTrailingAnchorConstraint(equalTo: view.trailingAnchor)
    }
    private func setupOtp() {
        guard let otp = responseOTP?.otp else {return}
        otpTextView.text = "\(otp)"
        view.addSubview(otpTextView)
        otpTextView.setTopAnchorConstraint(equalTo: title2TextView.bottomAnchor)
        otpTextView.setLeadingAnchorConstraint(equalTo: view.leadingAnchor)
        otpTextView.setTrailingAnchorConstraint(equalTo: view.trailingAnchor)
    }
    private func setupSurebackAccountLabel() {
        view.addSubview(surebackAccountLabel)
        surebackAccountLabel.setTopAnchorConstraint(equalTo: otpTextView.bottomAnchor)
        surebackAccountLabel.setLeadingAnchorConstraint(equalTo: view.leadingAnchor)
        surebackAccountLabel.setTrailingAnchorConstraint(equalTo: view.trailingAnchor)
    }
    private func setupCheckOTPButton() {
        view.addSubview(checkOtpButton)
        checkOtpButton.setBottomAnchorConstraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        checkOtpButton.setLeadingAnchorConstraint(equalTo: view.leadingAnchor, constant: 50)
        checkOtpButton.setTrailingAnchorConstraint(equalTo: view.trailingAnchor, constant: -50)
    }
}
