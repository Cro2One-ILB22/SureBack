//
//  PartnerDetailResponse.swift
//  SureBack
//
//  Created by Ditha Nurcahya Avianty on 04/11/22.
//

import Foundation

// MARK: - PartnerDetailResponse
struct PartnerDetailResponse: Codable {
    let cashbackPercent: Float
    let cashbackLimit, dailyTokenLimit: Int?
    let updatedAt: String?
    let isActiveGeneratingToken: Bool
    let todaysTokenCount: Int

    enum CodingKeys: String, CodingKey {
        case cashbackPercent = "cashback_percent"
        case cashbackLimit = "cashback_limit"
        case dailyTokenLimit = "daily_token_limit"
        case updatedAt = "updated_at"
        case isActiveGeneratingToken = "is_active_generating_token"
        case todaysTokenCount = "todays_token_count"
    }
}
