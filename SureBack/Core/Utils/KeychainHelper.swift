//
//  KeychainHelper.swift
//  SureBack
//
//  Created by Tubagus Adhitya Permana on 01/11/22.
//

import Foundation

class KeychainHelper {
    static let standard = KeychainHelper()
    enum Key: String {
        case accessToken = "access.token"
        fileprivate var tag: Data {
            rawValue.data(using: .utf8)!
        }
    }
    enum KeychainError: Error {
        case saveFailed
        case readFailed
    }
    func save(key: Key, value: String) throws {
        print("Starting save token")
        let addQuery: [String: Any] = [
            kSecClass as String: kSecClassKey,
            kSecAttrApplicationTag as String: key.tag,
            kSecValueData as String: value.data(using: .utf8)!
        ]
        let status = SecItemAdd(addQuery as CFDictionary, nil)
        guard status == errSecSuccess else {
            print("Save key: '\(key.rawValue)' in Keychain failed with status: \(status.description)")
            throw KeychainError.saveFailed
        }
        print("Finished save token")
    }
    func read(key: Key) throws -> String {
        print("Read token...")
        let getQuery: [String: Any] = [
            kSecClass as String: kSecClassKey,
            kSecAttrApplicationTag as String: key.tag,
            kSecReturnData as String: kCFBooleanTrue!
        ]
        var item: AnyObject?
        let status: OSStatus = withUnsafeMutablePointer(to: &item) { (result: UnsafeMutablePointer<AnyObject?>?) -> OSStatus in
            return SecItemCopyMatching(getQuery as CFDictionary, result)
        }
        guard status == errSecSuccess else {
            print("Read key: '\(key.rawValue)' in Keychain failed with status: \(status.description)")
            throw KeychainError.readFailed
        }
        guard let itemData = item as? Data else {throw KeychainError.readFailed }
        return String(decoding: itemData, as: UTF8.self)
    }
    func delete(key: Key) {
        let query = [
            kSecClass as String: kSecClassKey,
            kSecAttrApplicationTag as String: key.tag
        ] as CFDictionary
        SecItemDelete(query)
    }
}
