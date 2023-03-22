//
//  CommonUtil.swift
//  FutalaLake
//
//  Created by Abhayjeet Singh on 17/03/23.
//

import Foundation

class CommonUtil {
    static func convertTimeTwentyFourIntoTwelve(time: String)->String? {
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
