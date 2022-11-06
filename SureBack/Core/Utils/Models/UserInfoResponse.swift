//
//  AccountInfoResponse.swift
//  SureBack
//
//  Created by Ditha Nurcahya Avianty on 02/11/22.
//

import Foundation

// MARK: - UserInfoResponse
struct UserInfoResponse: Codable {
    let id: Double
    let name: String
    let instagramID, balance, points: Int
    let email: String
    let emailVerifiedAt: String?
    let createdAt, updatedAt: String
    let instagramUsername: String?
    let roles: [String]
    let partnerDetail: PartnerDetailResponse?

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
