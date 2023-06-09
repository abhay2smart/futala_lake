//
//  BookedActionsView.swift
//  FutalaLake
//
//  Created by Abhayjeet Singh on 18/04/23.
//

import SwiftUI

struct BookedActionsView: View {
    @EnvironmentObject var session: SessionManager
    @State var isMessageViewPresented: Bool = false
    private var qrData:QRData
    private var seatData:QRSeatData?
    private var standing: [QRStandingData]?
    private var msg = ""
    private var isSeating = false
    
    
    
    init(qrData: QRData, seatData: QRSeatData?, isSeating: Bool) {
        self.qrData = qrData
        self.seatData = seatData
        self.standing = qrData.qrStandingData
        self.isSeating = isSeating
    }
    
    private func composeMessage()->String? {
        var seats = "N/A"
        var msg = ""
        let showDate = CommonUtil.showDate(date: qrData.showDate ?? "")
        let totalStanding = standing?.first?.standingCount
        let gateNo = seatData?.gateNo ?? ""
        
        let showTime = (CommonUtil.convertTimeTwentyFourIntoTwelve(time: qrData.startTime ?? "") ?? "") + " - " + (CommonUtil.convertTimeTwentyFourIntoTwelve(time: qrData.endTime ?? "") ?? "")
        
        
        if let safeSeat = seatData?.seats {
            seats = safeSeat.map{String($0)}.joined(separator: ",")
        }
        if isSeating {
            msg =
            """
        Welcome to Futala Lake.\n
        Seat Information\n
        [\(seats)] \n
        Show Date: \(showDate) \n
        Show time: \(showTime) \n
        Gate No: \(gateNo) \n
        QR Code: \(Constants.baseUrl + "dpdf.html?id=" + (qrData.bookingID ?? ""))
            
        Thank you!
        """
        } else {
            msg =
        """
        Welcome to Futala Lake.\n
        Standing count: \(totalStanding ?? 0) \n
        Show Date: \(showDate) \n
        Show time: \(showTime) \n
        QR Code: \(Constants.baseUrl + "dpdf.html?id=" + (qrData.bookingID ?? "")) \n
        Thank you.
        """
        }
        return msg
    }
    
    
//    Welcome to Futala Lake
//     Seat Information
//     Seat: ['B80', 'B59']
//     Show Time: 07:00 pm - 08:00 pm
//     Show Date: 06-06-2023
//     Seat Type: VIP
//     Standing Count:
//     Gate No.: GATE NO. 1,
//     Thank you!
//     QR Code: https://ffts.aurionpro.com:3001/dpdf.html?id=2de1778d-d4f0-4616-b1be-eb51a0b7633a
    
    
    var body: some View {
        HStack {
            Spacer()
            
            
            Button {
                self.isMessageViewPresented = true
            } label: {
                VStack(spacing: 5) {
                    ZStack {
                        Rectangle()
                            .fill(AppTheme.appThemeOrange)
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                        Image("sms")
                            .resizable()
                            .frame(width: 25, height: 25)
                    }
                }
                
            }
            .sheet(isPresented: self.$isMessageViewPresented) {
                MessageComposeView(recipients: [""], body: composeMessage() ?? "") { messageSent in
                    print("MessageComposeView with message sent? \(messageSent)")
                }
            }
            
            Spacer()
            
            Button {
                let msg = composeMessage() ?? ""
                WhatsApp.sendMessage(msg: msg)
            } label: {
                VStack(spacing: 5) {
                    ZStack {
                        Rectangle()
                            .fill(.green)
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                        Image("whatsapp")
                            .resizable()
                            .frame(width: 25, height: 25)
                        
                    }
                    
                    
                }
                
            }
            
            Spacer()
            
            
        }
    }
}

//struct BookedActionsView_Previews: PreviewProvider {
//    static var previews: some View {
//        BookedActionsView(data: QRData())
//    }
//}
