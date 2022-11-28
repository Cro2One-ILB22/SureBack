//
//  ItemNotifTableViewCell.swift
//  SureBack
//
//  Created by Ditha Nurcahya Avianty on 27/11/22.
//

import UIKit

class ItemNotifTableViewCell: UITableViewCell {
    static let id = "ItemNotifTableViewCell"

    lazy var statusImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.setWidthAnchorConstraint(equalToConstant: 18)
        image.setHeightAnchorConstraint(equalToConstant: 18)
        image.image = UIImage(named: "notif.status.one")
        return image
    }()

    lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.text = "Token Issued"
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()

    lazy var firstDetailLabel: UILabel = {
        let label = UILabel()
        label.text = "Post Story & Redeem - Today 11:22"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .systemGray
        return label
    }()

    lazy var secondDetailLabel: UILabel = {
        let label = UILabel()
        label.text = "Total Purchase: Rp100,000"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .systemGray
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

    func configure(_ data: StatusTokenHistory, index: Int, allData: CustomerNotificationsData) {
        switch index {
        case 0:
            statusImage.image = UIImage(named: "notif.status.one")
        case 1:
            statusImage.image = UIImage(named: "notif.status.two")
        case 2:
            statusImage.image = UIImage(named: "notif.status.three")
        default:
            break
        }

        guard let timestamp = data.timestamp else { return }

        switch data.status {
        case .expired:
            statusLabel.text = "Token Expired"
            firstDetailLabel.text = timestamp.formatTodMMMyyy()
            secondDetailLabel.text = "Token were not redeemed"
        case .issued:
            break
        case .submitted:
            statusLabel.text = "Token Redeemed"
            firstDetailLabel.text = "Wait for Approval - \(timestamp.formatTodMMMyyy())"
            secondDetailLabel.text = "24 Hours of Waiting Period"
        case .approved:
            statusLabel.text = "Story Approved"
            firstDetailLabel.text = timestamp.formatTodMMMyyyStory()
            secondDetailLabel.text = "\(allData.tokenHistoryData.tokenCashback.amount) coins credited to your balance"
        case .rejected:
            statusLabel.text = "Story Rejected"
            firstDetailLabel.text = data.timestamp?.formatTodMMMyyyStory()
            secondDetailLabel.text = "Reason: \(allData.tokenHistoryData.rejectedReason ?? "-")"
        case .redeemed:
            statusLabel.text = "Token Issued"
            firstDetailLabel.text = "Post Story & Redeem - \(timestamp.formatTodMMMyyy())"
            secondDetailLabel.text = "Total Purchase: Rp\(String(allData.tokenHistoryData.purchase?.purchaseAmount ?? 0))"
        default:
            break
        }
    }

    private func setupLayout() {
        let stackDetail = UIStackView(arrangedSubviews: [statusLabel, firstDetailLabel, secondDetailLabel])
        stackDetail.axis = .vertical
        stackDetail.distribution = .equalSpacing
        stackDetail.spacing = 5

        let stackView = UIStackView(arrangedSubviews: [statusImage, stackDetail])
        stackView.axis = .horizontal
        stackView.alignment = .top
        stackView.spacing = 10

        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.setTopAnchorConstraint(equalTo: topAnchor, constant: 10)
        stackView.setLeadingAnchorConstraint(equalTo: leadingAnchor, constant: 20)
    }
}
