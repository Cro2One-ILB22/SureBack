//
//  IsLoginViewController.swift
//  SureBack
//
//  Created by Ditha Nurcahya Avianty on 13/11/22.
//

import Foundation
import UIKit

class IsLoginViewController: UIViewController {
    private var accessToken: String {
        do {
            return try KeychainHelper.standard.read(key: .accessToken)
        } catch {
            print(error)
            return "noToken"
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        if accessToken != "noToken" {
            self.navigationController?.pushViewController(TabBarViewController(), animated: true)
            self.navigationController?.isNavigationBarHidden = true
        } else {
            self.navigationController?.pushViewController(LoginViewController(), animated: true)
            self.navigationController?.isNavigationBarHidden = true
        }
        
    }
}
