//
//  GetTokenModel.swift
//  FutalaLake
//
//  Created by Abhayjeet Singh on 06/03/23.
//

import Foundation

import Foundation
struct GetTokenModel : Codable {
    var status : Bool?
    var data : [TokenData]?
    var error : String?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case data = "data"
        case error = "error"
    }

    init(from decoder: Decoder?  = nil)  {
        if let decoder = decoder {
            do {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                status = try values.decodeIfPresent(Bool.self, forKey: .status)
                data = try values.decodeIfPresent([TokenData].self, forKey: .data)
                error = try values.decodeIfPresent(String.self, forKey: .error)
            } catch {
                print(error)
            }
            
        }
        
    }

}

struct TokenData : Codable {
    let id : String?
    let mobile : String?
    let result : String?
    let token : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case mobile = "mobile"
        case result = "result"
        case token = "token"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        mobile = try values.decodeIfPresent(String.self, forKey: .mobile)
        result = try values.decodeIfPresent(String.self, forKey: .result)
        token = try values.decodeIfPresent(String.self, forKey: .token)
    }

}


