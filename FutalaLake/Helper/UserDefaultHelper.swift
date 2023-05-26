//
//  UserDefaultHelper.swift
//  FutalaLake
//
//  Created by Abhayjeet Singh on 26/05/23.
//

import Foundation

class UserDefaultHelper {
    private let standard = UserDefaults.standard
    static let shared = UserDefaultHelper()
    
    func save(data: String) {
        //standard.string(forKey: Constants.tokenKey)
        standard.set(data, forKey: Constants.tokenKey)
    }
    
    func getToken()-> String? {
        let data = standard.string(forKey: Constants.tokenKey)
        return data
    }
}
