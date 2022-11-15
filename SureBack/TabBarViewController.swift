//
//  TabBarViewController.swift
//  SureBack
//
//  Created by Tubagus Adhitya Permana on 07/11/22.
//

import UIKit

class TabBarViewController: UITabBarController {
    let request = RequestFunction()
    var user: UserInfoResponse!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        request.getUserInfo { [self] data in
            switch data {
            case let .success(result):
                do {
                    self.user = result
                    print("login success")

                    let qrVC = ViewController()
                    let profileVC = ViewController()
                    let navQR = UINavigationController(rootViewController: qrVC)
                    let navProfile = UINavigationController(rootViewController: profileVC)
                    navQR.tabBarItem = UITabBarItem(title: "QR", image: UIImage(named: "qrcode.viewfinder"), tag: 1)
                    navProfile.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "person.crop.circle"), tag: 1)

                    if user.roles![1] == "customer" {
                        let dashboardVC = CustomerDashboardViewController()
                        dashboardVC.user = user
                        let navDashboard = UINavigationController(rootViewController: dashboardVC)
                        navDashboard.tabBarItem = UITabBarItem(title: "Dashboard", image: UIImage(named: "list.dash.header.rectangle"), tag: 1)
                        setViewControllers([navDashboard, navQR, navProfile], animated: false)
                    } else {
                        let dashboardVC = MerchantDashboardViewController()
                        dashboardVC.user = user
                        let navDashboard = UINavigationController(rootViewController: dashboardVC)
                        navDashboard.tabBarItem = UITabBarItem(title: "Dashboard", image: UIImage(named: "list.dash.header.rectangle"), tag: 1)
                        setViewControllers([navDashboard, navQR, navProfile], animated: false)
                    }
                } catch let error as NSError {
                    print(error.description)
                }
            case let .failure(error):
                print(error)
                print("failed to login")
                if error.responseCode == 401 {
                    KeychainHelper.standard.delete(key: .accessToken)
                    let loginVC = LoginViewController()
                    let navLogin = UINavigationController(rootViewController: loginVC)
                    navLogin.modalPresentationStyle = .fullScreen
                    present(navLogin, animated: true, completion: nil)
                }
            }
        }
    }
}
