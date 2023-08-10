//
//  HistoryDetailsModel.swift
//  FutalaLake
//
//  Created by Abhayjeet Singh on 08/04/23.
//

import Foundation

import SwiftUI

struct HistoryDetailsModel : Codable {
    var status : Bool?
    var data : [HistoryDetailData]?
    var error : String?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case data = "data"
        case error = "error"
    }

    init(from decoder: Decoder? = nil)  {
        do {
            if let decoder = decoder {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                status = try values.decodeIfPresent(Bool.self, forKey: .status)
                data = try values.decodeIfPresent([HistoryDetailData].self, forKey: .data)
                error = try values.decodeIfPresent(String.self, forKey: .error)
            }
            
        } catch {
            
        }
        
    }

}


struct HistoryDetailData : Codable {
    var bookingID : String?
    var showDate : String?
    var bookingDate : String?
    var ticketID : String?
    var showTimeID : String?
    var startTime : String?
    var endTime : String?
    var bookingStatus : Int?
    var seatingStatus : Int?
    var standingStatus : Int?
    var isVerifiedStanding : Int?
    var standing : [Standing]?
    var encryptedStandingQRCode : String?
    var ticketData : [TicketData]?

    enum CodingKeys: String, CodingKey {

        case bookingID = "bookingID"
        case showDate = "showDate"
        case bookingDate = "bookingDate"
        case ticketID = "ticketID"
        case showTimeID = "showTimeID"
        case startTime = "startTime"
        case endTime = "endTime"
        case bookingStatus = "bookingStatus"
        case seatingStatus = "seatingStatus"
        case standingStatus = "standingStatus"
        case isVerifiedStanding = "isVerifiedStanding"
        case standing = "standing"
        case encryptedStandingQRCode = "encryptedStandingQRCode"
        case ticketData = "ticketData"
    }

    init(from decoder: Decoder? = nil)  {
        if let decoder = decoder {
            do {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                bookingID = try values.decodeIfPresent(String.self, forKey: .bookingID)
                showDate = try values.decodeIfPresent(String.self, forKey: .showDate)
                bookingDate = try values.decodeIfPresent(String.self, forKey: .bookingDate)
                ticketID = try values.decodeIfPresent(String.self, forKey: .ticketID)
                showTimeID = try values.decodeIfPresent(String.self, forKey: .showTimeID)
                startTime = try values.decodeIfPresent(String.self, forKey: .startTime)
                endTime = try values.decodeIfPresent(String.self, forKey: .endTime)
                bookingStatus = try values.decodeIfPresent(Int.self, forKey: .bookingStatus)
                seatingStatus = try values.decodeIfPresent(Int.self, forKey: .seatingStatus)
                standingStatus = try values.decodeIfPresent(Int.self, forKey: .standingStatus)
                isVerifiedStanding = try values.decodeIfPresent(Int.self, forKey: .isVerifiedStanding)
                standing = try values.decodeIfPresent([Standing].self, forKey: .standing)
                encryptedStandingQRCode = try values.decodeIfPresent(String.self, forKey: .encryptedStandingQRCode)
                ticketData = try values.decodeIfPresent([TicketData].self, forKey: .ticketData)
            } catch {
                
            }
        }
        
    }
    
