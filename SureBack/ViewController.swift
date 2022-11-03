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

//        request.register(name: "tes", email: "aku@gmail.com", password: "tes12345", role: "customer", username: "tbadhit")
//        request.register(name: "anaksoleh", email: "anaksoleh@gmail.com", password: "12345678", role: "customer", username: "tbadhit")
//        // Do any additional setup after loading the view.
//        print("\(Endpoints.getProfileIG.url)dithanrchy")
//
//        request.postLogin(email: "duta@sampolain.com", password: "hahahahah")

        // Do any additional setup after loading the view.

//        request.postLogin(email: "dit@sampolain.com", password: "hahahahah") { data in
//            do {
//                KeychainHelper.standard.delete(key: .accessToken)
//                try KeychainHelper.standard.save(key: .accessToken, value: data.accessToken)
//            } catch {
//                print(error)
//            }
//        }
        request.updateUser(name: "Ditha") { data in
            print(data)
        }

        let buttonGenerate = UIButton(frame: CGRect(x: 100, y: 100, width: 200, height: 50))
        buttonGenerate.backgroundColor = .blue
        buttonGenerate.layer.cornerRadius = 15
        buttonGenerate.setTitle("Generate QR Code", for: .normal)
        buttonGenerate.addTarget(self, action: #selector(generateQrButtonAction), for: .touchUpInside)

        view.addSubview(buttonGenerate)

        let buttonScan = UIButton(frame: CGRect(x: 100, y: 200, width: 200, height: 50))
        buttonScan.backgroundColor = .blue
        buttonScan.layer.cornerRadius = 15
        buttonScan.setTitle("Scan QR Code", for: .normal)
        buttonScan.addTarget(self, action: #selector(scanQrButtonAction), for: .touchUpInside)

        self.view.addSubview(buttonScan)
//        do {
//            let token = "tokenjwtaku"
//            KeychainHelper.standard.delete(key: .accessToken)
//            try KeychainHelper.standard.save(key: .accessToken, value: token)
//            let check = try KeychainHelper.standard.read(key: .accessToken)
//            print("Read token :", check)
//        } catch {
//            print(error)
//        }

//        request.submitStory(storyId: 810204763009581058, instagtamStoryId: 2961825513959555038, accessToken: "810382258313920513|6ovjGXmWDADwY6uRGirS8bnRMeRZLKTKxXFPGRDr")
//        request.getUser(accessToken: "810382258313920513|6ovjGXmWDADwY6uRGirS8bnRMeRZLKTKxXFPGRDr")
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
