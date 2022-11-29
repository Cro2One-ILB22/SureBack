//
//  UIImageView+Ext.swift
//  SureBack
//
//  Created by Tubagus Adhitya Permana on 23/11/22.
//

import UIKit
let defaultImage = "https://kecsimpangtigaspt.sigapaceh.id/assets/img/default-img.png"

extension UIImageView {
    func makeRounded() {
//        layer.borderWidth = 1
//        layer.borderColor = UIColor.osloGray.cgColor
        layer.cornerRadius = self.frame.height / 2
        clipsToBounds = true
    }
}
