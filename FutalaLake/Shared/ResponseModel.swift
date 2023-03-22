//
//  SuccessModel.swift
//  FutalaLake
//
//  Created by Abhayjeet Singh on 17/03/23.
//

import Foundation
class ResponseModel: Codable {
    var status: Bool?
    var error: String?
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case error = "error"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        error = try values.decodeIfPresent(String.self, forKey: .error)
    }
    
}
