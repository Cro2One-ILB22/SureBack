//
//  NotificationsResponses.swift
//  SureBack
//
//  Created by Tubagus Adhitya Permana on 17/11/22.
//

import Foundation

struct NotificationsResponses: Codable {
    let currentPage: Int
    let data: [NotificationData]
    let firstPageURL: String
    let from: Int?
    let lastPage: Int
    let lastPageURL: String
    let links: [Link]
    let nextPageURL: Int?
    let path: String
    let perPage: Int
    let prevPageURL: Int?
    let to: Int?
    let total: Int

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

struct NotificationData: Codable {
    let id: Int
    let title, body: String
    let isRead: Bool
    let createdAt, category: String

    enum CodingKeys: String, CodingKey {
        case id, title, body
        case isRead = "is_read"
        case createdAt = "created_at"
        case category
    }
}

struct Link: Codable {
    let url: String?
    let label: String
    let active: Bool
}
