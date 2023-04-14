//
//  ProfileModel.swift
//  FutalaLake
//
//  Created by Abhayjeet Singh on 13/04/23.
//

import Foundation
import SwiftUI

class ProfileModel: Codable {
    let data : [ProfileData]?
    class ProfileData: Codable {
        var name: String?
        var dob: String?
        var gender: Int?
        var email: String?
        var mobileNumber: String?
        var mobileUserId: String?
        var status: Int?
        var otp: Int?
        var address: String?
        
    //    enum CodingKeys: String, CodingKey {
    //        case name = "name"
    //    }
        
        required init(from decoder: Decoder?)  {
            if let decoder = decoder {
                do {
                    let values = try decoder.container(keyedBy: CodingKeys.self)
                    name = try values.decodeIfPresent(String.self, forKey: .name)
                    dob = try values.decodeIfPresent(String.self, forKey: .dob)
                    gender = try values.decodeIfPresent(Int.self, forKey: .gender)
                    email = try values.decodeIfPresent(String.self, forKey: .email)
                    mobileNumber = try values.decodeIfPresent(String.self, forKey: .mobileNumber)
                    mobileUserId = try values.decodeIfPresent(String.self, forKey: .mobileUserId)
                    status = try values.decodeIfPresent(Int.self, forKey: .status)
                    otp = try values.decodeIfPresent(Int.self, forKey: .otp)
                    address = try values.decodeIfPresent(String.self, forKey: .address)
                } catch {
                    
                }
                
            }
        }
    }

    
}


