//
//  HeaderCustomerHistoryView.swift
//  SureBack
//
//  Created by Ditha Nurcahya Avianty on 13/11/22.
//

import UIKit

class HeaderCustomerHistoryView: UIView {

    let image: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "bg.card.history")?.withRenderingMode(.alwaysOriginal)
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.setHeightAnchorConstraint(equalToConstant: 220)
        imageView.setWidthAnchorConstraint(equalToConstant: UIScreen.screenWidth - 20)
        return imageView
    }()

    lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.text = "User Name"
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var merchantLabel: UILabel = {
        let label = UILabel()
        label.text = "Merchant Name"
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var openLinkButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "chevron.right"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setWidthAnchorConstraint(equalToConstant: 12)
        button.setHeightAnchorConstraint(equalToConstant: 22)
        return button
    }()

    lazy var profileImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 10
        image.image = UIImage(named: "AppIcon")
        image.clipsToBounds = true
        image.setWidthAnchorConstraint(equalToConstant: 50)
        image.setHeightAnchorConstraint(equalToConstant: 50)
        return image
    }()

    lazy var bgProfileImageView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.tealishGreen
        view.layer.cornerRadius = 10
        return view
    }()

    lazy var coinImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "loyalty.coin")
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 13
        image.setWidthAnchorConstraint(equalToConstant: 20)
        image.setHeightAnchorConstraint(equalToConstant: 20)
        return image
    }()

    lazy var loyaltCoinsValueLabel: UILabel = {
        let label = UILabel()
        label.text = "50"
        label.font = UIFont.systemFont(ofSize: 34)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var loyaltCoinsLabel: UILabel = {
        let label = UILabel()
        label.text = "Coin(s)"
        label.font = UIFont.systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var lockImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 15
        image.clipsToBounds = true
        image.image = UIImage(named: "lock.status.unavailable")
        image.setWidthAnchorConstraint(equalToConstant: 30)
        image.setHeightAnchorConstraint(equalToConstant: 30)
        return image
    }()

    lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.text = "Cooldown"
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 0
//        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var descStatusButton: UIButton = {
        let button = UIButton()
        button.setTitle("i", for: .normal)
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setWidthAnchorConstraint(equalToConstant: 15)
        button.setHeightAnchorConstraint(equalToConstant: 15)
        return button
    }()

    lazy var redeemButtonView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "coupon.redeem")
        image.setWidthAnchorConstraint(equalToConstant: 120)
        image.setHeightAnchorConstraint(equalToConstant: 55)
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    lazy var timerLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00:00"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    var stackRedeemButton = UIStackView()

    lazy var redeemLabel: UILabel = {
        let label = UILabel()
        label.text = "Redeem"
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var redeemButton: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "arrow.right.circle.green")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.setWidthAnchorConstraint(equalToConstant: 20)
        image.setHeightAnchorConstraint(equalToConstant: 20)
        return image
    }()

    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.screenWidth, height: 220))
        setupHeaderView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
