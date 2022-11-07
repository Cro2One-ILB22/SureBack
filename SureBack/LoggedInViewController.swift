//
//  LoggedInViewController.swift
//  SureBack
//
//  Created by Ditha Nurcahya Avianty on 07/11/22.
//

import Foundation
import UIKit

class LoggedInViewController: UIViewController {
    var user: UserInfoResponse?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        let button = UIButton()
        button.setTitle("Test", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(nextTo), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isEnabled = (user != nil) ? true : false
        view.addSubview(button)

        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

        let request = RequestFunction()
        request.getUserInfo { data in
            switch data {
            case let .success(result):
                do {
                    self.user = result
                    print("login success")
                    button.isEnabled = true
                } catch let error as NSError {
                    print(error.description)
                }
            case let .failure(error):
                print(error)
                print("failed to login")
            }
        }
    }

    @objc func nextTo() {
        guard let user = user else {
            return
        }
        let nextVC = ShowQRViewController()
        nextVC.user = user
        navigationController?.pushViewController(nextVC, animated: true)
    }
}
