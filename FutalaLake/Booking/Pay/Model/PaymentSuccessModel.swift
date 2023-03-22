//
//  PaymentModel.swift
//  FutalaLake
//
//  Created by Abhayjeet Singh on 17/03/23.
//

import Foundation

class PaymentModel: Codable {
    var status: Bool?
    var data: [PaymentModelData]?
    var error: String?
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case data = "data"
        case error = "error"
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        data = try values.decodeIfPresent([PaymentModelData].self, forKey: .data)
        error = try values.decodeIfPresent(String.self, forKey: .error)
    }
    
}

class PaymentModelData:Codable {
    var bookingID: String?
    var ticketID: Int?
    
    enum CodingKeys: String, CodingKey {
        case bookingID = "bookingID"
        case ticketID = "ticketID"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        bookingID = try values.decodeIfPresent(String.self, forKey: .bookingID)
        ticketID = try values.decodeIfPresent(Int.self, forKey: .ticketID)
    }
}
