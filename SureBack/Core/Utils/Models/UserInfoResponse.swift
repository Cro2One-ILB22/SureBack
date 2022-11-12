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
    let profilePicture: String
    let instagramID: Int
    let instagramUsername: String
    let balance: Int
    let email: String
    let emailVerifiedAt: String?
    let createdAt, updatedAt: String?
    let roles: [String]?
    let merchantDetail: MerchantDetailResponse?
    let coins: [Coin]?

    enum CodingKeys: String, CodingKey {
        case id, name
        case profilePicture = "profile_picture"
        case instagramID = "instagram_id"
        case instagramUsername = "instagram_username"
        case balance, email
        case emailVerifiedAt = "email_verified_at"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case roles
        case merchantDetail = "merchant_detail"
        case coins
    }
}

// MARK: - Coin

struct Coin: Codable {
    let allTimeReward, outstanding, exchanged: Int
    let coinType, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case allTimeReward = "all_time_reward"
        case outstanding, exchanged
        case coinType = "coin_type"
        case updatedAt = "updated_at"
    }
}
