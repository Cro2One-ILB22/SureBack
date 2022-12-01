//
//  ItemActiveTokenCollectionViewCell.swift
//  SureBack
//
//  Created by Ditha Nurcahya Avianty on 12/11/22.
//

import UIKit

class ItemActiveTokenCollectionViewCell: UICollectionViewCell {

    static let id = "ItemActiveTokenCollectionViewCell"

//    let bgImage: UIImageView = {
//        let image = UIImageView()
//        image.image = UIImage(named: "coupon.redeem")
//        return image
//    }()

    let expireLabel: UILabel = {
        let label = UILabel()
        label.text = "Expires in"
        label.font = UIFont.systemFont(ofSize: 15)
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    var tokenMerchantNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Merchant Name"
        label.font = UIFont.systemFont(ofSize: 15)
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    var timerLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00:00"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    var redeemButton: UIButton = {
        let button = UIButton()
        button.setTitle("Redeem", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .tealishGreen
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    lazy var expireAt: Date = {
        return Date()
    }()

    var countdown: DateComponents {
        return Calendar.current.dateComponents([.day, .hour, .minute, .second], from: Date(), to: self.expireAt)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 30
        setupView()
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Timer
    @objc func updateTimer() {
        let countdown = self.countdown
        let hours = countdown.hour!
        let minutes = countdown.minute!
        let seconds = countdown.second!

        self.timerLabel.text = String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
}

extension ItemActiveTokenCollectionViewCell {
    private func setupView() {
        backgroundColor = .lightGray
        layer.cornerRadius = 30
        setWidthAnchorConstraint(equalToConstant: UIScreen.screenWidth)
        setHeightAnchorConstraint(equalToConstant: 100)
        translatesAutoresizingMaskIntoConstraints = false
        setupStackLabel()
        setupButton()
    }

    private func setupStackLabel() {
        let stackView = UIStackView(arrangedSubviews: [expireLabel, tokenMerchantNameLabel, timerLabel])
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        stackView.setTopAnchorConstraint(equalTo: topAnchor, constant: 20)
        stackView.setLeadingAnchorConstraint(equalTo: leadingAnchor, constant: 20)
        stackView.setTrailingAnchorConstraint(equalTo: trailingAnchor, constant: -20)
    }

    private func setupButton() {
        addSubview(redeemButton)
        redeemButton.setCenterYAnchorConstraint(equalTo: centerYAnchor)
        redeemButton.setTrailingAnchorConstraint(equalTo: trailingAnchor, constant: -20)
    }
}
