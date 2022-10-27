//
//  ViewController.swift
//  SureBack
//
//  Created by Muhamad Fahmi Al Kautsar on 24/10/22.
//

import UIKit

class ViewController: UIViewController {
    
    let request = RequestFunction()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        // Do any additional setup after loading the view.
        print("\(Endpoints.getProfileIG.url)dithanrchy")
        
        let bodyLogin: [String: String] = [
            "email": "duta@sampolain.com",
            "password": "hahahahah"
        ]
        
        request.postLogin(url: Endpoints.login.url, bodyLogin: bodyLogin)

        let buttonGenerate = UIButton(frame: CGRect(x: 100, y: 100, width: 200, height: 50))
        buttonGenerate.backgroundColor = .blue
        buttonGenerate.layer.cornerRadius = 15
        buttonGenerate.setTitle("Generate QR Code", for: .normal)
        buttonGenerate.addTarget(self, action: #selector(generateQrButtonAction), for: .touchUpInside)

        self.view.addSubview(buttonGenerate)

        let buttonScan = UIButton(frame: CGRect(x: 100, y: 200, width: 200, height: 50))
        buttonScan.backgroundColor = .blue
        buttonScan.layer.cornerRadius = 15
        buttonScan.setTitle("Scan QR Code", for: .normal)
        buttonScan.addTarget(self, action: #selector(scanQrButtonAction), for: .touchUpInside)

        self.view.addSubview(buttonScan)
    }

    @objc func generateQrButtonAction(sender: UIButton!) {

        print("Button Generate tapped")
        let generateQrVC = GenerateQrViewController()
        self.navigationController?.pushViewController(generateQrVC, animated: true)
//        self.present(generateQrVC, animated: true, completion: nil)
    }

    @objc func scanQrButtonAction(sender: UIButton!) {

        print("Button Scan QR tapped")
        let scanQrVC = ScanQrViewController()
        self.navigationController?.pushViewController(scanQrVC, animated: true)
    }
}
