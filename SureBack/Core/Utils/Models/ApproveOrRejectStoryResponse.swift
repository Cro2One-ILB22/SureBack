//
//  ApproveOrRejectStoryResponse.swift
//  SureBack
//
//  Created by Tubagus Adhitya Permana on 04/11/22.
//

// MARK: - ApproveOrRejectStoryResponse
struct ApproveOrRejectStoryResponse: Codable {
    let id: Int
    let instagramStoryID: Int?
    let instagramID: Int
    let imageURI, videoURI, instagramStoryStatus: String?
    let approvalStatus: Int?
    let submittedAt, note: String?
    let createdAt, updatedAt: String
    let storyURL: String?
    let customer: UserInfoResponse?

    enum CodingKeys: String, CodingKey {
        case id
        case instagramStoryID = "instagram_story_id"
        case instagramID = "instagram_id"
        case imageURI = "image_uri"
        case videoURI = "video_uri"
        case instagramStoryStatus = "instagram_story_status"
        case approvalStatus = "approval_status"
        case submittedAt = "submitted_at"
        case note
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case storyURL = "story_url"
        case customer
    }
}
