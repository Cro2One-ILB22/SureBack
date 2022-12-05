//
//  MerchantRejectStoryFormViewController+SetupUI.swift
//  SureBack
//
//  Created by Tubagus Adhitya Permana on 28/11/22.
//

import UIKit

extension MerchantRejectStoryFormViewController {
    func setupLayout() {
        setupQuestion1Label()
        setupSuggestMessageAndQuestionLabel2()
        setupMessageField()
        setupSendToCustButton()
    }
    private func setupQuestion1Label() {
        view.addSubview(question1TextLabel)
        question1TextLabel.setTopAnchorConstraint(equalTo: titleLabel.bottomAnchor, constant: 16)
        question1TextLabel.setLeadingAnchorConstraint(equalTo: view.leadingAnchor, constant: 16)
        question1TextLabel.setTrailingAnchorConstraint(equalTo: view.trailingAnchor, constant: -16)
    }
    private func setupSuggestMessageAndQuestionLabel2() {
        let suggestMessageVStackView = UIStackView(arrangedSubviews: [suggestMessage1, suggestMessage2, suggestMessage3, suggestMessage4, suggestMessage5])
        suggestMessageVStackView.axis = .vertical
        suggestMessageVStackView.distribution = .equalSpacing
        suggestMessageVStackView.alignment = .leading
        suggestMessageVStackView.spacing = 8
        suggestMessageVStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(suggestMessageVStackView)
        suggestMessageVStackView.setTopAnchorConstraint(equalTo: question1TextLabel.bottomAnchor, constant: 16)
        suggestMessageVStackView.setLeadingAnchorConstraint(equalTo: view.leadingAnchor, constant: 16)
        suggestMessageVStackView.setTrailingAnchorConstraint(equalTo: view.trailingAnchor, constant: -16)
        
        view.addSubview(question2TextLabel)
        question2TextLabel.setTopAnchorConstraint(equalTo: suggestMessageVStackView.bottomAnchor, constant: 16)
        question2TextLabel.setLeadingAnchorConstraint(equalTo: view.leadingAnchor, constant: 16)
        question2TextLabel.setTrailingAnchorConstraint(equalTo: view.trailingAnchor, constant: -16)
    }
    private func setupMessageField() {
        view.addSubview(messageField)
        messageField.translatesAutoresizingMaskIntoConstraints = false
        messageField.setTopAnchorConstraint(equalTo: question2TextLabel.bottomAnchor, constant: 16)
        messageField.setLeadingAnchorConstraint(equalTo: view.leadingAnchor, constant: 16)
        messageField.setTrailingAnchorConstraint(equalTo: view.trailingAnchor, constant: -16)
    }
    private func setupSendToCustButton() {
        view.addSubview(sendToCustButton)
        sendToCustButton.translatesAutoresizingMaskIntoConstraints = false
        sendToCustButton.setBottomAnchorConstraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        sendToCustButton.setLeadingAnchorConstraint(equalTo: view.leadingAnchor, constant: 16)
        sendToCustButton.setTrailingAnchorConstraint(equalTo: view.trailingAnchor, constant: -16)
    }
}
