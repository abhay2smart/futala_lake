//
//  PaymentModel.swift
//  FutalaLake
//
//  Created by Abhayjeet Singh on 17/03/23.
//

import Foundation

class CheckOutModel: Codable {
    //var status: Bool?
    var data: [CheckOutModelData]?
    //var error: String?
    
    enum CodingKeys: String, CodingKey {
        //case status = "status"
        case data = "data"
        //case error = "error"
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        //status = try values.decodeIfPresent(Bool.self, forKey: .status)
        data = try values.decodeIfPresent([CheckOutModelData].self, forKey: .data)
        //error = try values.decodeIfPresent(String.self, forKey: .error)
    }
    
}

class CheckOutModelData:Codable {
    var bookingID: String?
    var ticketID: String?
    var payurl: String?
    
    
    enum CodingKeys: String, CodingKey {
        case bookingID = "bookingID"
        case ticketID = "ticketID"
        case payurl = "payurl"
      
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        bookingID = try values.decodeIfPresent(String.self, forKey: .bookingID)
        ticketID = try values.decodeIfPresent(String.self, forKey: .ticketID)
        payurl = try values.decodeIfPresent(String.self, forKey: .payurl)
    }
}
