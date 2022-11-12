//
//  GenerateTokenOnlineResponse.swift
//  SureBack
//
//  Created by Ditha Nurcahya Avianty on 02/11/22.
//

import Foundation

struct GenerateTokenOnlineResponse: Codable {
    let code: String
    let instagramID: Int
    let expiresAt, updatedAt, createdAt: String
    let id: Int
    let merchant: UserInfoResponse
    let purchase: Purchase

    enum CodingKeys: String, CodingKey {
        case code
        case instagramID = "instagram_id"
        case expiresAt = "expires_at"
        case updatedAt = "updated_at"
        case createdAt = "created_at"
        case id, merchant, purchase
    }
}

// MARK: - Purchase
struct Purchase: Codable {
    let purchaseAmount, paymentAmount: Int
    let updatedAt, createdAt: String
    let id: Int
    let merchant: UserInfoResponse

    enum CodingKeys: String, CodingKey {
        case purchaseAmount = "purchase_amount"
        case paymentAmount = "payment_amount"
        case updatedAt = "updated_at"
        case createdAt = "created_at"
        case id, merchant
    }
}
