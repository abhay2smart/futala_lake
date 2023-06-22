//
//  LoginResponseModel.swift
//  FutalaLake
//
//  Created by Abhayjeet Singh on 02/03/23.
//

import Foundation

struct LoginResponseModel : Codable {
    var status : Bool?
    var data : [ResponseData]?
    var error : String?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case data = "data"
        case error = "error"
    }

    init(from decoder: Decoder? = nil)  {
        do {
            if let decoder = decoder {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                status = try values.decodeIfPresent(Bool.self, forKey: .status)
                data = try values.decodeIfPresent([ResponseData].self, forKey: .data)
                error = try values.decodeIfPresent(String.self, forKey: .error)
            }
            
        } catch {
            print(error)
        }
        
    }

}

struct ResponseData : Codable {
    let mobile : String?
    let otp : Int?

    enum CodingKeys: String, CodingKey {

        case mobile = "mobile"
        case otp = "otp"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        mobile = try values.decodeIfPresent(String.self, forKey: .mobile)
        otp = try values.decodeIfPresent(Int.self, forKey: .otp)
    }

}





