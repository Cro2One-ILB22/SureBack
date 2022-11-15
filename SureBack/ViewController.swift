//
//  ViewController.swift
//  SureBack
//
//  Created by Muhamad Fahmi Al Kautsar on 24/10/22.
//

import UIKit

class ViewController: UIViewController {
    let request = RequestFunction()

    let buttonScan: UIButton = {
        let button = UIButton(frame: CGRect(x: 100, y: 100, width: 200, height: 50))
        button.backgroundColor = .blue
        button.layer.cornerRadius = 15
        button.setTitle("Scan QR Code", for: .normal)
        return button
    }()

    let logoutButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 100, y: 200, width: 200, height: 50))
        button.backgroundColor = .blue
        button.layer.cornerRadius = 15
        button.setTitle("Logout", for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        navigationItem.title = "Testingg"

        buttonScan.addTarget(self, action: #selector(scanQrButtonAction), for: .touchUpInside)
        view.addSubview(buttonScan)

        logoutButton.addTarget(self, action: #selector(logout), for: .touchUpInside)
        view.addSubview(logoutButton)
    }

    @objc func scanQrButtonAction(sender: UIButton!) {
        print("Button Scan QR tapped")
        let scanQrVC = ScanQrViewController()
        navigationController?.pushViewController(scanQrVC, animated: true)
//        self.present(generateQrVC, animated: true, completion: nil)
    }

    @objc func logout(sender: UIButton!) {
        print("Logout tapped")
        let request = RequestFunction()
        request.postLogout { data in
            switch data {
            case let .success:
                do {
                    print("logout success")
                    let loginVC = LoginViewController()
                    let navLogin = UINavigationController(rootViewController: loginVC)
                    navLogin.modalPresentationStyle = .fullScreen
                    self.present(navLogin, animated: true, completion: nil)
                } catch let error as NSError {
                    print(error.description)
                }
            case .failure:
                break
            }
        }
    }
}
