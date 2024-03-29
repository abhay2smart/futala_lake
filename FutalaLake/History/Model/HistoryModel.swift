//
//  HistoryModel.swift
//  FutalaLake
//
//  Created by Abhayjeet Singh on 27/03/23.
//

import Foundation
import SwiftUI
struct HistoryModel : Codable {
    //let status : Bool?
    let data : [HistoryData]?
    //let error : String?

    enum CodingKeys: String, CodingKey {

        //case status = "status"
        case data = "data"
        //case error = "error"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        //status = try values.decodeIfPresent(Bool.self, forKey: .status)
        data = try values.decodeIfPresent([HistoryData].self, forKey: .data)
        //error = try values.decodeIfPresent(String.self, forKey: .error)
    }

}


class HistoryData : Codable, ObservableObject {
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
    var isVerifiedSeats : Int?
    var isVerifiedStanding : Int?
    var seats : [HistorySeats]?
    var standing : [HistoryStanding]?
    var encryptedSeatingQRCode : String?
    var encryptedStandingQRCode : String?
    
    
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
        case isVerifiedSeats = "isVerifiedSeats"
        case isVerifiedStanding = "isVerifiedStanding"
        case seats = "seats"
        case standing = "standing"
        case encryptedSeatingQRCode = "encryptedSeatingQRCode"
        case encryptedStandingQRCode = "encryptedStandingQRCode"
    }

    required init(from decoder: Decoder?)  {
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
                isVerifiedSeats = try values.decodeIfPresent(Int.self, forKey: .isVerifiedSeats)
                isVerifiedStanding = try values.decodeIfPresent(Int.self, forKey: .isVerifiedStanding)
                seats = try values.decodeIfPresent([HistorySeats].self, forKey: .seats)
                standing = try values.decodeIfPresent([HistoryStanding].self, forKey: .standing)
                encryptedSeatingQRCode = try values.decodeIfPresent(String.self, forKey: .encryptedSeatingQRCode)
                encryptedStandingQRCode = try values.decodeIfPresent(String.self, forKey: .encryptedStandingQRCode)
            } catch {
                print("someting went wrong Historymode @\(#line)")
            }
        }
        
    }

    
    
    
    func getAdultSeatStr()->String {
        var seatsStr = ""
        var seatsArr = [String]()
        var i = 0
        for seat in seats ?? [] {
            if seat.isAdult == 1 {
                seatsArr.append(seat.seatNumber ?? "")
                if i == ((seats?.count ?? 0) - 1) {
                    seatsStr += seat.seatNumber ?? ""
                } else {
                    seatsStr += (seat.seatNumber ?? "") + ", "
                }
                i += 1
            }
            
        }
        
        return seatsStr == "" ? "N/A" :  seatsStr
    }
    
    
    func getChildSeatStr()->String {
        var seatsStr = ""
        var seatsArr = [String]()
        var i = 0
        for seat in seats ?? [] {
            if seat.isAdult == 0 {
                seatsArr.append(seat.seatNumber ?? "")
                if i == ((seats?.count ?? 0) - 1) {
                    seatsStr += seat.seatNumber ?? ""
                } else {
                    seatsStr += (seat.seatNumber ?? "") + ", "
                }
                i += 1
            }
            
        }
        
        return seatsStr == "" ? "N/A" :  seatsStr
    }
    
    
    
    func getSeatsStr()->String {
        var seatsStr = ""
        var seatsArr = [String]()
        var i = 0
        for seat in seats ?? [] {
            seatsArr.append(seat.seatNumber ?? "")
            if i == ((seats?.count ?? 0) - 1) {
                seatsStr += seat.seatNumber ?? ""
            } else {
                seatsStr += (seat.seatNumber ?? "") + ", "
            }
            i += 1
        }
        
        return seatsStr == "" ? "N/A" :  seatsStr
    }
    
    
    func isSeatingContainerClickable()->Bool {
        
//        let endTime = getFormatteDateObjForTime(time: self.endTime ?? "")
//        let currentTime = getCurrentTime()
        let ticketDate = CommonUtil.getDateFromDateString(date: self.showDate ?? "")
        
        let currentDate = CommonUtil.todayDate()
        
        
        let currentTimeStr = CommonUtil.getCurrentStrTime()
        let diff = CommonUtil.getTimeDiff(currentTimeStr: currentTimeStr ?? "", endTimeStr: self.endTime ?? "")
        
        
        
        if ((isVerifiedSeats == 0 && diff < 1 && currentDate == ticketDate) || (currentDate > ticketDate )){
            return false
        }
        
        if seatingStatus == 4 {
            return false
        }
        
        if isVerifiedSeats == 1 {
            return false
        }
        
        return true
 
    }
    
    func isStandingContainerClickable()->Bool {

        let ticketDate = CommonUtil.getDateFromDateString(date: self.showDate ?? "")
        
        let currentDate = CommonUtil.todayDate()
        
        
        let currentTimeStr = CommonUtil.getCurrentStrTime()
        let diff = CommonUtil.getTimeDiff(currentTimeStr: currentTimeStr ?? "", endTimeStr: self.endTime ?? "")
        
        
        if ((isVerifiedStanding == 0 && diff < 1 && currentDate == ticketDate) || (currentDate > ticketDate )){
            return false
        }
        
        if standingStatus == 4 {
            return false
        }
        
        if isVerifiedStanding == 1 {
            return false
        }
        
        return true
    }
    
            
    func getQRImageForSeating()->Image {

        let ticketDate = CommonUtil.getDateFromDateString(date: self.showDate ?? "")
        
        let currentDate = CommonUtil.todayDate()
        
        
        let currentTimeStr = CommonUtil.getCurrentStrTime()
        let diff = CommonUtil.getTimeDiff(currentTimeStr: currentTimeStr ?? "", endTimeStr: self.endTime ?? "")
        
        
        if ((isVerifiedSeats == 0 && diff < 1 && currentDate == ticketDate) || (currentDate > ticketDate )){
            let img = Image("expired-qr-icon")
            return img
        }
        
        if seatingStatus == 4 {
            let img = Image("cancelled-qr-icon")
            return img
        }
        
        if isVerifiedSeats == 1 {
            let img = Image("verified-qr-icon")
            return img
        }
       
        let qrImg = UIImage(data: CommonUtil.getQRCodeData(dictionary: ["data": self.encryptedSeatingQRCode ?? ""])!)!
        return Image(uiImage: qrImg)
    
        
    }
    
    
    
    
    func getQRImageForStanding()->Image {
        
        let ticketDate = CommonUtil.getDateFromDateString(date: self.showDate ?? "")
        
        let currentDate = CommonUtil.todayDate()
        
        let currentTimeStr = CommonUtil.getCurrentStrTime()
        let diff = CommonUtil.getTimeDiff(currentTimeStr: currentTimeStr ?? "", endTimeStr: self.endTime ?? "")
        
        
        if ((isVerifiedStanding == 0 && diff < 1 && currentDate == ticketDate) || (currentDate > ticketDate )){
            let img = Image("expired-qr-icon")
            return img
        }
        
        if standingStatus == 4 {
            let img = Image("cancelled-qr-icon")
            return img
        }
        
        if isVerifiedStanding == 1 {
            let img = Image("verified-qr-icon")
            return img
        }
        
       
        let qrImg = UIImage(data: CommonUtil.getQRCodeData(dictionary: ["data": self.encryptedStandingQRCode ?? ""])!)!
        
        return Image(uiImage: qrImg)
    
        
    }
    
    
    func isCancelButtonHidden()->Bool {
        
        let ticketDate = CommonUtil.getDateFromDateString(date: self.showDate ?? "")
        
        let currentDate = CommonUtil.todayDate()
        
        let currentTimeStr = CommonUtil.getCurrentStrTime()
        let diff = CommonUtil.getTimeDiff(currentTimeStr: currentTimeStr ?? "", endTimeStr: self.endTime ?? "")
        
        if ((isVerifiedSeats == 0 && diff < 1 && currentDate == ticketDate) || (currentDate > ticketDate)) {
            return true
        }
        
        if ((isVerifiedStanding == 0 && diff < 1 && currentDate == ticketDate) || (currentDate > ticketDate)) {
            return true
        }
        
        if isVerifiedSeats == 1 {
            return true
        }
        
        if(bookingStatus == 4){
            return true
        }
        
        return false
        
    }
    
    
    func getStandingAdultCount()->Int {
        var adultCount = 0
        for standingItem in standing ?? [] {
            if (standingItem.isAdult == 1) {
                adultCount += 1
            }
        }
        
        return adultCount
    }
    
    func getStandingChildCount()->Int {
        var childCount = 0
        for standingItem in standing ?? [] {
            if (standingItem.isAdult == 0) {
                childCount += 1
            }
        }
        
        return childCount
    }
    
    
    func getStandingAdultNonCancelledCount()-> Int {
        var count = 0
        for item in standing ?? [] {
            if item.status == 1 && item.isAdult == 1 {
                count += 1
            }
        }
        return count
    }
    
    func getStandingAdultCancelledCount()->Int {
        var count = 0
        for item in standing ?? [] {
            if item.status == 4 && item.isAdult == 1 {
                count += 1
            }
        }
        return count
    }
    
    
    func getStandingChildNonCancelledCount()-> Int {
        var count = 0
        for item in standing ?? [] {
            if item.status == 1 && item.isAdult == 0 {
                count += 1
            }
        }
        return count
    }
    
    func getStandingChildCancelledCount()->Int {
        var count = 0
        for item in standing ?? [] {
            if item.status == 4 && item.isAdult == 0 {
                count += 1
            }
        }
        return count
    }
    
    

    
}


struct HistoryStanding: Codable {
    var status: Int?
    var isAdult: Int?
    var seatFare: Float?
    var seatBookingID: String?
}

class HistorySeats : Codable, Identifiable, ObservableObject, Hashable  {
    
    func hash(into hasher: inout Hasher) {
            hasher.combine(ObjectIdentifier(self))
        }

    static func ==(lhs: HistorySeats, rhs: HistorySeats) -> Bool {
            return lhs === rhs
        }
//
    
    
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
    
    @Published var color: Color = AppTheme.SeatColor.selected
    
    @Published var isSelected = false
    
    
    func toggleSelected() {
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
    


}


