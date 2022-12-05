//
//  MerchantDetailResponse.swift
//  SureBack
//
//  Created by Ditha Nurcahya Avianty on 04/11/22.
//

import Foundation
import AutoEquatable

// MARK: - MerchantDetailResponse
struct MerchantDetailResponse: Codable, AutoEquatable {
    var cashbackPercent: Float?
    var cashbackLimit, dailyTokenLimit: Int?
    let isActiveGeneratingToken: Bool
    let todaysTokenCount: Int
    let updatedAt, lastTokenGeneratedForMeAt: String?
    var cashbackCalculationMethod: String?
    let cooldownUntil: String?
    let addresses: [Address]?

    enum CodingKeys: String, CodingKey {
        case cashbackPercent = "cashback_percent"
        case cashbackLimit = "cashback_limit"
        case dailyTokenLimit = "daily_token_limit"
        case isActiveGeneratingToken = "is_active_generating_token"
        case updatedAt = "updated_at"
        case cashbackCalculationMethod = "cashback_calculation_method"
        case lastTokenGeneratedForMeAt = "last_token_generated_for_me_at"
        case todaysTokenCount = "todays_token_count"
        case cooldownUntil = "cooldown_until"
        case addresses
    }
}

// MARK: - Address
struct Address: Codable {
    let id: Int
    let createdAt, updatedAt: String
    let location: Location

    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case location
    }
}

// MARK: - Location
struct Location: Codable {
    let id: Int
    let latitude, longitude: Double
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, latitude, longitude
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
