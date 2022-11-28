//
//  QRScanRequest.swift
//  SureBack
//
//  Created by Muhamad Fahmi Al Kautsar on 23/11/22.
//

import Foundation

struct QRScanRequest: Codable {
    let merchantId: Int

    enum CodingKeys: String, CodingKey {
        case merchantId = "merchant_id"
    }
}
