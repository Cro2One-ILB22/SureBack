//
//  CustomerProfileViewController.swift
//  SureBack
//
//  Created by Ditha Nurcahya Avianty on 17/11/22.
//

import SDWebImage
import UIKit

class CustomerProfileViewController: UIViewController {

    let request = RequestFunction()

    var user: UserInfoResponse!

    let scrollView = UIScrollView()
    let contentView = UIView()
    var profileImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        return image
    }()
    let profileName: UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textAlignment = .center
        return label
    }()
    let profileLevel: UILabel = {
        let label = UILabel()
        label.text = "Nano"
        label.textAlignment = .center
        return label
    }()
    let profileUsernameIg: UILabel = {
        let label = UILabel()
        label.text = "@usernameIG"
        label.textAlignment = .center
        return label
    }()
    let emailCardField: CardFieldView = {
        let card = CardFieldView()
        card.title.text = "Email"
        return card
    }()
    lazy var logoutButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .red
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Logout", for: .normal)
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(logout), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()

        profileImage.sd_setImage(
            with: URL(string: user.profilePicture),
            placeholderImage: UIImage(named: "system.photo"),
            options: .progressiveLoad,
            completed: nil
        )
        profileName.text = user.name
        profileLevel.text = "Nano"
        profileUsernameIg.text = ("@\(user.instagramUsername)")
        emailCardField.value.text = user.email
    }
    
    @objc func logout() {
        print("Logout tapped")
        request.postLogout { data in
            switch data {
            case let .success:
                do {
                    print("logout success")
                    let loginVC = LoginViewController()
                    let navLogin = UINavigationController(rootViewController: loginVC)
                    navLogin.modalPresentationStyle = .fullScreen
                    self.present(navLogin, animated: true, completion: nil)
                    self.showAlert(title: "Success", message: "Success Log Out", action: "Ok")
                } catch let error as NSError {
                    print(error.description)
                }
            case .failure:
                break
            }
        }
    }
}

extension CustomerProfileViewController {
    private func setupLayout() {
        setupProfileImage()
        setupProfileName()
        setupProfileLevel()
        setupProfileUsernameIG()
        setupCardField()
        setupButton()
    }
    func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.setCenterXAnchorConstraint(equalTo: view.centerXAnchor)
        scrollView.setWidthAnchorConstraint(equalTo: view.widthAnchor)
        scrollView.setTopAnchorConstraint(equalTo: view.topAnchor)
        scrollView.setBottomAnchorConstraint(equalTo: view.bottomAnchor)
        contentView.setCenterXAnchorConstraint(equalTo: scrollView.centerXAnchor)
        contentView.setWidthAnchorConstraint(equalTo: scrollView.widthAnchor)
        contentView.setTopAnchorConstraint(equalTo: scrollView.topAnchor)
        contentView.setBottomAnchorConstraint(equalTo: scrollView.bottomAnchor)
    }
    private func setupProfileImage() {
        view.addSubview(profileImage)
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        profileImage.setWidthAnchorConstraint(equalToConstant: 100)
        profileImage.setHeightAnchorConstraint(equalToConstant: 100)
        profileImage.setTopAnchorConstraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10)
        profileImage.setCenterXAnchorConstraint(equalTo: view.centerXAnchor)
    }
    private func setupProfileName() {
        view.addSubview(profileName)
        profileName.translatesAutoresizingMaskIntoConstraints = false
        profileName.setTopAnchorConstraint(equalTo: profileImage.bottomAnchor, constant: 10)
        profileName.setTrailingAnchorConstraint(equalTo: view.trailingAnchor, constant: -20)
        profileName.setLeadingAnchorConstraint(equalTo: view.leadingAnchor, constant: 20)
    }
    private func setupProfileLevel() {
        view.addSubview(profileLevel)
        profileLevel.translatesAutoresizingMaskIntoConstraints = false
        profileLevel.setTopAnchorConstraint(equalTo: profileName.bottomAnchor, constant: 10)
        profileLevel.setTrailingAnchorConstraint(equalTo: view.trailingAnchor, constant: -10)
        profileLevel.setLeadingAnchorConstraint(equalTo: view.leadingAnchor, constant: 10)
    }
    private func setupProfileUsernameIG() {
        view.addSubview(profileUsernameIg)
        profileUsernameIg.translatesAutoresizingMaskIntoConstraints = false
        profileUsernameIg.setTopAnchorConstraint(equalTo: profileLevel.bottomAnchor, constant: 10)
        profileUsernameIg.setTrailingAnchorConstraint(equalTo: view.trailingAnchor, constant: -10)
        profileUsernameIg.setLeadingAnchorConstraint(equalTo: view.leadingAnchor, constant: 10)
    }
    private func setupCardField() {
        view.addSubview(emailCardField)
        emailCardField.translatesAutoresizingMaskIntoConstraints = false
        emailCardField.setTopAnchorConstraint(equalTo: profileUsernameIg.bottomAnchor, constant: 20)
        emailCardField.setTrailingAnchorConstraint(equalTo: view.trailingAnchor, constant: -20)
        emailCardField.setLeadingAnchorConstraint(equalTo: view.leadingAnchor, constant: 20)
    }
    private func setupButton() {
        view.addSubview(logoutButton)
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.setTopAnchorConstraint(equalTo: view.bottomAnchor, constant: 20)
        logoutButton.setLeftAnchorConstraint(equalTo: view.leftAnchor, constant: 20)
        logoutButton.setRightAnchorConstraint(equalTo: view.rightAnchor, constant: -20)
        logoutButton.setBottomAnchorConstraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
    }
}
