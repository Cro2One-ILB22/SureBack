//
//  GenerateQrViewController.swift
//  SureBack
//
//  Created by Ditha Nurcahya Avianty on 27/10/22.
//

import UIKit

class GenerateQrViewController: UIViewController {

    let function = Function()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Generate QR Code"
        view.backgroundColor = .cyan

        let imageView = UIImageView(image: function.generateQR(userID: 23)) //userID dummy
        imageView.frame = CGRect(x: 100, y: 200, width: 200, height: 200)
        view.addSubview(imageView)
    }
}
