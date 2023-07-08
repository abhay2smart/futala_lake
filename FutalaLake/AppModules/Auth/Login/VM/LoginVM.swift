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
    
    @Published var isLoggedIn: Bool = false
    
    @Published private var allowedSeconds = 0
    
    @Published var displayCountDown = "02:00"
    
    
    
    @Published private var timer: Timer?
    
    @Published var isTimerFinished = true
    
    
    func isValidatedMobile(mobileNumber: String)->Bool {
        if mobileNumber.isEmpty {
            //status = false
            errorMessage = "Please enter mobile number"
            showAlert = true
            return false
        }
        
        if mobileNumber.count < 10 || mobileNumber.count > 10 {
            //status = false
            errorMessage = "Please enter valid mobile number"
            showAlert = true
            return false
        }
        
        return true
        
        //getOTP(mobileNumber: mobileNumber)
        
        
    }
    
    // API call
    
    @Published var shouldMoveToOTPView = false
    
    @Published var loginResponseModel = LoginResponseModel()
    @Published var isLoading = false
    
    @Published var isOTPRecieved = false
    private let characterLimit: Int = 4
    
    @Published var otp = "" {
        didSet {
            if otp.count > characterLimit && oldValue.count <= characterLimit {
                otp = oldValue
            }
        }
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
                        self.isOTPRecieved = true
                        self.otp = "\(otp)"
                        self.startCountdown()
                    }
                    //self.shouldMoveToOTPView = true
                }
                
            case .failure(let error):
                DispatchQueue.main.async {
                    self.errorMessage = "Something went wrong!"//error.localizedDescription
                    self.showAlert = true
                    print("Something went wrong \(error.localizedDescription) LoginVM \(#line)")
                }
            }
            
        }
    }
    
    
    func isValidatedMobileAndOTP(otp: String, mobileNumber: String)->Bool {
        
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
        
        if mobileNumber.isEmpty {
            //status = false
            errorMessage = "Please enter mobile number"
            showAlert = true
            return false
        }
        
        if mobileNumber.count < 10 || mobileNumber.count > 10 {
            //status = false
            errorMessage = "Please enter valid mobile number"
            showAlert = true
            return false
        }
        
        return true
        
    }
    
    
    
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
                                        let isTokenSaved = UserDefaultHelper.shared.saveToken(data: token)
                                        if (isTokenSaved != nil) {
                                            self.isLoggedIn = true
                                        }
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
    
    
    func startCountdown() {
        isTimerFinished = false
        allowedSeconds = 120
        timer?.invalidate()
        timer = nil
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [self] _ in
            if allowedSeconds > 0 {
                allowedSeconds -= 1
            } else {
                timer?.invalidate()
                timer = nil
                isTimerFinished = true
            }
            
            let minutes = Int(allowedSeconds) / 60
            let seconds = Int(allowedSeconds) % 60
            self.displayCountDown = String(format: "%02d:%02d", minutes, seconds)
        }
    }
    
    
}
