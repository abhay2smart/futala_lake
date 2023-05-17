//
//  SeatLayoutModel.swift
//  FutalaLake
//
//  Created by Abhayjeet Singh on 10/03/23.
//

import Foundation
import SwiftUI
import Combine


class SeatLayoutModel : Codable, ObservableObject, Identifiable {
    let status : Bool?
    let data : [SeatData]?
    let error : String?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case data = "data"
        case error = "error"
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        data = try values.decodeIfPresent([SeatData].self, forKey: .data)
        error = try values.decodeIfPresent(String.self, forKey: .error)
    }

}

class SeatData : Codable, ObservableObject, Identifiable {
    let seats : [Seats]?
    let totalQuantity : String?

    enum CodingKeys: String, CodingKey {

        case seats = "seats"
        case totalQuantity = "totalQuantity"
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        seats = try values.decodeIfPresent([Seats].self, forKey: .seats)
        totalQuantity = try values.decodeIfPresent(String.self, forKey: .totalQuantity)
    }

}



class Seats : ObservableObject, Codable, Identifiable {
    let id = UUID()
    let seatLayoutID : String?
    var seatNumber : String?
    let gateNumberID : Int?
    let gateNumber : String?
    let seatTypeID : Int?
    let seatType : String?
    let status : Int?
    let colorName:String?
    let section: String?
    
    @Published var color: Color = AppTheme.SeatColor.defaultColor
    
    @Published var isBooked = false
    
    @Published var isSelected = false
    
    @Published var isSelectable = true
    
    //@Published var totalGroupSelectedCount:Int = 0
    
    // For API request
    var fare:Float = 0.0
    var isAdult: Int = 1
    
    func toggleIsSelectedStatus(maturityStatus: String) {
        if !isSelectable {
            return
        }
        
        if maturityStatus.lowercased() == "child" {
            isAdult = 0
        }
        
        
        isSelected = !isSelected
        setVars()
        
    }
    
    
    // group
    
//    private func getAllPreSelectedCount(seats:[Seats])->Int {
//        return seats.filter({ $0.isSelected}).count
//    }
//
//    private func getAllPreSelectedCount(seatsInAGate:GateWithSections?)->Int {
//        guard let safeData = seatsInAGate else {
//            return 0
//        }
//        var totalCount = 0
//        for item in safeData.sections {
//            for item2 in item.seats ?? [] {
//                if item2.isSelected {
//                    totalCount += 1
//                }
//            }
//        }
//        return totalCount
//
//    }
    
    func selectGroupSeats(seats:[Seats], startIndex: Int, maxGroupSeat: Int, seatsInAGate: GateWithSections?) {
        //_ = getAllPreSelectedCount(seatsInAGate: seatsInAGate)
        
        let lastIndex = startIndex + (maxGroupSeat - Global.GroupTiketing.TOTAL_GROUP_SELECTED_COUNT)
        
        print("TOTAL_GROUP_SELECTED_COUNT \(Global.GroupTiketing.TOTAL_GROUP_SELECTED_COUNT) maxGroupSeat: \(maxGroupSeat)")
        
        
        if Global.GroupTiketing.TOTAL_GROUP_SELECTED_COUNT >= maxGroupSeat {
            guard seats[safe: startIndex] != nil else {
              return
            }
            if seats[startIndex].isSelected {
                seats[startIndex].isSelected = false
                setVars(seat: seats[startIndex])
                Global.GroupTiketing.TOTAL_GROUP_SELECTED_COUNT -= 1
            }
        } else {
            
            guard seats[safe: startIndex] != nil else {
              return
            }
            
            if seats[startIndex].isSelected {
                seats[startIndex].isSelected = false
                Global.GroupTiketing.TOTAL_GROUP_SELECTED_COUNT -= 1
                setVars(seat: seats[startIndex])
                
            } else {
                
                for i in startIndex..<lastIndex {
                    guard seats[safe: i] != nil else {
                      return
                    }
                    if !seats[i].isSelectable || seats[i].isSelected{
                        break
                    }
                    
                    seats[i].isSelected = true
                    Global.GroupTiketing.TOTAL_GROUP_SELECTED_COUNT += 1
                    setVars(seat: seats[i])
                    
                    
                }
            }
            
            
        }
        
    }
    
