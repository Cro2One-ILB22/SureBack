//
//  WaitingView+SetupUI.swift
//  SureBack
//
//  Created by Tubagus Adhitya Permana on 22/11/22.
//

import UIKit

extension WaitingViewController {
    func setupLayout() {
        setupLoadingIndicator()
        setupSearch()
        setupTableView()
    }
    private func setupLoadingIndicator() {
        view.addSubview(loadingIndicator)
        loadingIndicator.setCenterXAnchorConstraint(equalTo: view.centerXAnchor)
        loadingIndicator.setCenterYAnchorConstraint(equalTo: view.centerYAnchor)
    }
    private func setupSearch() {
        view.addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.setTopAnchorConstraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10)
        searchBar.setLeadingAnchorConstraint(equalTo: view.leadingAnchor, constant: 16)
        searchBar.setTrailingAnchorConstraint(equalTo: view.trailingAnchor, constant: -16)
    }
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.setTopAnchorConstraint(equalTo: searchBar.bottomAnchor)
        tableView.setLeadingAnchorConstraint(equalTo: view.leadingAnchor, constant: 16)
        tableView.setTrailingAnchorConstraint(equalTo: view.trailingAnchor, constant: -16)
        tableView.setBottomAnchorConstraint(equalTo: view.bottomAnchor)
    }
}
