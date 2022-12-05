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
        textView.backgroundColor = .porcelain
        textView.text = "Hello there! Let's log in."
        textView.font = UIFont.boldSystemFont(ofSize: 22)
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
        textField.autocapitalizationType = .none
        return textField
    }()

    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Password"
        textField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        textField.isSecureTextEntry = true
        textField.autocapitalizationType = .none
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
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = .tealishGreen
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let loginButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .gray
//        button.isEnabled = false
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

    let alertWaiting = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .porcelain

        setupLayout()

        passwordTextField.enablePasswordToggle()
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        toRegisterLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(registerButtonTapped)))
        toRegisterLabel.isUserInteractionEnabled = true

        emailTextField.addTarget(self, action: #selector(handleTextChanged), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(handleTextChanged), for: .editingChanged)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }

    @objc func handleTextChanged() {
        guard let email = emailTextField.text,
              let password = passwordTextField.text else {
            return
        }
        let isFormFilled = !email.isEmpty && !password.isEmpty
        if isFormFilled {
            loginButton.backgroundColor = .tealishGreen
            loginButton.setTitleColor(.black, for: .normal)
            loginButton.isEnabled = true
        } else {
            loginButton.backgroundColor = .gray
            loginButton.isEnabled = false
        }
    }

    @objc func loginButtonTapped() {
        guard let email = emailTextField.text?.lowercased(), let password = passwordTextField.text else {
            return print("email or password is nil")
        }
        if email.isEmpty || password.isEmpty {
            let alert = UIAlertController(title: "Failed to Login", message: "Please fill all field!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("Try Again", comment: "Default action"), style: .default))
            present(alert, animated: true, completion: nil)
        }
        alertWaiting.view.tintColor = UIColor.black
        let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(10, 5, 50, 50)) as UIActivityIndicatorView
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating()
        alertWaiting.view.addSubview(loadingIndicator)
        present(alertWaiting, animated: true, completion: nil)
        request.postLogin(email: email.lowercased(), password: password) { [weak self] data in
            guard let self = self else {return}
            switch data {
            case .success:
                self.navigationController?.pushViewController(TabBarViewController(), animated: true)
                self.navigationController?.isNavigationBarHidden = true
                self.alertWaiting.dismiss(animated: true, completion: nil)
            case .failure:
                print("Failed to Login")
                self.alertWaiting.dismiss(animated: true, completion: {
                    self.showAlert(title: "Wrong Email or Password", message: "Please try again", action: "Ok")
                })
            }
        }
    }

    @objc func registerButtonTapped(sender: UITapGestureRecognizer) {
        let registerVC = ChooseRoleRegistrationViewController()
        navigationController?.pushViewController(registerVC, animated: true)
    }

}

extension LoginViewController {
    private func setupLayout() {
        setupTitle()
        setupTextFields()
        setupButton()
        setupToRegister()
        setupLoadingIndicator()
    }
    private func setupTitle() {
        view.addSubview(titleTextView)
        titleTextView.setTopAnchorConstraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50)
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
        stackView.setTopAnchorConstraint(equalTo: titleTextView.bottomAnchor, constant: 20)
        stackView.setLeadingAnchorConstraint(equalTo: view.leadingAnchor, constant: 30)
    }
    private func setupToRegister() {
        let stackView = UIStackView(arrangedSubviews: [firstLabel, toRegisterLabel])
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        stackView.setBottomAnchorConstraint(equalTo: loginButton.topAnchor, constant: -15)
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
