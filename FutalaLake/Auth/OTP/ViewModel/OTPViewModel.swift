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
    
    @Published var loginResponseModel = LoginResponseModel()
    
    private let characterLimit: Int = 4
    
    @Published var otp = "" {
        didSet {
            if otp.count > characterLimit && oldValue.count <= characterLimit {
                otp = oldValue
            }
        }
    }
    
    
    
    
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
    
    
    func fetchToeken(mobileNumber: String) {
        isLoading = true
        let param: [String: Any] = ["mobile": mobileNumber, "otp": Int(otp)]
        let url = Constants.baseUrl + Constants.API.sendOTP
        
        
        APIService.shared.makeApiTypeRequest2(url: url, param: param, methodType: .post, expecting: GlobResponseModel.self) { resultStatus, error, data  in
                    
                    DispatchQueue.main.async {
                        self.isLoading = false
                    }
                    
                    if !resultStatus {
                        print("something went wrong:: SeatLayoutViewModel \(#line)")
                        return
                    }
                    
                    
                    guard let data = data else {
                        return
                    }
            
                
                let parsedObj = processGloabalModel(data: data)
            
                if parsedObj.status == false {
                    DispatchQueue.main.async {
                        self.errorMessage = parsedObj.error
                        self.showAlert = true
                        return
                    }
                    
                }
            
                    
                    
                    APIService.shared.parseModel(data: data, expecting: GetTokenModel.self) { result, data in
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
        
        
    }
    
    private func saveToken(token: String) {
        let data = Data(token.utf8)
        KeychainHelper.standard.save(data, service: Constants.tokenKey)
    }
    
    func getOTP(mobileNumber: String) {
        isLoading = true
        let param: [String: Any] = ["mobile": mobileNumber]
        let url = Constants.baseUrl + Constants.API.sendOTP
        APIService.shared.makeApiTypeRequest(url: url, param: param, methodType: .post, expecting: LoginResponseModel.self, passToken: false) { result, data in
            
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
                }
                
            case .failure(let error):
                DispatchQueue.main.async {
                    print("Something went wrong OTPViewModel \(#line)")
                }
            }
            
        }
        
    }
    
}


