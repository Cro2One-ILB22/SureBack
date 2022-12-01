//
//  AccountInfoResponse.swift
//  SureBack
//
//  Created by Ditha Nurcahya Avianty on 02/11/22.
//

import Foundation
import AutoEquatable

// MARK: - UserInfoResponse

class UserInfoResponse: Codable, AutoEquatable {
    let id: Int
    var name: String
    var profilePicture: String?
    let instagramID: Int
    var instagramUsername: String
    var balance: Int
    var email: String
    var emailVerifiedAt: String?
    let createdAt, updatedAt: String?
    let roles: [String]?
    var merchantDetail: MerchantDetailResponse?
    let coins: [Coin]?
    let individualCoins: [Coin]?

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
        case individualCoins = "individual_coins"
    }
}

// MARK: - Coin

struct Coin: Codable, AutoEquatable {
    let allTimeReward, outstanding, exchanged: Int
    let coinType, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case allTimeReward = "all_time_reward"
        case outstanding, exchanged
        case coinType = "coin_type"
        case updatedAt = "updated_at"
    }
}
