//
//  MasterConfigModel.swift
//  FutalaLake
//
//  Created by Abhayjeet Singh on 19/04/23.
//

import Foundation

struct MasterConfigModel : Codable {
    let status : Bool?
    let data : [MasterConfigData]?
    let error : String?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case data = "data"
        case error = "error"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        data = try values.decodeIfPresent([MasterConfigData].self, forKey: .data)
        error = try values.decodeIfPresent(String.self, forKey: .error)
    }

}

struct MasterConfigData : Codable {
    let type : String?
    let options : [Options]?

    enum CodingKeys: String, CodingKey {

        case type = "type"
        case options = "options"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        options = try values.decodeIfPresent([Options].self, forKey: .options)
    }

}

struct Options : Codable {
    let value : String?
    let code : Int?

    enum CodingKeys: String, CodingKey {

        case value = "value"
        case code = "code"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        value = try values.decodeIfPresent(String.self, forKey: .value)
        code = try values.decodeIfPresent(Int.self, forKey: .code)
    }

}



