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
    let purchase: PurchaseResponse
    let story: ApproveOrRejectStoryResponse?

    enum CodingKeys: String, CodingKey {
        case code
        case instagramID = "instagram_id"
        case expiresAt = "expires_at"
        case updatedAt = "updated_at"
        case createdAt = "created_at"
        case id, merchant, purchase, story
    }
}
