//
//  KeychainAccess.swift
//  ProgrammaticUI
//
//  Created by Filipe Ramos on 14/07/2024.
//

import Foundation
import Security

public enum KeychainAccessError: Error {
    case invalidData
    case unableToSaveData
    case dataAlreadyStored
    case dataNotFound
    case unableToReadStoredData
    case unableToDecodeStoredData
}

public struct KeychainAccess {
    
    private enum KeychainAccount {
        static let accessToken = "com.filiperamos.FRBS.accessToken"
    }
    
    
    // MARK: - Password
    
    func savePassword(_ password: String, for username: String) throws {
        guard let data = password.data(using: .utf8) else { throw KeychainAccessError.invalidData }
        
        let query = [
            kSecClass: kSecClassGenericPassword, // The kind of data we're saving. 90% of cases Generic Password is the type we use.
            kSecValueData: data,
            kSecAttrAccount: username, // The identifier used to access the data
            kSecAttrAccessible: kSecAttrAccessibleWhenUnlocked // In which situation can the user access this data. Default is kSecAttrAccessibleWhenUnlocked
        ] as CFDictionary
        
        let status = SecItemAdd(query, nil)
        try manageStatus(status)
    }
    
    func deletePassword(username: String) throws {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: username
        ] as CFDictionary
        
        let status = SecItemDelete(query)
        try manageStatus(status)
    }
    
        
    // MARK: - AccessToken
    
    func updateAccessToken(with token: String) throws {
        guard let data = token.data(using: .utf8) else { throw KeychainAccessError.invalidData }
        
        let newAttributes = [kSecValueData: data] as CFDictionary

        let query = [
            kSecClass: kSecClassInternetPassword,
            kSecAttrAccount: KeychainAccount.accessToken
        ] as CFDictionary

        let status = SecItemUpdate(query, newAttributes)
        try manageStatus(status)
    }
    
    
    // MARK: - Credit Card
    
    func retrieveCardNumber(accountName: String) throws -> String {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: accountName,
            kSecReturnData: true, // TRUE when we want the data to be returned from keychain
            kSecMatchLimit: kSecMatchLimitOne // How many items, max, should be returned
        ] as CFDictionary
        
        var itemRef: CFTypeRef? // Unsafe reference pointing to the returned data
        
        let status = SecItemCopyMatching(query, &itemRef)
        
        try manageStatus(status)
        
        guard let data = itemRef as? Data else { throw KeychainAccessError.unableToReadStoredData }
        
        guard let cardNumber = String(data: data, encoding: .utf8) else { throw KeychainAccessError.unableToDecodeStoredData }
        
        return cardNumber
    }
    
    
    // MARK: - Private functions
    
    private func manageStatus(_ status: OSStatus) throws {
        switch status {
        case errSecSuccess: // All good…
            break
        case errSecItemNotFound:
            throw KeychainAccessError.dataNotFound
        case errSecDuplicateItem:
            throw KeychainAccessError.dataAlreadyStored
        default:
            throw KeychainAccessError.unableToSaveData
        }
    }
}
