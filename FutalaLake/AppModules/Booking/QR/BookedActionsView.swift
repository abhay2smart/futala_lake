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
    @State var isWaiting = false
    private var msg = ""
    private var isBookingBtnHidden: Bool = true
    private var bookingId = ""
    
    init(msg: String, isBookingBtnHidden: Bool = true, bookingId: String) {
        self.msg = msg
        self.bookingId = bookingId
        self.isBookingBtnHidden = isBookingBtnHidden
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
                MessageComposeView(recipients: [""], body: msg ) { messageSent in
                    print("MessageComposeView with message sent? \(messageSent)")
                }
            }
            
            Spacer()
            ZStack(alignment: .center) {
                Button {
                    //WhatsApp.sendMessage(msg: msg)
                    isWaiting = true
                    FileDownloadManager.downloadPDF(bookingId: bookingId) { url in
                        //self.isWaiting = false
//                        if let url = url {
//                            FileDownloadManager.sharePDF(pdfURL: url)
//                        }
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute: {
                        FileDownloadManager.downloadPDF(bookingId: bookingId) { url in
                            self.isWaiting = false
                            if let url = url {
                                FileDownloadManager.sharePDF(pdfURL: url)
                            }
                        }
                    })
                    
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
                
                Text("Pleasae wait")
                    .font(.system(size: 10, weight: .medium, design: .default))
                    .padding(.top, 67).foregroundColor(isWaiting ? .black : .clear)
            }
            
            
            Spacer()
            
            if !isBookingBtnHidden {
                Button {
                    //
                    self.session.moveToDashboard = true
                } label: {
                    VStack(spacing: 5) {
                        ZStack {
                            Rectangle()
                                .fill(AppTheme.appThemeOrange)
                                .frame(width: 50, height: 50)
                                .clipShape(Circle())
                            Text("Booking")
                                .multilineTextAlignment(.center)
                                .font(.system(size: 10, weight: .medium, design: .default))
                                .foregroundColor(.white)
                            
                        }
                        
                        
                    }
                }
                
                Spacer()
            }
            
           
            
            
        }
    }
}

//struct BookedActionsView_Previews: PreviewProvider {
//    static var previews: some View {
//        BookedActionsView(data: QRData())
//    }
//}
