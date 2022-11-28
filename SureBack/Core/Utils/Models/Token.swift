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
    let issuedAt: String
    let expiredAt, submittedAt: String?
    let finishedAt: String?
    let currentStatus: StatusToken?
    let approvedAt, rejectedAt: String?
    let rejectedReason: String?
    let lastStatusUpdateAt: String?
    let statusHistory: [StatusTokenHistory]

    enum CodingKeys: String, CodingKey {
        case id, code
        case instagramID = "instagram_id"
        case expiresAt = "expires_at"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case merchant, purchase
        case tokenCashback
        case story
        case issuedAt = "issued_at"
        case expiredAt = "expired_at"
        case submittedAt = "submitted_at"
        case finishedAt = "finished_at"
        case currentStatus = "current_status"
        case approvedAt = "approved_at"
        case rejectedAt = "rejected_at"
        case rejectedReason = "rejected_reason"
        case lastStatusUpdateAt = "last_status_update_at"
        case statusHistory = "status_history"
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

enum StatusToken: String, Codable {
    case approved
    case expired
    case issued
    case rejected
    case redeemed
    case submitted
}

// MARK: - StatusTokenHistory
struct StatusTokenHistory: Codable {
    let status: StatusToken
    let timestamp: String?
}
