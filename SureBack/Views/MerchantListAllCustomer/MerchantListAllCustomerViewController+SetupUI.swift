//
//  MerchantListAllCustomerViewController+SetupUI.swift
//  SureBack
//
//  Created by Tubagus Adhitya Permana on 22/11/22.
//

import UIKit

extension MerchantListAllCustomerViewController {
    public func setupLayout() {
        setupCustomSegmentedControl()
        setupWaitingView()
        setupHistoryView()
    }
    private func setupWaitingView() {
        view.addSubview(waitingView)
        waitingView.translatesAutoresizingMaskIntoConstraints = false
        waitingView.setTopAnchorConstraint(equalTo: customSegmentedControl.bottomAnchor)
        waitingView.setLeadingAnchorConstraint(equalTo: view.leadingAnchor)
        waitingView.setTrailingAnchorConstraint(equalTo: view.trailingAnchor)
        waitingView.setBottomAnchorConstraint(equalTo: view.bottomAnchor)
    }
    private func setupHistoryView() {
        view.addSubview(historyView)
        historyView.translatesAutoresizingMaskIntoConstraints = false
        historyView.setTopAnchorConstraint(equalTo: customSegmentedControl.bottomAnchor)
        historyView.setLeadingAnchorConstraint(equalTo: view.leadingAnchor)
        historyView.setTrailingAnchorConstraint(equalTo: view.trailingAnchor)
        historyView.setBottomAnchorConstraint(equalTo: view.bottomAnchor)
    }
    private func setupCustomSegmentedControl() {
        view.addSubview(customSegmentedControl)
        customSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        customSegmentedControl.setTopAnchorConstraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        customSegmentedControl.setLeadingAnchorConstraint(equalTo: view.leadingAnchor)
        customSegmentedControl.setTrailingAnchorConstraint(equalTo: view.trailingAnchor)
        customSegmentedControl.setHeightAnchorConstraint(equalToConstant: 50)
        customSegmentedControl.delegate = self
    }
}
