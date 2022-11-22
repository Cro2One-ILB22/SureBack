//
//  Token.swift
//  SureBack
//
//  Created by Ditha Nurcahya Avianty on 12/11/22.
//

import Foundation

// MARK: - Token
class Token: Codable {
    let id: Int
    let code: String
    let instagramID: Int
    let expiresAt, createdAt, updatedAt: String
    let merchant: UserInfoResponse
    let purchase: ScanQrResponse
    let story: ApproveOrRejectStoryResponse?
    let tokenCashback: TokenCashback?

    enum CodingKeys: String, CodingKey {
        case id, code
        case instagramID = "instagram_id"
        case expiresAt = "expires_at"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case merchant, purchase
        case tokenCashback
        case story
    }
}

// MARK: - TokenCashback
struct TokenCashback: Codable {
    let amount: Int
    let percent: JSONNull?
    let type, createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case amount, percent, type
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
