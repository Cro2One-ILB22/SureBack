//
//  ApproveOrRejectStoryResponse.swift
//  SureBack
//
//  Created by Tubagus Adhitya Permana on 04/11/22.
//

struct ApproveOrRejectStoryResponse: Codable {
    let id: Double
    let instagramStoryID: Int?
    let instagramID: String
    let imageURI, videoURI: String?
    let status: String
    let note: String?
    let createdAt, updatedAt: String
    let submittedAt, storyURL: String?
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
        case storyURL = "story_url"
    }
}
