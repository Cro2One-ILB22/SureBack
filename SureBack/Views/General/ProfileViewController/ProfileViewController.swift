//
//  ProfileViewController.swift
//  SureBack
//
//  Created by Tubagus Adhitya Permana on 30/11/22.
//

import RxSwift
import SDWebImage
import UIKit

class ProfileViewController: UIViewController {
    let request = RequestFunction()
    var isMerchantProfile: Bool = false

//    var userSubject: PublishSubject<UserInfoResponse>

//    var user: UserInfoResponse?
//    {
//        didSet {
//            configure()
//        }
//    }

    let viewModel = UserViewModel.shared

    var disposeBag = DisposeBag()

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
        return label
    }()

    let profileEmail: UILabel = {
        let label = UILabel()
        label.text = "email"
        return label
    }()

    let profileUsernameIg: UILabel = {
        let label = UILabel()
        label.text = "@usernameIG"
        return label
    }()

    let manageProfileButton: UIButton = {
        let button = UIButton()
        button.setTitle("Manage Profile", for: .normal)
        button.setTitleColor(UIColor.tealishGreen, for: .normal)
        button.backgroundColor = .clear
        return button
    }()

    let moreSettingsLabel: UILabel = {
        let label = UILabel()
        label.text = "More Settings"
        label.font = UIFont.boldSystemFont(ofSize: 17)
        return label
    }()

    let accountSafetyCard: SettingCardView = {
        let card = SettingCardView()
        card.titleImage.image = UIImage(named: "account.safety")
        card.title.text = "Account Safety"
        card.backgroundColor = .lightGray.lighter(by: 10)
        return card
    }()

    let appGuideCard: SettingCardView = {
        let card = SettingCardView()
        card.titleImage.image = UIImage(named: "app.guide")
        card.title.text = "App Guide"
        card.backgroundColor = .lightGray.lighter(by: 10)
        return card
    }()

    let businessSettingsCard: SettingCardView = {
        let card = SettingCardView()
        card.titleImage.image = UIImage(named: "business.settings")
        card.title.text = "Business Settings"
        return card
    }()

    lazy var logoutButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.setTitleColor(UIColor.tealishGreen, for: .normal)
        button.setTitle("Logout", for: .normal)
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(logout), for: .touchUpInside)
        return button
    }()

    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .porcelain

        viewModel.userSubject.subscribe(onNext: { _ in
            self.configure()
        }).disposed(by: disposeBag)

        setupLayout()
        configure()
    }

    func configure() {
        guard let user = viewModel.user else { return }
        profileImage.sd_imageIndicator = SDWebImageActivityIndicator.gray
        profileImage.sd_setImage(
            with: URL(string: user.profilePicture ?? defaultImage),
            placeholderImage: UIImage(named: "system.photo"),
            options: .progressiveLoad,
            completed: nil
        )
        profileName.text = user.name
        profileEmail.text = user.email
        profileUsernameIg.text = "@\(user.instagramUsername)"

        manageProfileButton.setImage(UIImage(named: "Appicon"), for: .normal)

        accountSafetyCard.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(accountSafetyTapped)))
        appGuideCard.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(appGuideTapped)))
        manageProfileButton.addTarget(self, action: #selector(editProfile), for: .touchUpInside)
    }

    @objc func accountSafetyTapped(sender: UITapGestureRecognizer) {
        print("account safety tapped")
    }

    @objc func appGuideTapped(sender: UITapGestureRecognizer) {
        print("app guide tapped")
    }

    @objc func editProfile() {
        print("Edit Profile tapped")
        let editProfileVC = CustomerEditProfileViewController()
        editProfileVC.title = "Profile Details"
        navigationController?.pushViewController(editProfileVC, animated: true)
    }

    @objc func logout() {
        print("Logout tapped")
        request.postLogout { data in
            switch data {
            case let .success:
                print("logout success")
                let appDelegate = UIApplication.shared.delegate as? AppDelegate
                appDelegate?.window?.rootViewController = UINavigationController(rootViewController: IsLoginViewController())
            case .failure:
                break
            }
        }
    }
}

extension ProfileViewController {
    private func setupLayout() {
        let stackProfileData = UIStackView(arrangedSubviews: [profileName, profileUsernameIg, profileEmail])
        stackProfileData.axis = .vertical
        stackProfileData.distribution = .fill
        stackProfileData.translatesAutoresizingMaskIntoConstraints = false

        let stackProfileImage = UIStackView(arrangedSubviews: [profileImage, stackProfileData])
        stackProfileImage.axis = .horizontal
        stackProfileImage.distribution = .equalSpacing
        stackProfileImage.spacing = 10
        stackProfileImage.translatesAutoresizingMaskIntoConstraints = false

        profileImage.setHeightAnchorConstraint(equalToConstant: 80)
        profileImage.setWidthAnchorConstraint(equalToConstant: 80)

        view.addSubview(stackProfileImage)
        stackProfileImage.setTopAnchorConstraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)
        stackProfileImage.setLeadingAnchorConstraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20)

        view.addSubview(manageProfileButton)
        manageProfileButton.translatesAutoresizingMaskIntoConstraints = false
        manageProfileButton.setTopAnchorConstraint(equalTo: stackProfileImage.bottomAnchor, constant: 20)
        manageProfileButton.setLeadingAnchorConstraint(equalTo: view.leadingAnchor, constant: 20)

        view.addSubview(moreSettingsLabel)
        moreSettingsLabel.translatesAutoresizingMaskIntoConstraints = false
        moreSettingsLabel.setTopAnchorConstraint(equalTo: manageProfileButton.bottomAnchor, constant: 40)
        moreSettingsLabel.setLeadingAnchorConstraint(equalTo: view.leadingAnchor, constant: 20)

        view.addSubview(accountSafetyCard)
        accountSafetyCard.translatesAutoresizingMaskIntoConstraints = false
        accountSafetyCard.setTopAnchorConstraint(equalTo: moreSettingsLabel.bottomAnchor, constant: 20)
        accountSafetyCard.setTrailingAnchorConstraint(equalTo: view.trailingAnchor, constant: -20)
        accountSafetyCard.setLeadingAnchorConstraint(equalTo: view.leadingAnchor, constant: 20)

        if isMerchantProfile {
            view.addSubview(businessSettingsCard)
            businessSettingsCard.translatesAutoresizingMaskIntoConstraints = false
            businessSettingsCard.setTopAnchorConstraint(equalTo: accountSafetyCard.bottomAnchor, constant: 4)
            businessSettingsCard.setLeadingAnchorConstraint(equalTo: view.leadingAnchor, constant: 20)
            businessSettingsCard.setTrailingAnchorConstraint(equalTo: view.trailingAnchor, constant: -20)
        }

        view.addSubview(appGuideCard)
        appGuideCard.translatesAutoresizingMaskIntoConstraints = false
        appGuideCard.setTopAnchorConstraint(equalTo: isMerchantProfile ? businessSettingsCard.bottomAnchor : accountSafetyCard.bottomAnchor, constant: 4)
        appGuideCard.setTrailingAnchorConstraint(equalTo: view.trailingAnchor, constant: -20)
        appGuideCard.setLeadingAnchorConstraint(equalTo: view.leadingAnchor, constant: 20)

        view.addSubview(logoutButton)
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.setTopAnchorConstraint(equalTo: appGuideCard.bottomAnchor, constant: 40)
        logoutButton.setLeftAnchorConstraint(equalTo: view.leftAnchor, constant: 20)
        logoutButton.setRightAnchorConstraint(equalTo: view.rightAnchor, constant: -20)
    }
}
