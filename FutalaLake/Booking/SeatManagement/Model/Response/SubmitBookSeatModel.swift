//
//  SubmitBookSeatModel.swift
//  FutalaLake
//
//  Created by Abhayjeet Singh on 16/03/23.
//

import Foundation

import Foundation
struct SubmitBookSeatModel : Codable {
    var status : Bool?
    var data : [SubmitBookSeatModelData]?
    var error : String?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case data = "data"
        case error = "error"
    }

    init(from decoder: Decoder? = nil)  {
        if let decoder = decoder {
            do {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                status = try values.decodeIfPresent(Bool.self, forKey: .status)
                data = try values.decodeIfPresent([SubmitBookSeatModelData].self, forKey: .data)
                error = try values.decodeIfPresent(String.self, forKey: .error)
            } catch {
                print(error.localizedDescription)
            }
        }
        
    }

}


struct SubmitBookSeatModelData : Codable {
    var showDate : String?
    var showStartTime : String?
    var showEndTime : String?
    var ticketType : String?
    var totalSeats : Int?
    var seatNumber : String?
    var quantityStading : Int?
    var ticketFees : Int?
    var bookingFees : Int?
    var tax : Int?
    var total : Int?

    enum CodingKeys: String, CodingKey {

        case showDate = "showDate"
        case showStartTime = "showStartTime"
        case showEndTime = "showEndTime"
        case ticketType = "ticketType"
        case totalSeats = "totalSeats"
        case seatNumber = "seatNumber"
        case quantityStading = "quantityStading"
        case ticketFees = "ticketFees"
        case bookingFees = "bookingFees"
        case tax = "tax"
        case total = "total"
    }


    init(from decoder: Decoder?)  {
        if let decoder = decoder {
            do {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                showDate = try values.decodeIfPresent(String.self, forKey: .showDate)
                showStartTime = try values.decodeIfPresent(String.self, forKey: .showStartTime)
                showEndTime = try values.decodeIfPresent(String.self, forKey: .showEndTime)
                ticketType = try values.decodeIfPresent(String.self, forKey: .ticketType)
                totalSeats = try values.decodeIfPresent(Int.self, forKey: .totalSeats)
                seatNumber = try values.decodeIfPresent(String.self, forKey: .seatNumber)
                quantityStading = try values.decodeIfPresent(Int.self, forKey: .quantityStading)
                ticketFees = try values.decodeIfPresent(Int.self, forKey: .ticketFees)
                bookingFees = try values.decodeIfPresent(Int.self, forKey: .bookingFees)
                tax = try values.decodeIfPresent(Int.self, forKey: .tax)
                total = try values.decodeIfPresent(Int.self, forKey: .total)
            } catch {
                print(error.localizedDescription)
            }
            
            
        }
    }

}
