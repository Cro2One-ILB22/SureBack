//
//  QRScanPurchaseRequest.swift
//  SureBack
//
//  Created by Muhamad Fahmi Al Kautsar on 23/11/22.
//

import Foundation

struct QRScanPurchaseRequest: Codable {
    let coinsUsed: Int
    let isRequestingForToken: Bool

    enum CodingKeys: String, CodingKey {
        case coinsUsed = "coins_used"
        case isRequestingForToken = "is_requesting_for_token"
    }
}
