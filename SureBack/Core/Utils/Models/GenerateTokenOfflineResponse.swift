//
//  GenerateTokenOfflineResponse.swift
//  SureBack
//
//  Created by Ditha Nurcahya Avianty on 02/11/22.
//

import Foundation

// MARK: - GenerateTokenOfflineResponse
struct GenerateTokenOfflineResponse: Codable {
    let id: Int
    let token: String
    let instagramID, purchaseAmount: Int
    let expiresAt, createdAt, updatedAt: String
    let story: ApproveOrRejectStoryResponse
    let cashback: Cashback
    let merchant: UserInfoResponse?

    enum CodingKeys: String, CodingKey {
        case id, token
        case instagramID = "instagram_id"
        case purchaseAmount = "purchase_amount"
        case expiresAt = "expires_at"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case story, cashback, merchant
    }
}

// MARK: - Cashback
struct Cashback: Codable {
    let amount: Int
    let percent: Double
    let type, createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case amount, percent, type
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}


