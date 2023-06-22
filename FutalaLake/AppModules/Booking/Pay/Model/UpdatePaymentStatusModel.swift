//
//  UpdatePaymentStatusModel.swift
//  FutalaLake
//
//  Created by Abhayjeet Singh on 23/03/23.
//

import Foundation

struct UpdatePaymentStatusModel : Codable {
    let status : Bool?
    let data : [PaymnetStatusData]?
    let error : String?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case data = "data"
        case error = "error"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        data = try values.decodeIfPresent([PaymnetStatusData].self, forKey: .data)
        error = try values.decodeIfPresent(String.self, forKey: .error)
    }

}


struct PaymnetStatusData : Codable {
    let bookingID : String?
    let showDate : String?
    let ticketType : String?
    let seats : [String]?
    let transactionID : String?
    let totalAmount : Int?

    enum CodingKeys: String, CodingKey {

        case bookingID = "bookingID"
        case showDate = "showDate"
        case ticketType = "ticketType"
        case seats = "seats"
        case transactionID = "transactionID"
        case totalAmount = "totalAmount"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        bookingID = try values.decodeIfPresent(String.self, forKey: .bookingID)
        showDate = try values.decodeIfPresent(String.self, forKey: .showDate)
        ticketType = try values.decodeIfPresent(String.self, forKey: .ticketType)
        seats = try values.decodeIfPresent([String].self, forKey: .seats)
        transactionID = try values.decodeIfPresent(String.self, forKey: .transactionID)
        totalAmount = try values.decodeIfPresent(Int.self, forKey: .totalAmount)
    }

}


