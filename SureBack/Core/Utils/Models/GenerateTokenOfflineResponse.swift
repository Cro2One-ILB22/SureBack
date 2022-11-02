//
//  GenerateTokenOfflineResponse.swift
//  SureBack
//
//  Created by Ditha Nurcahya Avianty on 02/11/22.
//

import Foundation

struct GenerateTokenOfflineResponse: Codable {
    let id: Int
    let token, expiresAt, createdAt, updatedAt: String
    let instagramID, purchaseAmount, cashbackAmount: Int
    let story: Story
    let partner: Partner

    enum CodingKeys: String, CodingKey {
        case id, token
        case expiresAt = "expires_at"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case instagramID = "instagram_id"
        case purchaseAmount = "purchase_amount"
        case cashbackAmount = "cashback_amount"
        case story, partner
    }
}

// MARK: - Partner

struct Partner: Codable {
    let id: Int
    let name: String
    let instagramID, balance, points: Int
    let email: String
    let emailVerifiedAt: JSONNull?
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case instagramID = "instagram_id"
        case balance, points, email
        case emailVerifiedAt = "email_verified_at"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

// MARK: - Story

struct Story: Codable {
    let id: Int
    let instagramStoryID: JSONNull?
    let instagramID: String
    let imageURI, videoURI, status, note: JSONNull?
    let createdAt, updatedAt: String
    let submittedAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case instagramStoryID = "instagram_story_id"
        case instagramID = "instagram_id"
        case imageURI = "image_uri"
        case videoURI = "video_uri"
        case status, note
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case submittedAt = "submitted_at"
    }
}
