//
//  OTPViewModel.swift
//  FutalaLake
//
//  Created by Abhayjeet Singh on 03/03/23.
//

import SwiftUI
import Foundation

class OTPViewModel: ObservableObject {
    
    @Published var isLoggedIn: Bool = false
    @Published var showAlert = false
    @Published var errorMessage = ""
    @Published var isLoading = false
    
    
    //@Published var getTokenModel = GetTokenModel()
    
    
    func isValidated(otp: String)->Bool {
        
        if otp.isEmpty {
            //status = false
            errorMessage = "Please enter OTP"
            showAlert = true
            return false
        }
        
        if otp.count < 4 || otp.count > 4 {
            //status = false
            errorMessage = "Please enter valid OTP"
            showAlert = true
            return false
        }
        
        return true
        
    }
    
    
    
//    func fetchToeken() {
//        isLoading = true
//        DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute: {
//            self.isLoggedIn = true
//            self.isLoading = false
//        })
//    }
    
    
    func fetchToeken(mobileNumber: String, otp: String) {
        isLoading = true
        let param: [String: Any] = ["mobile": mobileNumber, "otp": Int(otp)]
        let url = Constants.baseUrl + Constants.API.sendOTP
        APIService.shared.makeApiTypeRequest(url: url, param: param, methodType: .post, expecting: GetTokenModel.self, passToken: false) { result, data in
            
            DispatchQueue.main.async {
                self.isLoading = false
            }
            
            
            switch result {
            case .success(let respData):
                DispatchQueue.main.async {
                    if respData.status ?? false {
                        if let token = respData.data?.first?.token  {
                            self.saveToken(token: token)
                            self.isLoggedIn = true
                        }
                    }
                }
                
            case .failure(let error):
                if error as! CustomAPIError == CustomAPIError.tokenExpired {
                    DispatchQueue.main.async {
                        print("Something went wrong")
                    }
                }
            }
            
        }
    }
    
    private func saveToken(token: String) {
        let data = Data(token.utf8)
        KeychainHelper.standard.save(data, service: Constants.tokenKey)
    }
    
    
}
