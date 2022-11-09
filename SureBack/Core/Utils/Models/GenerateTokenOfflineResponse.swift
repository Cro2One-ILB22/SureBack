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
    let instagramID, purchaseAmount, cashbackAmount: Int
    let cashbackPercent: Float
    let expiresAt, createdAt, updatedAt: String
    let story: ApproveOrRejectStoryResponse
    let merchant: UserInfoResponse?

    enum CodingKeys: String, CodingKey {
        case id, token
        case instagramID = "instagram_id"
        case purchaseAmount = "purchase_amount"
        case cashbackAmount = "cashback_amount"
        case cashbackPercent = "cashback_percent"
        case expiresAt = "expires_at"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case story, merchant
    }
}


