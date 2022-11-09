//
//  MentionStoryIGResponse.swift
//  SureBack
//
//  Created by Ditha Nurcahya Avianty on 02/11/22.
//

import Foundation

struct MentionStoryIGResponse: Codable {
    let results: [ResultStoryIG]
}

// MARK: - ResultStoryIG

struct ResultStoryIG: Codable {
    let id: Int
    let takenAt, expiringAt, mediaType: Int
    let imageURL: String
    let videoURL, musicMetadata: String?
    let storyURL: String
    let submittedAt: Int?

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
