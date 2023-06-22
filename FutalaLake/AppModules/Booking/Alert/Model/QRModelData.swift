//
//  QRModelData.swift
//  FutalaLake
//
//  Created by Abhayjeet Singh on 22/03/23.
//

import Foundation


class QRModel : Codable {
    let status : Bool?
    let data : [QRData]?
    let error : String?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case data = "data"
        case error = "error"
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        data = try values.decodeIfPresent([QRData].self, forKey: .data)
        error = try values.decodeIfPresent(String.self, forKey: .error)
    }

}

class QRData : Codable, ObservableObject {
    var bookingID : String?
    var showDate : String?
    var ticketID : String?
    var startTime : String?
    var endTime : String?
    var mobileNumber : String?
    var paymentTransactionID : String?
    var totalFare : Int?
    var seatData : [QRSeatData]?
    var qrStandingData : [QRStandingData]?

    enum CodingKeys: String, CodingKey {

        case bookingID = "bookingID"
        case showDate = "showDate"
        case ticketID = "ticketID"
        case startTime = "startTime"
        case endTime = "endTime"
        case mobileNumber = "mobileNumber"
        case paymentTransactionID = "paymentTransactionID"
        case totalFare = "totalFare"
        case seatData = "seatData"
        case qrStandingData = "standingData"
    }

    init(from decoder: Decoder? = nil)  {
        if let decoder = decoder {
            do {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                bookingID = try values.decodeIfPresent(String.self, forKey: .bookingID)
                showDate = try values.decodeIfPresent(String.self, forKey: .showDate)
                ticketID = try values.decodeIfPresent(String.self, forKey: .ticketID)
                startTime = try values.decodeIfPresent(String.self, forKey: .startTime)
                endTime = try values.decodeIfPresent(String.self, forKey: .endTime)
                mobileNumber = try values.decodeIfPresent(String.self, forKey: .mobileNumber)
                paymentTransactionID = try values.decodeIfPresent(String.self, forKey: .paymentTransactionID)
                totalFare = try values.decodeIfPresent(Int.self, forKey: .totalFare)
                seatData = try values.decodeIfPresent([QRSeatData].self, forKey: .seatData)
                qrStandingData = try values.decodeIfPresent([QRStandingData].self, forKey: .qrStandingData)
            } catch {
                print("erroi7777")
            }
        }
        
    }

}


struct QRSeatData : Codable {
    let encryptedSeatingQRCode : String?
    let seats : [String]?
    let noOfSeats : Int?
    let ticketType : String?
    let gateNumbers : String?
    let seatTotalFare : Int?
    let groupNo: Int?
    let gateNo: String?

    enum CodingKeys: String, CodingKey {

        case encryptedSeatingQRCode = "encryptedQRString"
        case seats = "seatNo"
        case noOfSeats = "noOfSeats"
        case ticketType = "ticketType"
        case gateNumbers = "gateNumbers"
        case seatTotalFare = "seatTotalFare"
        case groupNo = "groupNo"
        case gateNo = "gateNo"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        encryptedSeatingQRCode = try values.decodeIfPresent(String.self, forKey: .encryptedSeatingQRCode)
        seats = try values.decodeIfPresent([String].self, forKey: .seats)
        noOfSeats = try values.decodeIfPresent(Int.self, forKey: .noOfSeats)
        ticketType = try values.decodeIfPresent(String.self, forKey: .ticketType)
        gateNumbers = try values.decodeIfPresent(String.self, forKey: .gateNumbers)
        seatTotalFare = try values.decodeIfPresent(Int.self, forKey: .seatTotalFare)
        groupNo = try values.decodeIfPresent(Int.self, forKey: .groupNo)
        gateNo = try values.decodeIfPresent(String.self, forKey: .gateNo)
    }

}




struct QRStandingData : Codable {
    let standingCount : Int?
    let standingTotalFare : Int?
    let encryptedStandingQRCode : String?

    enum CodingKeys: String, CodingKey {

        case standingCount = "standingCount"
        case standingTotalFare = "standingTotalFare"
        case encryptedStandingQRCode = "encryptedStandingQRCode"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        standingCount = try values.decodeIfPresent(Int.self, forKey: .standingCount)
        standingTotalFare = try values.decodeIfPresent(Int.self, forKey: .standingTotalFare)
        encryptedStandingQRCode = try values.decodeIfPresent(String.self, forKey: .encryptedStandingQRCode)
    }

}



