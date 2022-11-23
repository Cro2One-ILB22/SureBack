//
//  String+Ext.swift
//  SureBack
//
//  Created by Tubagus Adhitya Permana on 23/11/22.
//

import Foundation

extension String {
    func formatTodMMMyyyhmma() -> Self {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = dateFormatter.date(from: self)
        dateFormatter.dateFormat = "d MMM yyyy, h:mm a"
        return dateFormatter.string(from: date!)
    }
}
