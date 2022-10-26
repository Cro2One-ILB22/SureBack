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
    }
}
