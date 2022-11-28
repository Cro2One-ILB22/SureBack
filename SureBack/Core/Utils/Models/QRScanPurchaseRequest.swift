//
//  QRScanPurchaseRequest.swift
//  SureBack
//
//  Created by Muhamad Fahmi Al Kautsar on 23/11/22.
//

import Foundation

struct QRScanPurchaseRequest: Codable {
    let usedCoins: Int
    let isRequestingForToken: Bool

    enum CodingKeys: String, CodingKey {
        case usedCoins = "used_coins"
        case isRequestingForToken = "is_requesting_for_token"
    }
}
