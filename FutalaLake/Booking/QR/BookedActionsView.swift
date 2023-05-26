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
        let totalStanding = standing?.count ?? 0
        let gateNo = seatData?.gateNo ?? ""
        
        let showTime = (CommonUtil.convertTimeTwentyFourIntoTwelve(time: qrData.startTime ?? "") ?? "") + " - " + (CommonUtil.convertTimeTwentyFourIntoTwelve(time: qrData.endTime ?? "") ?? "")
        
        
        if let safeSeat = seatData?.seats {
            seats = safeSeat.map{String($0)}.joined(separator: ",")
        }
        if isSeating {
            msg = "Congratulations!! your booking is confirmed. \nSeats: [\(seats)] \nShow Date: \(showDate) \nShow time: \(showTime) \nGate No: \(gateNo) \n\n Thank you."
        } else {
            msg = "Congratulations!! your booking is confirmed.\nTotal Standing: \(totalStanding) \nShow Date: \(showDate) \nShow time: \(showTime) \nGate No: \(gateNo) \n\n Thank you."
        }
        return msg
    }
    
    
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
