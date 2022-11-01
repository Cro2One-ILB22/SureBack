//
//  Model.swift
//  SureBack
//
//  Created by Ditha Nurcahya Avianty on 25/10/22.
//

import Foundation

// MARK: - ResponsePostLogin

struct ResponsePostLogin: Codable {
    let roles: [String]
    let accessToken, tokenType: String
    let expiresIn: Int

    enum CodingKeys: String, CodingKey {
        case roles
        case accessToken = "access_token"
        case tokenType = "token_type"
        case expiresIn = "expires_in"
    }
}

// MARK: - Account

struct Account: Codable {
    let id: Double
    let name: String
    let instagramID, balance, points: Int
    let email: String
    let emailVerifiedAt: JSONNull?
    let createdAt, updatedAt: String
    let roles: [String]

    enum CodingKeys: String, CodingKey {
        case id, name
        case instagramID = "instagram_id"
        case balance, points, email
        case emailVerifiedAt = "email_verified_at"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case roles
    }
}

// MARK: - GenerateTokenOnline

struct GenerateTokenOnline: Codable {
    let token: String
    let cashbackAmount: Int

    enum CodingKeys: String, CodingKey {
        case token
        case cashbackAmount = "cashback_amount"
    }
}

// MARK: - GenerateTokenOffline

struct GenerateTokenOffline: Codable {
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
    let submittedAt: JSONNull?

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

// MARK: - ProfileIG

struct ProfileIG: Codable {
    let id, username, fullName: String
    let profilePicURL, profilePicURLHD: String
    let biography: String
    let externalURL: JSONNull?
    let isPrivate, isVerified: Bool
    let postCount, followerCount, followingCount: Int

    enum CodingKeys: String, CodingKey {
        case id, username
        case fullName = "full_name"
        case profilePicURL = "profile_pic_url"
        case profilePicURLHD = "profile_pic_url_hd"
        case biography
        case externalURL = "external_url"
        case isPrivate = "is_private"
        case isVerified = "is_verified"
        case postCount = "post_count"
        case followerCount = "follower_count"
        case followingCount = "following_count"
    }
}

// MARK: - StoryIG

struct StoryIG: Codable {
    let results: [ResultStoryIG]
}

// MARK: - ResultStoryIG

struct ResultStoryIG: Codable {
    let id: String
    let takenAt, expiringAt, mediaType: Int
    let imageURL: String
    let videoURL, musicMetadata: JSONNull?
    let storyURL: String
    let submittedAt: JSONNull?

    enum CodingKeys: String, CodingKey {
        case id
        case takenAt = "taken_at"
        case expiringAt = "expiring_at"
        case mediaType = "media_type"
        case imageURL = "image_url"
        case videoURL = "video_url"
        case musicMetadata = "music_metadata"
        case storyURL = "story_url"
        case submittedAt = "submitted_at"
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {
    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
