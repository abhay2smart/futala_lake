//
//  Constants.swift
//  FutalaLake
//
//  Created by Abhayjeet Singh on 02/03/23.
//

import Foundation

struct Constants {
    static let tokenKey = "usertoken"
    static let baseUrl = "http://220.226.100.106:3001/"
    
    struct API {
        static let sendOTP = "mobile/user/sendMobileVerificationRedisOTP"
        static let showsByDays = "mobile/bookTicket/getShowsByDay"
    }
}
