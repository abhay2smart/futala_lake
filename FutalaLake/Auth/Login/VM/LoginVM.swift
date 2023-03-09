//
//  LoginVM.swift
//  FutalaLake
//
//  Created by Abhayjeet Singh on 27/02/23.
//

import SwiftUI

class LoginVM: ObservableObject {
    
    //validation
    
    @Published var showAlert = false
    @Published var errorMessage = ""
    
    
    func validate(mobileNumber: String) {
        
        if mobileNumber.isEmpty {
            //status = false
            errorMessage = "Please enter mobile number"
            showAlert = true
            return
        }
        
        if mobileNumber.count < 10 || mobileNumber.count > 10 {
            //status = false
            errorMessage = "Please enter valid mobile number"
            showAlert = true
            return
        }
        
        getOTP(mobileNumber: mobileNumber)
        
        
    }
    
    // API call
    
    @Published var shouldMoveToOTPView = false
    
    @Published var loginResponseModel = LoginResponseModel()
    @Published var isLoading = false
    @Published var otp: String = ""
    
    func getOTP(mobileNumber: String) {
        isLoading = true
        let param: [String: Any] = ["mobile": mobileNumber]
        let url = Constants.baseUrl + Constants.API.sendOTP
        APIService.shared.makeApiTypeRequest(url: url, param: param, methodType: .post, expecting: LoginResponseModel.self, passToken: false) { result in
            
            DispatchQueue.main.async {
                self.isLoading = false
            }
            
            
            switch result {
            case .success(let respData):
                DispatchQueue.main.async {
                    self.loginResponseModel = respData
                    if let otp = self.loginResponseModel.data?.first?.otp {
                        self.otp = "\(otp)"
                    }
                    print("Hola \(self.loginResponseModel.data?.first?.otp)")
                    self.shouldMoveToOTPView = true
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
    
    
    
    
    
    
}
