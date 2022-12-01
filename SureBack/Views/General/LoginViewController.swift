//
//  LoginViewController.swift
//  SureBack
//
//  Created by Ditha Nurcahya Avianty on 05/11/22.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
    let request = RequestFunction()

    let titleTextView: UITextView = {
        let textView = UITextView()
        textView.text = "Let's join \nthe rewarding program!"
        textView.font = UIFont.boldSystemFont(ofSize: 20)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()

    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Email"
        textField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return textField
    }()

    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Password"
        textField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        textField.isSecureTextEntry = true
        return textField
    }()

    let firstLabel: UILabel = {
        let label = UILabel()
        label.text = "Don't have an account yet, "
        label.font = UIFont.systemFont(ofSize: 15)
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let toRegisterLabel: UILabel = {
        let label = UILabel()
        label.text = "join now"
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .blue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let loginButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .gray
        button.isEnabled = false
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Login", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.layer.cornerRadius = 10
        return button
    }()
    private let loadingIndicator: UIActivityIndicatorView = {
        let loading = UIActivityIndicatorView()
        loading.style = .gray
        loading.translatesAutoresizingMaskIntoConstraints = false
        loading.isHidden = true
        return loading
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true

        setupTitle()
        setupTextFields()
        setupToRegister()
        setupButton()
        setupLoadingIndicator()

        passwordTextField.enablePasswordToggle()
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        toRegisterLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(registerButtonTapped)))
        toRegisterLabel.isUserInteractionEnabled = true

        emailTextField.addTarget(self, action: #selector(handleTextChanged), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(handleTextChanged), for: .editingChanged)
    }

    @objc func handleTextChanged() {
        guard let email = emailTextField.text,
              let password = passwordTextField.text else {
            return
        }
        let isFormFilled = !email.isEmpty && !password.isEmpty
        if isFormFilled {
            loginButton.backgroundColor = .blue
            loginButton.isEnabled = true
        } else {
            loginButton.backgroundColor = .gray
            loginButton.isEnabled = false
        }
    }

    @objc func loginButtonTapped() {
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            return print("email or password is nil")
        }
        if email.isEmpty || password.isEmpty {
            let alert = UIAlertController(title: "Failed to Login", message: "Please fill all field!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("Try Again", comment: "Default action"), style: .default))
            present(alert, animated: true, completion: nil)
        }
        request.postLogin(email: email.lowercased(), password: password) { data in
            print(data)
            switch data {
            case .success:
                self.navigationController?.pushViewController(TabBarViewController(), animated: true)
                self.navigationController?.isNavigationBarHidden = true
//                self.showAlert(title: "Success", message: "Success Log In", action: "Ok")
            case .failure:
                print("Failed to Login")
                self.showAlert(title: "Wrong Email or Password", message: "Please try again", action: "Ok")
            }
        }
    }

    @objc func registerButtonTapped(sender: UITapGestureRecognizer) {
        let registerVC = ChooseRoleRegistrationViewController()
        navigationController?.pushViewController(registerVC, animated: true)
        self.navigationController?.isNavigationBarHidden = true
    }

}

extension LoginViewController {
    private func setupTitle() {
        view.addSubview(titleTextView)
        titleTextView.setTopAnchorConstraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30)
        titleTextView.setLeftAnchorConstraint(equalTo: view.leftAnchor)
        titleTextView.setRightAnchorConstraint(equalTo: view.rightAnchor)
    }
    private func setupTextFields() {
        let stackView = UIStackView(arrangedSubviews: [emailTextField,
                                                       passwordTextField])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        stackView.setCenterXAnchorConstraint(equalTo: view.centerXAnchor)
        stackView.setTopAnchorConstraint(equalTo: titleTextView.bottomAnchor, constant: 50)
        stackView.setLeadingAnchorConstraint(equalTo: view.leadingAnchor, constant: 30)
    }
    private func setupToRegister() {
        let stackView = UIStackView(arrangedSubviews: [firstLabel, toRegisterLabel])
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        stackView.setTopAnchorConstraint(equalTo: passwordTextField.bottomAnchor, constant: 15)
        stackView.setCenterXAnchorConstraint(equalTo: view.centerXAnchor)
    }
    private func setupButton() {
        view.addSubview(loginButton)
        loginButton.setLeadingAnchorConstraint(equalTo: view.leadingAnchor, constant: 40)
        loginButton.setTrailingAnchorConstraint(equalTo: view.trailingAnchor, constant: -40)
        loginButton.setBottomAnchorConstraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
    }
    private func setupLoadingIndicator() {
        view.addSubview(loadingIndicator)
        loadingIndicator.setCenterXAnchorConstraint(equalTo: view.centerXAnchor)
        loadingIndicator.setCenterYAnchorConstraint(equalTo: view.centerYAnchor)
    }
}