//
//  SeatInventory.swift
//  FutalaLake
//
//  Created by Abhayjeet Singh on 24/03/23.
//

import Foundation
struct SeatInventoryModel : Codable {
    let status : Bool?
    let data : [SeatInventoryData]?
    let error : String?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case data = "data"
        case error = "error"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        data = try values.decodeIfPresent([SeatInventoryData].self, forKey: .data)
        error = try values.decodeIfPresent(String.self, forKey: .error)
    }

}

struct SeatInventoryData : Codable {
    var seatInventoryID : String?
    var viewTypeID : Int?
    var viewType : String?
    var seatTypeID : Int?
    var seatType : String?
    var colorID : Int?
    var colorName : String?
    var quantity : Int?
    var status : Int?

    enum CodingKeys: String, CodingKey {

        case seatInventoryID = "seatInventoryID"
        case viewTypeID = "viewTypeID"
        case viewType = "viewType"
        case seatTypeID = "seatTypeID"
        case seatType = "seatType"
        case colorID = "colorID"
        case colorName = "colorName"
        case quantity = "quantity"
        case status = "status"
    }

    init(from decoder: Decoder? = nil)  {
        if let decoder = decoder {
            do {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                seatInventoryID = try values.decodeIfPresent(String.self, forKey: .seatInventoryID)
                viewTypeID = try values.decodeIfPresent(Int.self, forKey: .viewTypeID)
                viewType = try values.decodeIfPresent(String.self, forKey: .viewType)
                seatTypeID = try values.decodeIfPresent(Int.self, forKey: .seatTypeID)
                seatType = try values.decodeIfPresent(String.self, forKey: .seatType)
                colorID = try values.decodeIfPresent(Int.self, forKey: .colorID)
                colorName = try values.decodeIfPresent(String.self, forKey: .colorName)
                quantity = try values.decodeIfPresent(Int.self, forKey: .quantity)
                status = try values.decodeIfPresent(Int.self, forKey: .status)
            } catch {
                print("HHH99877")
            }
            
        }
        
    }

}


