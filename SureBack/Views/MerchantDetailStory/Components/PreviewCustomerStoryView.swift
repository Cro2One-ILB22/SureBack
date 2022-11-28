//
//  ItemCustomerStoryCollectionCell.swift
//  SureBack
//
//  Created by Tubagus Adhitya Permana on 18/11/22.
//

import UIKit

class PreviewCustomerStoryView: UIView {
    static let id = "ItemCustomerStoryCollectionCell"
    let userImageStory: UIImageView = {
       let image = UIImageView()
        image.image = UIImage(named: "AppIcon")
        image.layer.cornerRadius = 30
        image.contentMode = .scaleToFill
        return image
    }()
    let cashbackTitleLabel: UILabel = {
       let label = UILabel()
        label.text = "Cashback"
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    let cashbackLabel: UILabel = {
       let label = UILabel()
        label.text = "30.000"
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    let rejectButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.red, for: .normal)
        button.setTitle("Reject", for: .normal)
        button.heightAnchor.constraint(equalToConstant: 32).isActive = true
        button.layer.cornerRadius = 10
        return button
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraint()
        layer.cornerRadius = 8
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupConstraint() {
        
        addSubview(userImageStory)
        userImageStory.translatesAutoresizingMaskIntoConstraints = false
        userImageStory.setTopAnchorConstraint(equalTo: topAnchor, constant: 10)
        userImageStory.setLeadingAnchorConstraint(equalTo: leadingAnchor, constant: 20)
        userImageStory.setTrailingAnchorConstraint(equalTo: trailingAnchor, constant: -20)
        userImageStory.setHeightAnchorConstraint(equalToConstant: 470)
        
        addSubview(cashbackTitleLabel)
        cashbackTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        cashbackTitleLabel.setTopAnchorConstraint(equalTo: userImageStory.bottomAnchor, constant: 20)
        cashbackTitleLabel.setLeadingAnchorConstraint(equalTo: leadingAnchor, constant: 20)
        
        addSubview(cashbackLabel)
        cashbackLabel.translatesAutoresizingMaskIntoConstraints = false
        cashbackLabel.setTopAnchorConstraint(equalTo: userImageStory.bottomAnchor, constant: 13)
        cashbackLabel.setLeadingAnchorConstraint(equalTo: cashbackTitleLabel.trailingAnchor, constant: 5)
        
        let stackViewButton = UIStackView(arrangedSubviews: [UIView(), rejectButton])
        stackViewButton.axis = .horizontal
        stackViewButton.distribution = .equalSpacing
        stackViewButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackViewButton)
        stackViewButton.setTopAnchorConstraint(equalTo: cashbackLabel.bottomAnchor, constant: 10)
        stackViewButton.setTrailingAnchorConstraint(equalTo: trailingAnchor, constant: -20)
        stackViewButton.setLeadingAnchorConstraint(equalTo: leadingAnchor, constant: 20)
        stackViewButton.setBottomAnchorConstraint(equalTo: bottomAnchor, constant: -20)
    }
}
