//
//  DateTimeSelectionModel.swift
//  FutalaLake
//
//  Created by Abhayjeet Singh on 06/03/23.
//

import UIKit
import Foundation

struct DateTimeSelectionModel : Codable {
    var status : Bool?
    var data : [DateTimeSelectionModelData]?
    var error : String?
    
    enum CodingKeys: String, CodingKey {
        
        case status = "status"
        case data = "data"
        case error = "error"
    }
    
    
    //from decoder: Decoder? = nil
    
    
    init(from decoder: Decoder? = nil)  {
        do {
            if let decoder = decoder {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                status = try values.decodeIfPresent(Bool.self, forKey: .status)
                data = try values.decodeIfPresent([DateTimeSelectionModelData].self, forKey: .data)
                error = try values.decodeIfPresent(String.self, forKey: .error)
            }
        } catch {
            print("Hello \(error)")
        }
    }


}



struct DateTimeSelectionModelData : Codable {
    let name : String?
    let showDayID : String?
    var shows : [Shows]?

    enum CodingKeys: String, CodingKey {

        case name = "name"
        case showDayID = "showDayID"
        case shows = "shows"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        showDayID = try values.decodeIfPresent(String.self, forKey: .showDayID)
        shows = try values.decodeIfPresent([Shows].self, forKey: .shows)
    }

}

struct Shows : Codable {
    let status : Int?
    let endTime : String?
    var startTimeInTwelveHourFormat = ""
    let startTime : String?
    let showTimeID : String?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case endTime = "endTime"
        case startTime = "startTime"
        case showTimeID = "showTimeID"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        endTime = try values.decodeIfPresent(String.self, forKey: .endTime)
        startTime = try values.decodeIfPresent(String.self, forKey: .startTime)
        showTimeID = try values.decodeIfPresent(String.self, forKey: .showTimeID)
        self.startTimeInTwelveHourFormat = convertTime(time: startTime ?? "") ?? ""
    }
    
    private func convertTime(time: String)->String? {
        let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "H:mm:s"
        if let date12 = dateFormatter.date(from: time) {
            dateFormatter.dateFormat = "h:mm a"
            let date22 = dateFormatter.string(from: date12)
            return date22
        }
        return nil
    }

}