    var isCancelButtonVisible : Bool {
        
        if(bookingStatus == 4){
            return false
        }
        
        let ticketDate = CommonUtil.getDateFromDateString(date: self.showDate ?? "")
        let currentDate = CommonUtil.todayDate()
        
        let currentTimeStr = CommonUtil.getCurrentStrTime()
        let diff = CommonUtil.getTimeDiff(currentTimeStr: currentTimeStr ?? "", endTimeStr: self.startTime ?? "")
        
        
        if ((ticketDate == currentDate) && (diff <= 1800) ) {
            return false
        }
        
        let diffWIthEndTime = CommonUtil.getTimeDiff(currentTimeStr: currentTimeStr ?? "", endTimeStr: self.endTime ?? "")
        
        
        
        if (((isVerifiedStanding ?? 0) == 0) && diffWIthEndTime < 0 && currentDate == ticketDate || currentDate > ticketDate){
            return false
        }
        
        
//        if(isVerifiedStanding == 1){
//            return false
//        }
        
        
        
        
        
        
        var seatingIsVerifiedCount = 0
        
        for item in ticketData ?? [] {
            if item.isVerified == 1 {
                seatingIsVerifiedCount += 1
            }
        }
        
        // booking status 4 means all the tickets has been cancelled (seating & standing both)
        if seatingIsVerifiedCount == (ticketData?.count ?? 0) && isVerifiedStanding == 1 {
            return false
        }
        
        
        
        if(bookingStatus == 3){
            //Toast.makeText(requireActivity(),"Payment Failed",Toast.LENGTH_SHORT).show()
        }
        
        return true
    }
    
    
    
    
    
    
    func getQRImageForStanding()->Image {
        
        let ticketDate = CommonUtil.getDateFromDateString(date: self.showDate ?? "")
        
        let currentDate = CommonUtil.todayDate()
        
        let currentTimeStr = CommonUtil.getCurrentStrTime()
        let diff = CommonUtil.getTimeDiff(currentTimeStr: currentTimeStr ?? "", endTimeStr: self.endTime ?? "")
        
        if standingStatus == 4 {
            let img = Image("cancelled-qr-icon")
            return img
        }
        
        if ((isVerifiedStanding == 0 && diff < 1 && currentDate == ticketDate) || (currentDate > ticketDate )){
            let img = Image("expired-qr-icon")
            return img
        }
        
        
        
        if isVerifiedStanding == 1 {
            let img = Image("verified-qr-icon")
            return img
        }
        
        
        let qrImg = UIImage(data: CommonUtil.getQRCodeData(dictionary: ["data": self.encryptedStandingQRCode ?? ""])!)!
        return Image(uiImage: qrImg)
    }
    
    var standingChildCount: Int {
        var childCount = 0
        for item in standing ?? [] {
            if item.isAdult == 0 && item.status == 1 {
                childCount += 1
            }
        }
        return childCount
    }
    
    
    var standingCancelledChildCount: Int {
        var count = 0
        for item in standing ?? [] {
            if item.isAdult == 0 && item.status == 4 {
                count += 1
            }
        }
        return count
    }
    
    var standingAdultCount: Int {
        var adultCount = 0
        for item in standing ?? [] {
            if item.isAdult == 1 && item.status == 1 {
                adultCount += 1
            }
        }
        return adultCount
    }
    
    
    var standingCancelledAdultCount: Int {
        var count = 0
        for item in standing ?? [] {
            if item.isAdult == 1 && item.status == 4 {
                count += 1
            }
        }
        return count
    }
    
    

}

struct Standing: Codable {
    var status = 1
    var isAdult = 1
    var seatFare = 0
    var seatBookingID = ""
    var gateNumber = ""
    
    init(from decoder: Decoder? = nil)  {
        if let decoder = decoder {
            do {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                status = try values.decodeIfPresent(Int.self, forKey: .status) ?? 0
                isAdult = try values.decodeIfPresent(Int.self, forKey: .isAdult) ?? 0
                seatFare = try values.decodeIfPresent(Int.self, forKey: .seatFare) ?? 0
                seatBookingID = try values.decodeIfPresent(String.self, forKey: .seatBookingID) ?? ""
                gateNumber = try values.decodeIfPresent(String.self, forKey: .gateNumber) ?? ""
                
            } catch {
                
            }
        }
    }
    
}



class SeatNo : Codable, ObservableObject {
    let id = UUID()
    let status : Int?
    let colorID : Int?
    let isAdult : Int?
    let seatFare : Int?
    let seatType : String?
    let colorName : String?
    let seatNumber : String?
    let seatLayoutID : String?
    let seatBookingID : String?
    var isSelectable = true
    @Published var isSelected = false
    @Published var color: Color = AppTheme.SeatColor.selected

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case colorID = "colorID"
        case isAdult = "isAdult"
        case seatFare = "seatFare"
        case seatType = "seatType"
        case colorName = "colorName"
        case seatNumber = "seatNumber"
        case seatLayoutID = "seatLayoutID"
        case seatBookingID = "seatBookingID"
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        colorID = try values.decodeIfPresent(Int.self, forKey: .colorID)
        isAdult = try values.decodeIfPresent(Int.self, forKey: .isAdult)
        seatFare = try values.decodeIfPresent(Int.self, forKey: .seatFare)
        seatType = try values.decodeIfPresent(String.self, forKey: .seatType)
        colorName = try values.decodeIfPresent(String.self, forKey: .colorName)
        seatNumber = try values.decodeIfPresent(String.self, forKey: .seatNumber)
        seatLayoutID = try values.decodeIfPresent(String.self, forKey: .seatLayoutID)
        seatBookingID = try values.decodeIfPresent(String.self, forKey: .seatBookingID)
        
