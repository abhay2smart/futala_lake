//
//  SeatLayoutModel.swift
//  FutalaLake
//
//  Created by Abhayjeet Singh on 10/03/23.
//

import Foundation

struct SeatLayoutModel : Codable {
    let status : Bool?
    let data : [SeatData]?
    let error : String?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case data = "data"
        case error = "error"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        data = try values.decodeIfPresent([SeatData].self, forKey: .data)
        error = try values.decodeIfPresent(String.self, forKey: .error)
    }

}

struct SeatData : Codable {
    let seats : [Seats]?
    let totalQuantity : String?

    enum CodingKeys: String, CodingKey {

        case seats = "seats"
        case totalQuantity = "totalQuantity"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        seats = try values.decodeIfPresent([Seats].self, forKey: .seats)
        totalQuantity = try values.decodeIfPresent(String.self, forKey: .totalQuantity)
    }

}

struct Seats : Codable {
    let id = UUID()
    let seatLayoutID : String?
    let seatNumber : String?
    let gateNumberID : Int?
    let gateNumber : String?
    let seatTypeID : Int?
    let seatType : String?
    let status : Int?

    enum CodingKeys: String, CodingKey {

        case seatLayoutID = "seatLayoutID"
        case seatNumber = "seatNumber"
        case gateNumberID = "gateNumberID"
        case gateNumber = "gateNumber"
        case seatTypeID = "seatTypeID"
        case seatType = "seatType"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        seatLayoutID = try values.decodeIfPresent(String.self, forKey: .seatLayoutID)
        seatNumber = try values.decodeIfPresent(String.self, forKey: .seatNumber)
        gateNumberID = try values.decodeIfPresent(Int.self, forKey: .gateNumberID)
        gateNumber = try values.decodeIfPresent(String.self, forKey: .gateNumber)
        seatTypeID = try values.decodeIfPresent(Int.self, forKey: .seatTypeID)
        seatType = try values.decodeIfPresent(String.self, forKey: .seatType)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
    }

}

