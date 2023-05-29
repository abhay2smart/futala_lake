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
    private var token = ""
    
    func saveToken(data: String)->String? {
        //standard.string(forKey: Constants.tokenKey)
        //standard.set(data, forKey: Constants.tokenKey)
        token = data
        return self.getToken()
    }
    
    func getToken()-> String? {
        let data = token//standard.string(forKey: Constants.tokenKey)
        return data
    }
    
    func deleteToken() {
//        standard.set("", forKey: Constants.tokenKey)
//        standard.removeObject(forKey: Constants.tokenKey)
        token = ""
    }
}
