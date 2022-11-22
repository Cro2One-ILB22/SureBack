//
//  MyStoryResponses.swift
//  SureBack
//
//  Created by Tubagus Adhitya Permana on 22/11/22.
//

struct MyStoryResponses: Codable {
    let currentPage: Int
    let data: [MyStoryData]
    let firstPageURL: String
    let from, lastPage: Int
    let lastPageURL: String
    let links: [MyStoryLink]
    let nextPageURL: Int?
    let path: String
    let perPage: Int
    let prevPageURL: Int?
    let to, total: Int

    enum CodingKeys: String, CodingKey {
        case currentPage = "current_page"
        case data
        case firstPageURL = "first_page_url"
        case from
        case lastPage = "last_page"
        case lastPageURL = "last_page_url"
        case links
        case nextPageURL = "next_page_url"
        case path
        case perPage = "per_page"
        case prevPageURL = "prev_page_url"
        case to, total
    }
}

struct MyStoryData: Codable {
    let id: Int
    let instagramStoryID: Int?
    let instagramID: Int
    let imageURI, videoURI, instagramStoryStatus, approvalStatus: String?
    let note, expiringAt, submittedAt, assessedAt: String?
    let inspectedAt: String?
    let createdAt, updatedAt: String
    let storyURL: String?
    let token: MyStoryToken

    enum CodingKeys: String, CodingKey {
        case id
        case instagramStoryID = "instagram_story_id"
        case instagramID = "instagram_id"
        case imageURI = "image_uri"
        case videoURI = "video_uri"
        case instagramStoryStatus = "instagram_story_status"
        case approvalStatus = "approval_status"
        case note
        case expiringAt = "expiring_at"
        case submittedAt = "submitted_at"
        case assessedAt = "assessed_at"
        case inspectedAt = "inspected_at"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case storyURL = "story_url"
        case token
    }
}
// MARK: - Token
class MyStoryToken: Token {}

// MARK: - Merchant
class MyStoryMerchant: UserInfoResponse {}

// MARK: - Purchase
class MyStoryPurchase: PurchaseResponse {}

// MARK: - Link
class MyStoryLink: LinkResponses {}
