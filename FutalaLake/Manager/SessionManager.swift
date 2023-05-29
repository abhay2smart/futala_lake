//
//  SessionManager.swift
//  NewSwifUIAPiCalls
//
//  Created by Abhayjeet Singh on 07/11/22.
//

import SwiftUI

enum UserState {
    case loggedIn
    case loggedout
}
class SessionManager: ObservableObject {
    @Published var currentUserState:UserState = .loggedout
    //@Published var isLoading:Bool = false
    @Published var moveToDashboard: Bool = false
    
    @Published var currentTab = 1
    
    init() {
//        let data = KeychainHelper.standard.read(service: Constants.tokenKey)
//        if let data = data {
//            let accessToken = String(data: data, encoding: .utf8)
//            if let accessToken, accessToken != "" {
//                self.currentUserState = .loggedIn
//            }
//        }
        
        let accessToken = UserDefaultHelper.shared.getToken() ?? ""
        if accessToken != "" {
            self.currentUserState = .loggedIn
        }
        
    }
    
    func signIn() {
        self.currentUserState = .loggedIn
    }
    
    func signout() {
        //KeychainHelper.standard.delete(service: Constants.tokenKey)
        UserDefaultHelper.shared.deleteToken()
        self.currentUserState = .loggedout
        currentTab = 1
    }
}
