//
//  ProfileViewModel.swift
//  FutalaLake
//
//  Created by Abhayjeet Singh on 13/04/23.
//

import SwiftUI
class ProfileViewModel: ObservableObject {
    @Published var message = ""
    @Published var isPresented = false
    @Published var name = ""
    @Published var mobile = ""
    @Published var gender: String = "Male"
    @Published var selectedBirthDate:Date = Date()
    @Published var selectedBirthDateStr = ""
    
    @Published var address = ""
    
    @Published var isLoading = false
    
    @Published var profileData = ProfileModel.ProfileData(from: nil)
    
    func validate()->Bool {
        if name == "" {
            gender = "Male"
            message = "Please enter name"
            isPresented = true
            return false
        }
        
        if selectedBirthDateStr == "" {
            message = "Please enter DOB"
            isPresented = true
            return false
        }
        
        if address == "" {
            message = "Please enter Address"
            isPresented = true
            return false
        }
        
        isPresented = false
        
        return true
    }
    
    func getProfileDetails() {
        DispatchQueue.main.async {
            self.isLoading = true
        }
        
        let url = Constants.baseUrl + Constants.API.getProfileDetails
                APIService.shared.makeApiTypeRequest2(url: url, param: nil, methodType: .get, expecting: GlobResponseModel.self) { resultStatus, error, data  in
                    
                    
                    DispatchQueue.main.async {
                        self.isLoading = false
                    }
                    
                    if !resultStatus {
                        print("something went wrong:: \(self) \(#line)")
                        return
                    }
                    
                    
                    guard let data = data else {
                        return
                    }
                    
                    
                    APIService.shared.parseModel(data: data, expecting: ProfileModel.self) { result, data in

                        switch result {
                            case .success(let respData):
                            if let data = respData.data?.first {
                                DispatchQueue.main.async {
                                    self.profileData = data
                                    self.setVars(data: data)
                                }
                                
                            }
                            case .failure(let error):
                                print("Something went wrong  \(self) \(#line)")
                        }
                    }
                    
                }

    }
    
    private func setVars(data: ProfileModel.ProfileData) {
        self.name = data.name ?? ""
        self.mobile = data.mobileNumber ?? ""
        selectedBirthDateStr =  CommonUtil.showDate(date: data.dob ?? "") 
        self.name = data.name ?? ""
        
        if (data.gender ?? 0) == 2 {
            gender = "Female"
        } else {
            gender = "Male"
        }
        self.address = data.address ?? ""
        
    }
    
    func updateProfile() {
        DispatchQueue.main.async {
            self.isLoading = true
        }
        
        let url = Constants.baseUrl + Constants.API.updateProfile
        var params = [String: Any]()
        
        params["name"] = name
        
        if gender == "Male" {
            params["gender"] = 1
        } else {
            params["gender"] = 2
        }
        
        params["mobileNumber"] = mobile
        

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let myDate = dateFormatter.date(from: selectedBirthDateStr)!

        dateFormatter.dateFormat = "yyyy-MM-dd"
        let somedateString = dateFormatter.string(from: myDate)

        
        
        params["dob"] = somedateString
        params["status"] = profileData.status
        params["otp"] = profileData.otp
        params["mobileUserId"] = profileData.mobileUserId
        params["address"] = address
        
        
                
        APIService.shared.makeApiTypeRequest2(url: url, param: params, methodType: .put, expecting: GlobResponseModel.self) { resultStatus, error, data  in
            
            DispatchQueue.main.async {
                self.isLoading = false
            }
            
                    
                    
                    DispatchQueue.main.async {
                        self.isLoading = false
                    }
                    
                    if !resultStatus {
                        self.message = "Something went wrong"
                        self.isPresented = true
                        print("something went wrong:: SeatLayoutViewModel \(#line)")
                        return
                    }
            
            
            guard let data = data else {
                return
            }
            
            
            APIService.shared.parseModel(data: data, expecting: GlobResponseModel.self) { result, data in
            
                switch result {
                    case .success(let respData):
                    DispatchQueue.main.async {
                        if respData.status == false {
                            self.message = respData.error ?? ""
                            self.isPresented = true
                            
                        } else {
                            self.message = "Profile updated successfully."
                            self.isPresented = true
                        }
                    }
                    
                    case .failure(let error):
                        print("Something went wrong DateTimeSelectionViewModel@\(#line)")
                }
            }
                
        }

    }
}
