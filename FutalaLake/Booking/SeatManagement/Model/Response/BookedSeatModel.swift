//
//  BookedSeats.swift
//  FutalaLake
//
//  Created by Abhayjeet Singh on 14/03/23.
//

import Foundation

//class BookedSeats:ObservableObject {
//
//}





struct BookedSeats : Codable {
    let status : Bool?
    let data : [BookedSeatData]?
    let error : String?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case data = "data"
        case error = "error"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        data = try values.decodeIfPresent([BookedSeatData].self, forKey: .data)
        error = try values.decodeIfPresent(String.self, forKey: .error)
    }

}

struct BookSeats : Codable, Identifiable {
    let id = UUID()
    let seatTypeID : Int?
    let seatLayoutID : String?
    let seatType : String?
    //let fare : Float?
    let seatNumber : String?

    enum CodingKeys: String, CodingKey {

        case seatTypeID = "seatTypeID"
        case seatLayoutID = "seatLayoutID"
        case seatType = "seatType"
        //case fare = "fare"
        case seatNumber = "seatNumber"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        seatTypeID = try values.decodeIfPresent(Int.self, forKey: .seatTypeID)
        seatLayoutID = try values.decodeIfPresent(String.self, forKey: .seatLayoutID)
        seatType = try values.decodeIfPresent(String.self, forKey: .seatType)
        //fare = try values.decodeIfPresent(Float.self, forKey: .fare)
        seatNumber = try values.decodeIfPresent(String.self, forKey: .seatNumber)
    }

}



struct BookStanding : Codable {
    let remainingQuantity : Int?
    let totalQuantity : Int?

    enum CodingKeys: String, CodingKey {

        case remainingQuantity = "remainingQuantity"
        case totalQuantity = "totalQuantity"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        remainingQuantity = try values.decodeIfPresent(Int.self, forKey: .remainingQuantity)
        totalQuantity = try values.decodeIfPresent(Int.self, forKey: .totalQuantity)
    }

}


class BookedSeatData : Codable {
    let bookSeats : [BookSeats]?
    let bookStanding : BookStanding?
    let seatFare : [SeatFare]?
    let standingFare : StandingFare?

    enum CodingKeys: String, CodingKey {

        case bookSeats = "bookSeats"
        case bookStanding = "bookStanding"
        case seatFare = "seatFare"
        case standingFare = "standingFare"
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        bookSeats = try values.decodeIfPresent([BookSeats].self, forKey: .bookSeats)
        bookStanding = try values.decodeIfPresent(BookStanding.self, forKey: .bookStanding)
        seatFare = try values.decodeIfPresent([SeatFare].self, forKey: .seatFare)
        standingFare = try values.decodeIfPresent(StandingFare.self, forKey: .standingFare)
    }

}


struct SeatFare : Codable {
    let seatTypeID : Int?
    let seatType : String?
    let fare : Float?

    enum CodingKeys: String, CodingKey {

        case seatTypeID = "seatTypeID"
        case seatType = "seatType"
        case fare = "fare"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        seatTypeID = try values.decodeIfPresent(Int.self, forKey: .seatTypeID)
        seatType = try values.decodeIfPresent(String.self, forKey: .seatType)
        fare = try values.decodeIfPresent(Float.self, forKey: .fare)
    }

}


struct StandingFare : Codable {
    let fare : Float?

    enum CodingKeys: String, CodingKey {
        case fare = "fare"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        fare = try values.decodeIfPresent(Float.self, forKey: .fare)
    }

}
