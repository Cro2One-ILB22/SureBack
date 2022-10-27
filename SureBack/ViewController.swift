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
    }

    @objc func generateQrButtonAction(sender: UIButton!) {

        print("Button Generate tapped")
        let generateQrVC = GenerateQrViewController()
        self.navigationController?.pushViewController(generateQrVC, animated: true)
//        self.present(generateQrVC, animated: true, completion: nil)
    }
}
