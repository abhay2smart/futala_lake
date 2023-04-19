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
    
    private func setVars() {
        if seatNumber == "!"  {
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

