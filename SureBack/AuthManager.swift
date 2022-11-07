//
//  AuthManager.swift
//  SureBack
//
//  Created by Tubagus Adhitya Permana on 07/11/22.
//

import Foundation

final class AuthManager {
    static let shared = AuthManager()
    private init() {}
    var isSignedIn: Bool {
        return accessToken != nil
    }
    private var accessToken: String? {
        do {
            return try KeychainHelper.standard.read(key: .accessToken)
        } catch {
            return nil
        }
    }
    private var tokenExpirationDate: Date? {
        return nil
    }
    public func cacheToken(result: LoginResponse) {
        do {
            try KeychainHelper.standard.save(key: .accessToken, value: result.accessToken)
            // Expired Date :
        } catch {
            print(error)
        }
    }
    public func withValidToken(completion: @escaping (String) -> Void) {
        if let token = accessToken {
            completion(token)
        }
    }
}
