//
//  ItemCustomerStoryCollectionCell.swift
//  SureBack
//
//  Created by Tubagus Adhitya Permana on 18/11/22.
//

import UIKit

class ItemCustomerStoryCollectionCell: UICollectionViewCell {
    static let id = "ItemCustomerStoryCollectionCell"
    let tokenLabel: UILabel = {
       let label = UILabel()
        label.text = "TOKEN"
        return label
    }()
    let createdAtLabel: UILabel = {
       let label = UILabel()
        label.text = "20 Minutes Ago"
        return label
    }()
    let userImageStory: UIImageView = {
       let image = UIImageView()
        image.image = UIImage(named: "person.crop.circle")
        image.layer.cornerRadius = 30
        return image
    }()
    let totalPurchaseTextLabel: UILabel = {
       let label = UILabel()
        label.text = "Total purchase"
        return label
    }()
    let totalPurchaseLabel: UILabel = {
       let label = UILabel()
        label.text = "Rp.0000"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    let totalRewardTextLabel: UILabel = {
       let label = UILabel()
        label.text = "Total Reward"
        return label
    }()
    let totalRewardLabel: UILabel = {
       let label = UILabel()
        label.text = "Rp.0000"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    let approveButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .blue
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Approve", for: .normal)
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.layer.cornerRadius = 10
        return button
    }()
    let rejectButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .blue
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Reject", for: .normal)
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.layer.cornerRadius = 10
        return button
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraint()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupConstraint() {
        let stackView = UIStackView(arrangedSubviews: [tokenLabel, createdAtLabel])
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        stackView.setTopAnchorConstraint(equalTo: topAnchor, constant: 30)
        stackView.setTrailingAnchorConstraint(equalTo: trailingAnchor, constant: -20)
        stackView.setLeadingAnchorConstraint(equalTo: leadingAnchor, constant: 20)
        
        contentView.addSubview(userImageStory)
        userImageStory.translatesAutoresizingMaskIntoConstraints = false
        userImageStory.setTopAnchorConstraint(equalTo: tokenLabel.bottomAnchor, constant: 10)
        userImageStory.setLeadingAnchorConstraint(equalTo: contentView.leadingAnchor, constant: 10)
        userImageStory.setTrailingAnchorConstraint(equalTo: contentView.trailingAnchor, constant: -10)
        userImageStory.setHeightAnchorConstraint(equalToConstant: 300)
        
        let stackViewPurchase = UIStackView(arrangedSubviews: [totalPurchaseTextLabel, totalPurchaseLabel])
        stackViewPurchase.axis = .horizontal
        stackViewPurchase.distribution = .fillEqually
        stackViewPurchase.spacing = 10
        stackViewPurchase.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackViewPurchase)
        stackViewPurchase.setTopAnchorConstraint(equalTo: userImageStory.bottomAnchor, constant: 30)
        stackViewPurchase.setTrailingAnchorConstraint(equalTo: trailingAnchor, constant: -20)
        stackViewPurchase.setLeadingAnchorConstraint(equalTo: leadingAnchor, constant: 20)
        
        let stackViewReward = UIStackView(arrangedSubviews: [totalRewardTextLabel, totalRewardLabel])
        stackViewReward.axis = .horizontal
        stackViewReward.distribution = .fillEqually
        stackViewReward.spacing = 10
        stackViewReward.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackViewReward)
        stackViewReward.setTopAnchorConstraint(equalTo: totalPurchaseLabel.bottomAnchor)
        stackViewReward.setTrailingAnchorConstraint(equalTo: trailingAnchor, constant: -20)
        stackViewReward.setLeadingAnchorConstraint(equalTo: leadingAnchor, constant: 20)
        
        let stackViewButton = UIStackView(arrangedSubviews: [rejectButton, approveButton])
        stackViewButton.axis = .horizontal
        stackViewButton.distribution = .fillEqually
        stackViewButton.spacing = 10
        stackViewButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackViewButton)
        stackViewButton.setTopAnchorConstraint(equalTo: totalRewardLabel.bottomAnchor, constant: 20)
        stackViewButton.setTrailingAnchorConstraint(equalTo: trailingAnchor, constant: -20)
        stackViewButton.setLeadingAnchorConstraint(equalTo: leadingAnchor, constant: 20)
        
    }
}
