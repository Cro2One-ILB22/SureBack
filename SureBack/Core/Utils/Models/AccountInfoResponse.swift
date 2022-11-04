//
//  AccountInfoResponse.swift
//  SureBack
//
//  Created by Ditha Nurcahya Avianty on 02/11/22.
//

import Foundation

// MARK: - AccountInfoResponse
struct AccountInfoResponse: Codable {
    let id: Double
    let name: String
    let instagramID, balance, points: Int
    let email: String
    let emailVerifiedAt: JSONNull?
    let createdAt, updatedAt: String
    let instagramUsername: String?
    let roles: [String]
    let partnerDetail: PartnerDetail?

    enum CodingKeys: String, CodingKey {
        case id, name
        case instagramID = "instagram_id"
        case balance, points, email
        case emailVerifiedAt = "email_verified_at"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case instagramUsername = "instagram_username"
        case roles
        case partnerDetail = "partner_detail"
    }
}

// MARK: - PartnerDetail
struct PartnerDetail: Codable {
    let cashbackPercent: String
    let cashbackLimit, dailyTokenLimit: JSONNull?
    let todaysTokenCount: Int

    enum CodingKeys: String, CodingKey {
        case cashbackPercent = "cashback_percent"
        case cashbackLimit = "cashback_limit"
        case dailyTokenLimit = "daily_token_limit"
        case todaysTokenCount = "todays_token_count"
    }
}
