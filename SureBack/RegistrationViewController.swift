//
//  RegistrationViewController.swift
//  SureBack
//
//  Created by Tubagus Adhitya Permana on 08/11/22.
//

import UIKit

class RegistrationViewController: UIViewController {
    private let titleTextView: UITextView = {
        let title = UITextView()
        title.text = "Hi! Let's join the \nrewarding program."
        title.font = UIFont.boldSystemFont(ofSize: 20)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.textAlignment = .center
        title.isEditable = false
        title.isScrollEnabled = false
        return title
    }()
    private let namelField: UITextField = {
        let nameField = UITextField()
        nameField.placeholder = "Name"
        nameField.layer.borderWidth = 1
        nameField.layer.borderColor = UIColor.black.cgColor
        return nameField
    }()
    private let usernamIGField: UITextField = {
        let usernamIGField = UITextField()
        usernamIGField.placeholder = "IG Username"
        usernamIGField.layer.borderWidth = 1
        usernamIGField.layer.borderColor = UIColor.black.cgColor
        return usernamIGField
    }()
    private let emaillField: UITextField = {
        let email = UITextField()
        email.placeholder = "Email"
        email.layer.borderWidth = 1
        email.layer.borderColor = UIColor.black.cgColor
        return email
    }()
    private let passwordField: UITextField = {
        let passField = UITextField()
        passField.placeholder = "Password"
        passField.layer.borderWidth = 1
        passField.isSecureTextEntry = true
        passField.layer.borderColor = UIColor.black.cgColor
        return passField
    }()
    private let confirmPasswordField: UITextField = {
        let confirmPassField = UITextField()
        confirmPassField.placeholder = "Confirm Password"
        confirmPassField.layer.borderWidth = 1
        confirmPassField.isSecureTextEntry = true
        confirmPassField.layer.borderColor = UIColor.black.cgColor
        return confirmPassField
    }()
    private let haveAnAccountLabel: UILabel = {
        let label = UILabel()
        label.text = "Have an account, "
        label.font = UIFont.systemFont(ofSize: 15)
        label.sizeToFit()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let toSignInLabel: UILabel = {
        let label = UILabel()
        label.text = "Sign In"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .blue
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = true
        return label
    }()
    private let signUpButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Join", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.layer.cornerRadius = 10
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTitle()
        setupTextFields()
        setupAlreadyHaveAccount()
        setupButton()
        signUpButton.addTarget(self, action: #selector(signUpTapped), for: .touchUpInside)
        toSignInLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(signInTapped)))
    }
    @objc func signUpTapped() {
        print("Tapped")
    }
    @objc func signInTapped() {
        print("Sign in tapped")
    }
}

extension RegistrationViewController {
    private func setupTitle() {
        view.addSubview(titleTextView)
        titleTextView.setTopAnchorConstraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50)
        titleTextView.setLeftAnchorConstraint(equalTo: view.leftAnchor)
        titleTextView.setRightAnchorConstraint(equalTo: view.rightAnchor)
    }
    private func setupTextFields() {
        let stackView = UIStackView(arrangedSubviews: [namelField, usernamIGField, emaillField, passwordField, confirmPasswordField])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        stackView.setTopAnchorConstraint(equalTo: titleTextView.bottomAnchor, constant: 50)
        stackView.setLeftAnchorConstraint(equalTo: view.leftAnchor, constant: 40)
        stackView.setRightAnchorConstraint(equalTo: view.rightAnchor, constant: -40)
        stackView.heightAnchor.constraint(equalToConstant: 250).isActive = true
    }
    private func setupAlreadyHaveAccount() {
        let stackView = UIStackView(arrangedSubviews: [haveAnAccountLabel, toSignInLabel])
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        stackView.setTopAnchorConstraint(equalTo: confirmPasswordField.bottomAnchor, constant: 10)
        stackView.setCenterXAnchorConstraint(equalTo: view.centerXAnchor)
    }
    private func setupButton() {
        view.addSubview(signUpButton)
        signUpButton.setLeadingAnchorConstraint(equalTo: view.leadingAnchor, constant: 40)
        signUpButton.setTrailingAnchorConstraint(equalTo: view.trailingAnchor, constant: -40)
        signUpButton.setBottomAnchorConstraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    }
}
