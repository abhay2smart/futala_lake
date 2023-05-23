//
//  QRSubView.swift
//  FutalaLake
//
//  Created by Abhayjeet Singh on 24/03/23.
//

import SwiftUI

struct QRSubView: View {
    var qrData:QRData = QRData()
    private var ecryptedData = ""
    private var seats = ""
    private var startTime = ""
    private var endTime = ""
    private var isSeating = true
    private var qRSeatData: QRSeatData?
    init(qrData: QRData, isSeating: Bool = true, qRSeatData:QRSeatData? = nil) {
        self.qrData = qrData
        self.isSeating = isSeating
        self.qRSeatData = qRSeatData
        startTime = CommonUtil.convertTimeTwentyFourIntoTwelve(time: qrData.startTime ?? "") ?? ""
        endTime = CommonUtil.convertTimeTwentyFourIntoTwelve(time: qrData.endTime ?? "") ?? ""
        
        
        if let safeSeat = qrData.seatData?.first?.seats {
            seats = safeSeat.map{String($0)}.joined(separator: ",")
        }
        
        if isSeating {
            self.ecryptedData = qrData.seatData?.first?.encryptedSeatingQRCode ?? ""
        } else {
            self.ecryptedData = qrData.qrStandingData?.first?.encryptedStandingQRCode ?? ""
        }
        
    }
    var body: some View {
        
            VStack {
                ZStack(alignment: .top) {
//                    Image("qr_bg")
//                        .resizable()
//                        .scaledToFill()
//                        .frame(width: UIScreen.main.bounds.width - 40)
//                        .padding()
                    VStack {
                        
                        Image(uiImage: UIImage(data: CommonUtil.getQRCodeData(dictionary: ["data": ecryptedData])!)!)
                                       .resizable()
                                       .frame(width: 200, height: 200)
                                       .padding(.top, 50)
                        
                        
                        VStack(spacing: 20) {
                            Group {
                                
                                HStack {
                                    Text("Ticket Number")
                                    Spacer()
                                    Text(qrData.ticketID ?? "")

                                }.multilineTextAlignment(.center)
                                    .font(.system(size: 17, weight: .regular, design: .default))
                                    .foregroundColor(.black)
                                
                                Divider()
                                
                                if isSeating {
                                    HStack(spacing: 20) {
                                        Text("Seat No./Nos")
                                        Spacer()
                                        Text(seats)
                                    }.multilineTextAlignment(.center)
                                        .font(.system(size: 17, weight: .regular, design: .default))
                                        .foregroundColor(.black)
                                    
                                    Divider()
                                    
                                    HStack(spacing: 20) {
                                        Text("Gate No.")
                                        Spacer()
                                        Text(qRSeatData?.gateNo ?? "")
                                    }.multilineTextAlignment(.center)
                                        .font(.system(size: 17, weight: .regular, design: .default))
                                        .foregroundColor(.black)
                                    
                                    Divider()
                                    
                                    HStack(spacing: 20) {
                                        Text("Seat type")
                                        Spacer()
                                        Text(qrData.seatData?.first?.ticketType ?? "")
                                    }.multilineTextAlignment(.center)
                                        .font(.system(size: 17, weight: .regular, design: .default))
                                        .foregroundColor(.black)
                                    
                                    Divider()
                                    
                                    HStack(spacing: 20) {
                                        Text("Toat Seats")
                                        Spacer()
                                        Text("\(qrData.seatData?.first?.noOfSeats ?? 0)")
                                    }.multilineTextAlignment(.center)
                                        .font(.system(size: 17, weight: .regular, design: .default))
                                        .foregroundColor(.black)
                                    
                                    //Divider()
                                    
                                } else {
                                    HStack(spacing: 20) {
                                        Text("Standing")
                                        Spacer()
                                        Text("\(qrData.qrStandingData?.first?.standingCount ?? 0)")
                                    }.multilineTextAlignment(.center)
                                        .font(.system(size: 17, weight: .regular, design: .default))
                                        .foregroundColor(.black)
                                    
                                    //Divider()
                                }
                                
                                Divider()
                                
                                
                                
                                HStack {
                                    Text("Timing")
                                    Spacer()
                                    Text("\(startTime) - \(endTime)")
                                }.multilineTextAlignment(.center)
                                    .font(.system(size: 17, weight: .regular, design: .default))
                                    .foregroundColor(.black)
                                
                                Divider()
                                
                                HStack {
                                    Text("Show Date")
                                    Spacer()
                                    Text(CommonUtil.showDate(date: qrData.showDate ?? ""))
                                    
                                }.multilineTextAlignment(.center)
                                    .font(.system(size: 17, weight: .regular, design: .default))
                                    .foregroundColor(.black)
                                
                                Divider()
                                
                                HStack {
                                    Text("Total")
                                    Spacer()
                                    Text("₹\(qrData.totalFare ?? 0)")
                                    
                                }.multilineTextAlignment(.center)
                                    .font(.system(size: 17, weight: .regular, design: .default))
                                    .foregroundColor(.black)


                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 20)
                        //Spacer()
                    }
                    
                    
                }
                
        }
    }
}

struct QRSubView_Previews: PreviewProvider {
    static var previews: some View {
        QRSubView(qrData: QRData())
    }
}
