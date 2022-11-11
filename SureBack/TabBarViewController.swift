//
//  TabBarViewController.swift
//  SureBack
//
//  Created by Tubagus Adhitya Permana on 07/11/22.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let dashboardVC = MerchantDashboardViewController()
        let qrVC = ViewController()
        let profileVC = ViewController()
        let navDashboard = UINavigationController(rootViewController: dashboardVC)
        let navQR = UINavigationController(rootViewController: qrVC)
        let navProfile = UINavigationController(rootViewController: profileVC)
        navDashboard.tabBarItem = UITabBarItem(title: "Dashboard", image: UIImage(named: "list.dash.header.rectangle"), tag: 1)
        navQR.tabBarItem = UITabBarItem(title: "QR", image: UIImage(named: "qrcode.viewfinder"), tag: 1)
        navProfile.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "person.crop.circle"), tag: 1)
        setViewControllers([navDashboard, navQR, navProfile], animated: false)
    }

}
