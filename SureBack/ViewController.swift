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
        
        let buttonGenerate = UIButton(frame: CGRect(x: 100, y: 100, width: 200, height: 50))
        buttonGenerate.backgroundColor = .blue
        buttonGenerate.layer.cornerRadius = 15
        buttonGenerate.setTitle("Generate QR Code", for: .normal)
        buttonGenerate.addTarget(self, action: #selector(generateQrButtonAction), for: .touchUpInside)

        view.addSubview(buttonGenerate)

        buttonScan.addTarget(self, action: #selector(scanQrButtonAction), for: .touchUpInside)
        view.addSubview(buttonScan)
    }

    @objc func generateQrButtonAction(sender: UIButton!) {
        print("Button Generate tapped")
        let generateQrVC = GenerateQrViewController()
        navigationController?.pushViewController(generateQrVC, animated: true)
//        self.present(generateQrVC, animated: true, completion: nil)
    }

    @objc func scanQrButtonAction(sender: UIButton!) {
        print("Button Scan QR tapped")
        let scanQrVC = ScanQrViewController()
        navigationController?.pushViewController(scanQrVC, animated: true)
    }
}
