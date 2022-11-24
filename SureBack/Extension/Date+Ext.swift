//
//  Date+Ext.swift
//  SureBack
//
//  Created by Ditha Nurcahya Avianty on 24/11/22.
//

import Foundation

extension Date {
    func dateToString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, d MMM yyyy"
        return dateFormatter.string(from: self)
    }
}
