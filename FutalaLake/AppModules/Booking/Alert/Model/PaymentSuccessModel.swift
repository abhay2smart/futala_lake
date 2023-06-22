//
//  PaymentSuccessModel.swift
//  FutalaLake
//
//  Created by Abhayjeet Singh on 12/05/23.
//

import Foundation

class PaymentSuccessModel : Codable {
    let status : Bool?
    let data : [PaymentSuccessData]?
    let error : String?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case data = "data"
        case error = "error"
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        data = try values.decodeIfPresent([PaymentSuccessData].self, forKey: .data)
        error = try values.decodeIfPresent(String.self, forKey: .error)
    }
}

class PaymentSuccessData: Codable {
    var bookingID: String?
    var showDate: String?
    var status: Int?
    var ticketType: String?
    var totalAmount: Double?
    var transactionID: String?
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        bookingID = try values.decodeIfPresent(String.self, forKey: .bookingID)
        showDate = try values.decodeIfPresent(String.self, forKey: .showDate)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        ticketType = try values.decodeIfPresent(String.self, forKey: .ticketType)
        totalAmount = try values.decodeIfPresent(Double.self, forKey: .totalAmount)
        transactionID = try values.decodeIfPresent(String.self, forKey: .transactionID)
        
        
    }
    
    
    
}
