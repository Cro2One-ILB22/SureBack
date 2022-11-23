//
//  UIActivityIndicatorView+Ext.swift
//  SureBack
//
//  Created by Tubagus Adhitya Permana on 22/11/22.
//

import UIKit

extension UIActivityIndicatorView {
    func show(_ isShow: Bool) {
        if isShow {
            self.startAnimating()
            self.isHidden = !isShow
        } else {
            self.stopAnimating()
            self.isHidden = isShow
        }
    }
}
