//
//  FormRegistrationViewController+SetupUI.swift
//  SureBack
//
//  Created by Tubagus Adhitya Permana on 30/11/22.
//

import UIKit

extension FormRegistrationViewController {
    func setupLayout() {
        setupTitle()
        setupTextFields()
        setupButton()
        setupAlreadyHaveAccount()
    }
    private func setupTitle() {
        view.addSubview(titleLabel)
        titleLabel.setTopAnchorConstraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30)
        titleLabel.setLeftAnchorConstraint(equalTo: view.leftAnchor)
        titleLabel.setRightAnchorConstraint(equalTo: view.rightAnchor)
    }
    private func setupTextFields() {
        let stackView = UIStackView(arrangedSubviews: [
            nameField,
            usernamIGField,
            emaillField,
            passwordField,
            confirmPasswordField])
        stackView.axis = .vertical
        stackView.spacing = 25
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        stackView.setTopAnchorConstraint(equalTo: titleLabel.bottomAnchor, constant: 40)
        stackView.setLeftAnchorConstraint(equalTo: view.leftAnchor, constant: 16)
        stackView.setRightAnchorConstraint(equalTo: view.rightAnchor, constant: -16)
        stackView.heightAnchor.constraint(equalToConstant: 350).isActive = true
        view.addSubview(igUsernameMessageError)
        igUsernameMessageError.translatesAutoresizingMaskIntoConstraints = false
        igUsernameMessageError.setTopAnchorConstraint(equalTo: usernamIGField.bottomAnchor, constant: 5)
        igUsernameMessageError.setLeadingAnchorConstraint(equalTo: view.leadingAnchor, constant: 26)
        igUsernameMessageError.setTrailingAnchorConstraint(equalTo: view.trailingAnchor, constant: -26)
        view.addSubview(emailMessageError)
        emailMessageError.translatesAutoresizingMaskIntoConstraints = false
        emailMessageError.setTopAnchorConstraint(equalTo: emaillField.bottomAnchor, constant: 5)
        emailMessageError.setLeadingAnchorConstraint(equalTo: view.leadingAnchor, constant: 26)
        emailMessageError.setTrailingAnchorConstraint(equalTo: view.trailingAnchor, constant: -26)
        view.addSubview(passwordMessageError)
        passwordMessageError.translatesAutoresizingMaskIntoConstraints = false
        passwordMessageError.setTopAnchorConstraint(equalTo: passwordField.bottomAnchor, constant: 5)
        passwordMessageError.setLeadingAnchorConstraint(equalTo: view.leadingAnchor, constant: 26)
        passwordMessageError.setTrailingAnchorConstraint(equalTo: view.trailingAnchor, constant: -26)
        view.addSubview(confirmPasswordMessageError)
        confirmPasswordMessageError.translatesAutoresizingMaskIntoConstraints = false
        confirmPasswordMessageError.setTopAnchorConstraint(equalTo: confirmPasswordField.bottomAnchor, constant: 5)
        confirmPasswordMessageError.setLeadingAnchorConstraint(equalTo: view.leadingAnchor, constant: 26)
        confirmPasswordMessageError.setTrailingAnchorConstraint(equalTo: view.trailingAnchor, constant: -26)
    }
    private func setupAlreadyHaveAccount() {
        let stackView = UIStackView(arrangedSubviews: [haveAnAccountLabel, toSignInLabel])
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        stackView.setBottomAnchorConstraint(equalTo: signUpButton.topAnchor, constant: -16)
        stackView.setCenterXAnchorConstraint(equalTo: view.centerXAnchor)
    }
    private func setupButton() {
        view.addSubview(signUpButton)
        signUpButton.setLeadingAnchorConstraint(equalTo: view.leadingAnchor, constant: 16)
        signUpButton.setTrailingAnchorConstraint(equalTo: view.trailingAnchor, constant: -16)
        signUpButton.setBottomAnchorConstraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -22)
    }
}
