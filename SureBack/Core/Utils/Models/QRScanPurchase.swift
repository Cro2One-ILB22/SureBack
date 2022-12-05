//
//  QRScanPurchase.swift
//  SureBack
//
//  Created by Muhamad Fahmi Al Kautsar on 23/11/22.
//

import Foundation

struct QRScanPurchase: Codable {
    let purchaseRequest: QRScanPurchaseRequest?
    let purchase: PurchaseResponse?
    let totalPurchase: Int?

    enum CodingKeys: String, CodingKey {
        case purchaseRequest = "purchase_request"
        case purchase
        case totalPurchase = "total_purchase"
    }
}
