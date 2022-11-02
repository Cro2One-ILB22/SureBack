//
//  GenerateTokenOnlineResponse.swift
//  SureBack
//
//  Created by Ditha Nurcahya Avianty on 02/11/22.
//

import Foundation

struct GenerateTokenOnlineResponse: Codable {
    let token: String
    let cashbackAmount: Int

    enum CodingKeys: String, CodingKey {
        case token
        case cashbackAmount = "cashback_amount"
    }
}
