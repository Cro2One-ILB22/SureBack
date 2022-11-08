//
//  AccountInfoResponse.swift
//  SureBack
//
//  Created by Ditha Nurcahya Avianty on 02/11/22.
//

import Foundation

// MARK: - UserInfoResponse
struct UserInfoResponse: Codable {
    let id: Int
    let name: String
    let instagramID: Int
    let instagramUsername: String
    let balance, coins: Int
    let email: String
    let emailVerifiedAt: String?
    let createdAt, updatedAt: String
    let roles: [String]?
    let merchantDetail: MerchantDetailResponse?

    enum CodingKeys: String, CodingKey {
        case id, name
        case instagramID = "instagram_id"
        case instagramUsername = "instagram_username"
        case balance, coins, email
        case emailVerifiedAt = "email_verified_at"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case roles
        case merchantDetail = "merchant_detail"
    }
}
