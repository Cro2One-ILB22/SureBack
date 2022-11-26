//
//  CustomerQRView.swift
//  SureBack
//
//  Created by Ditha Nurcahya Avianty on 24/11/22.
//

import UIKit

class CustomerQRView: UIView {
    let requestInstructionLabel: UILabel = {
        let label = UILabel()
        label.text = "Request SureBack Token"
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "Monday, 10 November 2022"
        label.font = UIFont.systemFont(ofSize: 17)
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "@Barbara"
        label.font = UIFont.systemFont(ofSize: 17)
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var qrImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 8
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    let scanInstructionLabel: UILabel = {
        let label = UILabel()
        label.text = "SCAN THIS CODE TO GET TOKEN"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .lightGray
        label.textAlignment = .center
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CustomerQRView {
    func setupView() {
        setupLabel()
    }

    func setupLabel() {
        let stackLabelView = UIStackView(arrangedSubviews: [requestInstructionLabel, dateLabel, usernameLabel])
        stackLabelView.backgroundColor = .white
        stackLabelView.axis = .vertical
        stackLabelView.spacing = 5
        stackLabelView.isLayoutMarginsRelativeArrangement = true
        stackLabelView.translatesAutoresizingMaskIntoConstraints = false

        let stackQRView = UIStackView(arrangedSubviews: [qrImage, scanInstructionLabel])
        stackQRView.backgroundColor = .white
        stackQRView.axis = .vertical
        stackQRView.spacing = 10
        stackQRView.isLayoutMarginsRelativeArrangement = true
        stackQRView.translatesAutoresizingMaskIntoConstraints = false

        let stackAllView = UIStackView(arrangedSubviews: [stackLabelView, stackQRView])
        stackAllView.backgroundColor = .white
        stackAllView.layer.borderWidth = 1
        stackAllView.layer.borderColor = UIColor.gray.cgColor
        stackAllView.layer.cornerRadius = 10
        stackAllView.axis = .vertical
        stackAllView.spacing = 40
        stackAllView.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        stackAllView.isLayoutMarginsRelativeArrangement = true
        stackAllView.translatesAutoresizingMaskIntoConstraints = false

        addSubview(stackAllView)
        stackAllView.setTrailingAnchorConstraint(equalTo: trailingAnchor, constant: -10)
        stackAllView.setLeadingAnchorConstraint(equalTo: leadingAnchor, constant: 10)

        qrImage.setWidthAnchorConstraint(equalToConstant: UIScreen.main.bounds.width - 70)
        qrImage.setHeightAnchorConstraint(equalToConstant: UIScreen.main.bounds.width - 70)
        qrImage.setCenterXAnchorConstraint(equalTo: centerXAnchor)
    }
}
