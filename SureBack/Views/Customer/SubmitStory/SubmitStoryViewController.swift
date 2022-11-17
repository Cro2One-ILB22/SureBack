//
//  SubmitStoryViewController.swift
//  SureBack
//
//  Created by Ditha Nurcahya Avianty on 15/11/22.
//

import UIKit

class SubmitStoryViewController: UIViewController {
    var tokenData: GenerateTokenOnlineResponse?

    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(SubmitStoryTableViewCell.self, forCellReuseIdentifier: SubmitStoryTableViewCell.id)
        table.backgroundColor = .white
        table.separatorColor = UIColor.clear
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        guard let tokenData = tokenData, let storyID = tokenData.story?.id else {
            return
        }

        let headerView = HeaderSubmitStoryView(frame: CGRect(x: 0, y: 0, width: UIScreen.screenWidth, height: 180))
        headerView.tokenIdLabel.text = String(tokenData.id)
        headerView.merchantNameLabel.text = tokenData.merchant.name

        // string to date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = dateFormatter.date(from: tokenData.createdAt)
        dateFormatter.dateFormat = "dd MMM yyyy"
        let dateString = dateFormatter.string(from: date!)

        // date to string
        let dateToString = DateFormatter()
        dateToString.dateFormat = "dd/MM/YY"

        headerView.dateNameLabel.text = dateString
        headerView.purchaseNameLabel.text = String(tokenData.purchase.purchaseAmount)
        print("Story ID: \(storyID)")
        setupTableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableHeaderView = headerView
    }
}

extension SubmitStoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SubmitStoryTableViewCell.id, for: indexPath) as? SubmitStoryTableViewCell else { return UITableViewCell() }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
}

extension SubmitStoryViewController {
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.setTopAnchorConstraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        tableView.setLeadingAnchorConstraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
        tableView.setTrailingAnchorConstraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        tableView.setBottomAnchorConstraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    }
}