    private func setVars(seat: Seats) {
            //check for
            if seat.seatNumber == "!"  {
                seat.isSelectable = false
                seat.color = .white
                seat.seatNumber = ""
                return
            }
            
            if seat.status == 3 || seat.isBooked {
                isSelectable = false
            }
            
            seat.color = AppTheme.SeatColor.defaultColor
            
            if seat.isBooked {
                seat.color = AppTheme.SeatColor.booked
            }
            else {
                if seat.status == 3 {
                   // maintenace
                    seat.color = AppTheme.SeatColor.maintenance
                } else if seat.status == 1 {
                    
                    if seat.isSelected {
                        seat.color = AppTheme.SeatColor.selected
                    } else {
                        for color in AppTheme.SeatColor.colorList {
                            if color.key.lowercased() == seat.colorName?.lowercased() {
                                seat.color = color.color
                            }
                        }
                    }
                }
            }
        }

    
    
    
    
    func setIsBooked() {
        self.isBooked = true
        setVars()
    }

    enum CodingKeys: String, CodingKey {

        case seatLayoutID = "seatLayoutID"
        case seatNumber = "seatNumber"
        case gateNumberID = "gateNumberID"
        case gateNumber = "gateNumber"
        case seatTypeID = "seatTypeID"
        case seatType = "seatType"
        case status = "status"
        case colorName = "colorName"
        case section = "section"
    }
    
    func setVars() {
        //check for
        if seatNumber == "!" || seatNumber == "" {
            isSelectable = false
            color = .white
            seatNumber = ""
            return
        }
        
        if status == 3 || isBooked {
            isSelectable = false
        }
        
        color = AppTheme.SeatColor.defaultColor
        
        if isBooked {
            color = AppTheme.SeatColor.booked
        }
        else {
            if status == 3 {
               // maintenace
                color = AppTheme.SeatColor.maintenance
            } else if status == 1 {
                
                if isSelected {
                    color = AppTheme.SeatColor.selected
                } else {
                    for color in AppTheme.SeatColor.colorList {
                        if color.key.lowercased() == colorName?.lowercased() {
                            self.color = color.color
                        }
                    }
                    
//                    if seatType ==  SeatType.vip.rawValue {
//                        color = AppTheme.SeatColor.vip
//                    } else if seatType ==  SeatType.classic.rawValue {
//                        color = AppTheme.SeatColor.classic
//                    }
                }
            }
        }
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        seatLayoutID = try values.decodeIfPresent(String.self, forKey: .seatLayoutID)
        seatNumber = try values.decodeIfPresent(String.self, forKey: .seatNumber)
        gateNumberID = try values.decodeIfPresent(Int.self, forKey: .gateNumberID)
        gateNumber = try values.decodeIfPresent(String.self, forKey: .gateNumber)
        seatTypeID = try values.decodeIfPresent(Int.self, forKey: .seatTypeID)
        seatType = try values.decodeIfPresent(String.self, forKey: .seatType)
        colorName = try values.decodeIfPresent(String.self, forKey: .colorName)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        section = try values.decodeIfPresent(String.self, forKey: .section)
        setVars()
        
    }

}


class GateWithSections:Identifiable {
    var id = UUID()
    var gateNo = ""
    var sections:[Section]
    init(gateNo: String, sections: [Section] ) {
        self.gateNo = gateNo
        self.sections = sections
    }
    
    
}

class Section: Identifiable  {
    var id = UUID()
    var sectionName = ""
    
    var rowCount:Int = 0
    var seats: [Seats]?
}



extension Collection where Indices.Iterator.Element == Index {
    subscript (safe index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
