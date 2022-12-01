//
//  SectionNotifHeader.swift
//  SureBack
//
//  Created by Ditha Nurcahya Avianty on 27/11/22.
//

import UIKit

class SectionNotifHeader: UITableViewHeaderFooterView {
    lazy var statusImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 15
        image.setWidthAnchorConstraint(equalToConstant: 30)
        image.setHeightAnchorConstraint(equalToConstant: 30)
        image.image = UIImage(named: "multiply.circle.fill.red")
        return image
    }()

    lazy var merchantLabel: UILabel = {
        let label = UILabel()
        label.text = "Merchant"
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "Sunday, 30 October 2022"
        label.textColor = .systemGray
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let expandButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "chevron.right"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setHeightAnchorConstraint(equalToConstant: 12)
        button.setWidthAnchorConstraint(equalToConstant: 12)
        return button
    }()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        backgroundColor = .lightGray
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(_ data: CustomerNotificationsData) {
        let isHidden = data.isHidden
        if isHidden {
            expandButton.setImage(UIImage(named: "chevron.right"), for: .normal)
//            expandButton.setWidthAnchorConstraint(equalToConstant: 12)
        } else {
            expandButton.setImage(UIImage(named: "chevron.down"), for: .normal)
//            expandButton.setWidthAnchorConstraint(equalToConstant: 25)
        }

        let statusHistory = data.tokenHistoryData.statusHistory
        let status = data.tokenHistoryData.currentStatus?.rawValue

        if status == "rejected" || status == "expired" {
            statusImage.image = UIImage(named: "multiply.circle.fill.red.tintBlack")
        } else if status == "approved" {
            statusImage.image = UIImage(named: "checkmark.circle.fill.green")
        } else if status == "submitted" || status == "redeemed" {
            statusImage.image = UIImage(named: "hourglass.circle.fill.gray")
        }

        if status == "approved" || status == "rejected" {
            dateLabel.text = statusHistory.last?.timestamp?.formatTodMMMyyy()
        } else {
            dateLabel.text = statusHistory.last?.timestamp?.formatTodMMMyyy()
        }
        merchantLabel.text = "\(data.tokenHistoryData.purchase?.merchant?.name ?? "")"
    }

    private func setupLayout() {
        let stackLabel = UIStackView(arrangedSubviews: [merchantLabel, dateLabel])
        stackLabel.axis = .vertical
        stackLabel.distribution = .equalSpacing
        stackLabel.translatesAutoresizingMaskIntoConstraints = false

        let stackView = UIStackView(arrangedSubviews: [statusImage, stackLabel, expandButton])
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        stackView.setCenterYAnchorConstraint(equalTo: centerYAnchor)
//        stackView.setTopAnchorConstraint(equalTo: topAnchor, constant: 10)
        stackView.setLeadingAnchorConstraint(equalTo: leadingAnchor, constant: 20)
        stackView.setTrailingAnchorConstraint(equalTo: trailingAnchor, constant: -20)
//        stackView.setBottomAnchorConstraint(equalTo: bottomAnchor, constant: -10)
    }
}