        print("abhay-----> s: \(seatNumber) status: \(status)")
       
        // status 4 means cancelled
        if status == 4 {
            isSelectable = false
        }
        
        
        
        if isSelectable {
            for color in AppTheme.SeatColor.colorList {
                if color.key.lowercased() == colorName?.lowercased() {
                    self.color = color.color
                }
            }
        } else {
            self.color = AppTheme.SeatColor.booked
        }
        
        
    }
    
    func toggleSelectedStatus() {
        if !isSelectable {
            return
        }
        isSelected = !isSelected
        if isSelected {
            color = AppTheme.SeatColor.selected
        } else {
            for color in AppTheme.SeatColor.colorList {
                if color.key.lowercased() == colorName?.lowercased() {
                    self.color = color.color
                }
            }
        }
    }

}


class TicketData : Codable, Hashable {
    
    func hash(into hasher: inout Hasher) {
            hasher.combine(ObjectIdentifier(self))
        }

    static func ==(lhs: TicketData, rhs: TicketData) -> Bool {
            return lhs === rhs
        }
    
    let groupNo : Int?
    let encryptedQRString : String?
    let seatNo : [SeatNo]?
    let gateNo : String?
    let noOfSeats : Int?
    let ticketType : String?
    let isVerified : Int?
    let groupSeatingStatus : Int?

    enum CodingKeys: String, CodingKey {

        case groupNo = "groupNo"
        case encryptedQRString = "encryptedQRString"
        case seatNo = "seatNo"
        case gateNo = "gateNo"
        case noOfSeats = "noOfSeats"
        case ticketType = "ticketType"
        case isVerified = "isVerified"
        case groupSeatingStatus = "groupSeatingStatus"
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        groupNo = try values.decodeIfPresent(Int.self, forKey: .groupNo)
        encryptedQRString = try values.decodeIfPresent(String.self, forKey: .encryptedQRString)
        seatNo = try values.decodeIfPresent([SeatNo].self, forKey: .seatNo)
        gateNo = try values.decodeIfPresent(String.self, forKey: .gateNo)
        noOfSeats = try values.decodeIfPresent(Int.self, forKey: .noOfSeats)
        ticketType = try values.decodeIfPresent(String.self, forKey: .ticketType)
        isVerified = try values.decodeIfPresent(Int.self, forKey: .isVerified)
        groupSeatingStatus = try values.decodeIfPresent(Int.self, forKey: .groupSeatingStatus)
    }
    
    func getQRImageForSeating(data: HistoryDetailData?)->Image {
        
        if let data = data {
            let ticketDate = CommonUtil.getDateFromDateString(date: data.showDate ?? "")
            
            let currentDate = CommonUtil.todayDate()
            
            
            let currentTimeStr = CommonUtil.getCurrentStrTime()
            let diff = CommonUtil.getTimeDiff(currentTimeStr: currentTimeStr ?? "", endTimeStr: data.endTime ?? "")
            
            var cancelledSeatCount = 0
            for item in seatNo ?? [] {
                if item.status == 4 {
                    cancelledSeatCount += 1
                }
            }
            
            if cancelledSeatCount == seatNo?.count ?? 0 {
                let img = Image("cancelled-qr-icon")
                return img
            }
            
//            if data.seatingStatus == 4 {
//                let img = Image("cancelled-qr-icon")
//                return img
//            }
            
            if ((isVerified == 0 && diff < 1 && currentDate == ticketDate) || (currentDate > ticketDate )){
                let img = Image("expired-qr-icon")
                return img
            }
            
            

            if isVerified == 1 {
                let img = Image("verified-qr-icon")
                return img
            }
            
            
        }
        
        let qrImg = UIImage(data: CommonUtil.getQRCodeData(dictionary: ["data": self.encryptedQRString ?? ""])!)!
        return Image(uiImage: qrImg)
    }

    
    var isAdultSeats: Bool  {
        for item in seatNo ?? [] {
            if item.isAdult == 1 {
                return true
            }
        }
        return false
    }
    
    var isChildSeats: Bool  {
        for item in seatNo ?? [] {
            if item.isAdult == 0 {
                return true
            }
        }
        return false
    }

}

