//
//  MerchantProfileViewController.swift
//  SureBack
//
//  Created by Tubagus Adhitya Permana on 16/11/22.
//

import UIKit

class MerchantProfileViewController: UIViewController {
    let scrollView = UIScrollView()
    let contentView = UIView()
    let profileImage: UIImageView = {
        let image = UIImageView()
        image.layer.borderWidth = 1
        image.layer.masksToBounds = false
        image.layer.borderColor = UIColor.black.cgColor
        image.layer.cornerRadius = image.frame.height/2
        image.clipsToBounds = true
        image.image = UIImage(named: "person.crop.circle")
        return image
    }()
    let profileName: UILabel = {
        let label = UILabel()
        label.text = "Name"
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
    let percentCashbackCardField: CardFieldView = {
        let card = CardFieldView()
        card.title.text = "Percent Cashback (%)"
        return card
    }()
    let cashbackMethodCardField: CardFieldView = {
        let card = CardFieldView()
        card.title.text = "Cashback Method"
        return card
    }()
    let tokenLimitMethodCardField: CardFieldView = {
        let card = CardFieldView()
        card.title.text = "Token limit"
        return card
    }()
    let cashbackLimitMethodCardField: CardFieldView = {
        let card = CardFieldView()
        card.title.text = "Cashback limit"
        return card
    }()
    private let logoutButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .red
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Logout", for: .normal)
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
        getMerchantProfile()
        logoutButton.addTarget(self, action: #selector(logout), for: .touchUpInside)
    }
    @objc func logout() {
        print("tapped")
        let rf = RequestFunction()
        rf.postLogout { result in
            switch(result) {
            case.success(let data):
                guard let data = data else {return}
                print("Berhasil",data)
            case.failure(let error):
                print(error)
            }
        }
    }
    private func getMerchantProfile() {
        let rf = RequestFunction()
        KeychainHelper.standard.delete(key: .accessToken)
        try! KeychainHelper.standard.save(key: .accessToken, value: "87|9FvXdz7yQTeyJ2sk5IDxgi3FiqrtBCyeF33Kj8bU")
        rf.getUserInfo { result in
            switch(result) {
            case .success(let data):
                self.initData(user: data)
            case.failure(let error):
                print(error)
            }
        }
    }
    private func initData(user: UserInfoResponse) {
        print(user)
        let imageURL = user.profilePicture
        guard let url = URL(string: imageURL) else {return}
        downloadImage(url: url)
        let cashbackPercent = user.merchantDetail?.cashbackPercent
        let dailyTokenLimit = user.merchantDetail?.dailyTokenLimit
        let cashbackLimit = user.merchantDetail?.cashbackLimit
        profileName.text = user.name
        profileUsernameIg.text = user.instagramUsername
        emailCardField.value.text = user.email
        percentCashbackCardField.value.text = cashbackPercent != nil ? "\(String(describing: cashbackPercent))" : "0"
        tokenLimitMethodCardField.value.text = dailyTokenLimit != nil ? "\(String(describing: dailyTokenLimit))" : "No maximum tokens limit"
        cashbackLimitMethodCardField.value.text = cashbackLimit != nil ? "\(String(describing: cashbackLimit))" : "No maximum cashback limit"
    }
    private func downloadImage(url: URL) {
        let configuration = URLSessionConfiguration.ephemeral
        let session = URLSession(configuration: configuration)
        if let response = configuration.urlCache?.cachedResponse(for: URLRequest(url: url)) {
          profileImage.image = UIImage(data: response.data)
            print("Image cache", response.data)
        } else {
            let downloadTask = session.dataTask(with: url) { [weak self] data, _, _ in
            guard let self = self, let data = data else { return }
            DispatchQueue.main.async {
              self.profileImage.image = UIImage(data: data)
            }
                print("Image baru", UIImage(data: data))
          }
          downloadTask.resume()
        }
      }
}

extension MerchantProfileViewController {
    private func setupLayout() {
        setupScrollView()
        setupProfileImage()
        setupProfileName()
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
        contentView.addSubview(profileImage)
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        profileImage.setWidthAnchorConstraint(equalToConstant: 100)
        profileImage.setHeightAnchorConstraint(equalToConstant: 100)
        profileImage.setTopAnchorConstraint(equalTo: contentView.topAnchor)
        profileImage.setCenterXAnchorConstraint(equalTo: contentView.centerXAnchor)
    }
    private func setupProfileName() {
        contentView.addSubview(profileName)
        profileName.translatesAutoresizingMaskIntoConstraints = false
        profileName.setTopAnchorConstraint(equalTo: profileImage.bottomAnchor, constant: 10)
        profileName.setTrailingAnchorConstraint(equalTo: contentView.trailingAnchor, constant: -10)
        profileName.setLeadingAnchorConstraint(equalTo: contentView.leadingAnchor, constant: 10)
    }
    private func setupProfileUsernameIG() {
        contentView.addSubview(profileUsernameIg)
        profileUsernameIg.translatesAutoresizingMaskIntoConstraints = false
        profileUsernameIg.setTopAnchorConstraint(equalTo: profileName.bottomAnchor, constant: 10)
        profileUsernameIg.setTrailingAnchorConstraint(equalTo: contentView.trailingAnchor, constant: -10)
        profileUsernameIg.setLeadingAnchorConstraint(equalTo: contentView.leadingAnchor, constant: 10)
    }
    private func setupCardField() {
        let stackView = UIStackView(arrangedSubviews: [emailCardField, percentCashbackCardField, cashbackMethodCardField, tokenLimitMethodCardField, cashbackLimitMethodCardField])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stackView)
        stackView.setTopAnchorConstraint(equalTo: profileUsernameIg.bottomAnchor, constant: 20)
        stackView.setLeftAnchorConstraint(equalTo: contentView.leftAnchor, constant: 20)
        stackView.setRightAnchorConstraint(equalTo: contentView.rightAnchor, constant: -20)
        stackView.heightAnchor.constraint(equalToConstant: 450).isActive = true
    }
    private func setupButton() {
        contentView.addSubview(logoutButton)
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.setTopAnchorConstraint(equalTo: cashbackLimitMethodCardField.bottomAnchor, constant: 20)
        logoutButton.setLeftAnchorConstraint(equalTo: contentView.leftAnchor, constant: 20)
        logoutButton.setRightAnchorConstraint(equalTo: contentView.rightAnchor, constant: -20)
        logoutButton.setBottomAnchorConstraint(equalTo: contentView.bottomAnchor, constant: -20)
    }
}
