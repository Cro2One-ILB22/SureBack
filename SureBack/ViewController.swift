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
        let button = UIButton(frame: CGRect(x: 100, y: 200, width: 200, height: 50))
        button.backgroundColor = .blue
        button.layer.cornerRadius = 15
        button.setTitle("Scan QR Code", for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        navigationItem.title = "Testingg"

        buttonScan.addTarget(self, action: #selector(scanQrButtonAction), for: .touchUpInside)
        view.addSubview(buttonScan)
    }

    @objc func scanQrButtonAction(sender: UIButton!) {
        print("Button Scan QR tapped")
        let scanQrVC = ScanQrViewController()
        navigationController?.pushViewController(scanQrVC, animated: true)
//        self.present(generateQrVC, animated: true, completion: nil)
    }
}
