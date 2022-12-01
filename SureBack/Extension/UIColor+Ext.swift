//
//  UIColor+Ext.swift
//  SureBack
//
//  Created by Tubagus Adhitya Permana on 23/11/22.
//

import UIKit

extension UIColor {
    static let softPeach = UIColor(rgb: 0xffFCECEB) // Kyk pink
    static let titanWhite = UIColor(rgb: 0xffE7F1FB) // Biru ke putih"an
    static let tealishGreenWithOpacity = UIColor(rgb: 0xff2CD76D).withAlphaComponent(0.14) // Ijo ke putih"an
    static let tealishGreen = UIColor(rgb: 0xff2CD76D) // Ijo
    static let osloGray = UIColor(rgb: 0xff8A8C8F) // abu-abu keputihan
    static let porcelain = UIColor(rgb: 0xffF2F2F7) // putih ke abu abuan
    static let iceBerg = UIColor(rgb: 0xffD9F7E7) // hijau muda keputihan
    static let pastelGray = UIColor(rgb: 0xffcccccc)
}

extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
}
