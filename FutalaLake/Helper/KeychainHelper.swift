//
//  KeychainHelper.swift
//  FutalaLake
//
//  Created by Abhayjeet Singh on 02/03/23.
//

import Foundation
class KeychainHelper {
    static let standard = KeychainHelper()
    
    func save(_ data: Data, service: String) {
        
        // Create query
        let query = [
            kSecValueData: data,
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service
        ] as CFDictionary
        
        // Add data in query to keychain
        let status = SecItemAdd(query, nil)
        
        if status != errSecSuccess {
            // Print out the error
            print("Error: \(status)")
        }
    }
    
    func read(service: String) -> Data? {
        
        let query = [
            kSecAttrService: service,
            kSecClass: kSecClassGenericPassword,
            kSecReturnData: true
        ] as CFDictionary
        
        var result: AnyObject?
        SecItemCopyMatching(query, &result)
        
        return (result as? Data)
    }
    
    
    func delete(service: String) {
        
        let query = [
            kSecAttrService: service,
            kSecClass: kSecClassGenericPassword,
            ] as CFDictionary
        
        // Delete item from keychain
        SecItemDelete(query)
    }
}

