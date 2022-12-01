//
//  ResponseData.swift
//  SureBack
//
//  Created by Ditha Nurcahya Avianty on 02/11/22.
//

import Foundation

struct ResponseData<T: Codable>: Codable {
    let data: [T]
    let lastPage: Int?

    enum CodingKeys: String, CodingKey {
        case data
        case lastPage = "last_page"
    }
}
