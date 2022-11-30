//
//  CustomerListAllMerchantViewController+SetupUI.swift
//  SureBack
//
//  Created by Ditha Nurcahya Avianty on 30/11/22.
//

import UIKit

extension CustomerListAllMerchantViewController {
    func setupLayout() {
        setupLoadingIndicator()
        setupSearch()
        setupView()
    }

    private func setupLoadingIndicator() {
        view.addSubview(loadingIndicator)
        loadingIndicator.setCenterXAnchorConstraint(equalTo: view.centerXAnchor)
        loadingIndicator.setCenterYAnchorConstraint(equalTo: view.centerYAnchor)
    }

    private func setupView() {
        setupTableView()
        tableView.delegate = self
        tableView.dataSource = self
    }

    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.setTopAnchorConstraint(equalTo: searchBar.bottomAnchor)
        tableView.setLeadingAnchorConstraint(equalTo: view.leadingAnchor, constant: 15)
        tableView.setTrailingAnchorConstraint(equalTo: view.trailingAnchor, constant: -15)
        tableView.setBottomAnchorConstraint(equalTo: view.bottomAnchor)
    }

    private func setupSearch() {
        view.addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.setTopAnchorConstraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10)
        searchBar.setLeadingAnchorConstraint(equalTo: view.leadingAnchor, constant: 15)
        searchBar.setTrailingAnchorConstraint(equalTo: view.trailingAnchor, constant: -15)
    }
}
