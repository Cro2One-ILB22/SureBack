//
//  MerchantDashboardViewController.swift
//  SureBack
//
//  Created by Tubagus Adhitya Permana on 09/11/22.
//

import UIKit

class MerchantDashboardViewController: UIViewController {
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(StoryTableViewCell.self, forCellReuseIdentifier: StoryTableViewCell.id)
        table.backgroundColor = .white
        table.separatorColor = UIColor.clear
        return table
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let headerView = HeaderMerchantDashboardView(frame: CGRect(x: 0, y: 0, width: UIScreen.screenWidth, height: 450))
        setupTableView()
        headerView.businessStatusCard.switchButton.addTarget(self, action: #selector(switchStateDidChange), for: .valueChanged)
        headerView.seeAllCoinHistoryButton.addTarget(self, action: #selector(seeAllCoinHistory), for: .touchUpInside)
        headerView.seeAllCustomersButton.addTarget(self, action: #selector(seeAllCustomers), for: .touchUpInside)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableHeaderView = headerView
    }
    @objc func switchStateDidChange(_ sender: UISwitch!) {
        if sender.isOn {
            print("State is now on")
        } else {
            print("State is now off")
        }
    }
    @objc func seeAllCoinHistory() {
        print("See all coin history tapped")
    }
    @objc func seeAllCustomers() {
        print("See all customer tapped")
    }
}

extension MerchantDashboardViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StoryTableViewCell.id, for: indexPath) as? StoryTableViewCell else {return UITableViewCell()}
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
}

extension MerchantDashboardViewController {
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.setTopAnchorConstraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        tableView.setLeadingAnchorConstraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
        tableView.setTrailingAnchorConstraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        tableView.setBottomAnchorConstraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    }
}

//#if DEBUG
//import SwiftUI
//struct UIKitPreviewProvider: UIViewControllerRepresentable {
//    typealias UIViewControllerType = UIViewController
//    private let viewController: UIViewController
//    init (vc: UIViewControllerType) {
//        viewController = vc
//    }
//    func makeUIViewController(context: Context) -> UIViewController {
//        return viewController
//    }
//    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
//    }
//}
//@available(iOS 13.0, *)
//struct VC_Previews: PreviewProvider {
//    static var previews: some View {
//        UIKitPreviewProvider(vc: MerchantDashboardViewController(nibName: nil, bundle: nil))
//    }
//}
//#endif
