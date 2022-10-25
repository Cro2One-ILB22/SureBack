//
//  APICall.swift
//  SureBack
//
//  Created by Muhamad Fahmi Al Kautsar on 25/10/22.
//

import Foundation

struct API {
    static let baseUrl: String = ProcessInfo.processInfo.environment["BASE_URL"] ?? "http://localhost:8000"
}

protocol Endpoint {
    var url: String { get }
}

enum Endpoints: Endpoint {
    case login
    case getAccount
    
    public var url: String {
        switch self {
        case .login:
            return "\(API.baseUrl)/api/auth/login"
        case .getAccount:
            return "\(API.baseUrl)/api/auth/me"
        }
    }
}
