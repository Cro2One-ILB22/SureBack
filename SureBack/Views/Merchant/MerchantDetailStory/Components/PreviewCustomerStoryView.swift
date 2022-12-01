//
//  ItemCustomerStoryCollectionCell.swift
//  SureBack
//
//  Created by Tubagus Adhitya Permana on 18/11/22.
//

import UIKit

class PreviewCustomerStoryView: UIView {
    var isFromHistory = false
    static let id = "ItemCustomerStoryCollectionCell"
    let loadingIndicatorStory: UIActivityIndicatorView = {
        let loading = UIActivityIndicatorView()
        loading.style = .gray
        loading.translatesAutoresizingMaskIntoConstraints = false
        loading.isHidden = true
        return loading
    }()
    let userImageStory: UIImageView = {
       let image = UIImageView()
        image.layer.cornerRadius = 20
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
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
    let statusStoryLabel: UILabel = {
       let label = UILabel()
        label.text = "Rejected"
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.textColor = .osloGray
        return label
    }()
    let statusInfoImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "info.circle.fill")
        image.isUserInteractionEnabled = true
        return image
    }()
    func setupConstraint() {
        addSubview(userImageStory)
        userImageStory.translatesAutoresizingMaskIntoConstraints = false
        userImageStory.setTopAnchorConstraint(equalTo: topAnchor, constant: 10)
        userImageStory.setLeadingAnchorConstraint(equalTo: leadingAnchor, constant: 20)
        userImageStory.setTrailingAnchorConstraint(equalTo: trailingAnchor, constant: -20)
        userImageStory.setHeightAnchorConstraint(equalToConstant: 470)
        userImageStory.addSubview(loadingIndicatorStory)
        loadingIndicatorStory.setCenterXAnchorConstraint(equalTo: userImageStory.centerXAnchor)
        loadingIndicatorStory.setCenterYAnchorConstraint(equalTo: userImageStory.centerYAnchor)
        
        addSubview(cashbackTitleLabel)
        cashbackTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        cashbackTitleLabel.setTopAnchorConstraint(equalTo: userImageStory.bottomAnchor, constant: 20)
        cashbackTitleLabel.setLeadingAnchorConstraint(equalTo: leadingAnchor, constant: 20)
        
        addSubview(cashbackLabel)
        cashbackLabel.translatesAutoresizingMaskIntoConstraints = false
        cashbackLabel.setTopAnchorConstraint(equalTo: userImageStory.bottomAnchor, constant: 13)
        cashbackLabel.setLeadingAnchorConstraint(equalTo: cashbackTitleLabel.trailingAnchor, constant: 5)
        if isFromHistory {
            setupStatusStory()
        } else {
            setupRejectedButton()
        }
    }
    private func setupStatusStory() {
        let stackViewButton = UIStackView(arrangedSubviews: [statusStoryLabel, statusInfoImage])
        stackViewButton.axis = .horizontal
        stackViewButton.distribution = .equalSpacing
        stackViewButton.spacing = 10
        stackViewButton.translatesAutoresizingMaskIntoConstraints = false
        stackViewButton.alignment = .center
        addSubview(stackViewButton)
        stackViewButton.setTopAnchorConstraint(equalTo: cashbackLabel.bottomAnchor, constant: 10)
        stackViewButton.setCenterXAnchorConstraint(equalTo: centerXAnchor)
        stackViewButton.setBottomAnchorConstraint(equalTo: bottomAnchor, constant: -20)
    }
    private func setupRejectedButton() {
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
