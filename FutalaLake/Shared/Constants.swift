//
//  Constants.swift
//  FutalaLake
//
//  Created by Abhayjeet Singh on 02/03/23.
//

import Foundation

struct Constants {
    static let tokenExpired = "test.token.expired"
    static let errorCode = "errorCode"
    static let tokenKey = "usertoken"
    static let colorKey = "colorKey"
    static let adminCharges = "10"
    static let baseUrl = "https://ffts.aurionpro.com:3001/" //"http://220.226.100.106:3001/"
    
    static let GATES = ["GATE NO. 1", "GATE NO. 2", "GATE NO. 3", "GATE NO. 4", "GATE NO. 5", "GATE NO. 6", "GATE NO. 7"]
    
    struct API {
        static let sendOTP = "mobile/user/sendMobileVerificationRedisOTP"
        static let showsByDays = "mobile/bookTicket/getShowsByDay"
        static let seatMaster = "mobile/seatConfig/seatMaster"
        static let seatBooking = "mobile/bookTicket/seatBooking"
        static let saveRedisSeat = "mobile/bookTicket/saveDetailsRedisSeat"
        static let checkOut = "mobile/bookTicket/checkout"
        static let generateQR = "mobile/bookTicket/generateQRData"
        static let updatePaymentStatus = "mobile/bookticket/updatePaymentStatus"
        static let seatInventory = "user/seatInventory"
        static let userHistory = "mobile/user/mobileUserHistory"
        static let cancelTicket = "mobile/bookTicket/updateCancelTicketStatus"
        static let userHistoryDetails = "mobile/user/mobileUserHistoryDetail"
        static let getProfileDetails = "mobile/user/profileList"
        static let updateProfile = "mobile/user/profileUpdate"
        static let masterConfig = "masterConfig"
        static let getPaymentDetails = "mobile/bookTicket/getPaymentDetails"
        
        
        
    }
    
    struct StringConstant {
        static let instructions =
        """
        * The e-ticket is valid only the number of persons in total and other permissions specified herein.\n
        * The e-ticket has to be carried but the visitors to get the entry in futala lake. Please take care of QR ticket.\n
        * Without QR code, you can not enter the futala lake.\n
        * Please keep the ticket at the time of checking.\n
        * Please come in a queue before gatekeeper scan the QR.\n
        * One ticket is valid for a \"single scan\". Therefore, you can not use the same QR ticket again.\n
        * Consuming alcohol in futala lake premises is a \"punishable\" offence.\n
        * Please take care of all your belongings.\n
        * Polythenes, Tobacco products, Inflammable and Pets are not allowed inside the futala lake premises.\n
        """
        
        static let cancellationPolicy =
        """
        * The cancellation charge mentioned below.\n\n
        * Before show time from the visit day 50% of the booking amount refundable. Convenience fee is non refundable.\n
        * Before booking tickets, carefully review your booking details.\n
        * A ticket \"can not be modified\". Actual formatting\n
        * Futala lake authorities all the right to change/cancel the ticket(s).\n
        * If the ticket payment failed,a full refund except the service fee will be transferred in the same account from which the transaction was done within the 4-5 working days.\n
        * If an amount got deducted from your bank account/wallet, and you haven`t received the QR ticket, please send us an email to fulatalake.com We would investigate the case within 2 working days and assure you a full resolution. However, online transaction charges/service charges/taxes if any, will not be refunded under any circumstances.\n
        """
    }
}
