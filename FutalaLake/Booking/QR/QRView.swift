//
//  QRView.swift
//  FutalaLake
//
//  Created by Abhayjeet Singh on 04/01/23.
//

import SwiftUI

struct QRView: View {
    
    private var encriptedSeatingData:String = ""
    private var encriptedStandingData:String = ""
    var qrData:QRData?
    @EnvironmentObject var session: SessionManager
    
    @State private var isSeating = true // for button toggle
    
    init(data: QRData) {
        //encriptedSeatingData = data.seatData?.first?.encryptedSeatingQRCode ?? ""
        encriptedStandingData = data.qrStandingData?.first?.encryptedStandingQRCode ?? ""
        self.qrData = data
        
    }
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            //AppTheme.appThemeSkyBlue
            VStack {
                
                
                    HStack(alignment: .center) {
                        //Spacer()
                        
                        
                        
                        if (qrData?.seatData?.count ?? 0) > 0 {
                            Button {
                                isSeating = true
                            } label: {
                                Text("Seating")
                                    .foregroundColor(isSeating ? .white: .black)
                            }
                            .frame(width: 140)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 10)
                            .background(
                                Rectangle()
                                    .fill(isSeating ? AppTheme.appThemeOrange: .white )
                                    .cornerRadius(5)
                                    .shadow(
                                        color: Color.gray.opacity(0.7),
                                        radius: 8,
                                        x: 0, y: 0)
                            )
                            .padding(.horizontal, 10)
                            
                        }
                        
                        
                        
                        if (qrData?.qrStandingData?.count ?? 0) > 0 {
                            Button {
                                isSeating = false
                            } label: {
                                Text("Standing")
                                    .foregroundColor(isSeating ? .black: .white )
                            }
                            .frame(width: 140)
                            .padding(.all, 10)
                            .background(
                                Rectangle()
                                    .fill(isSeating ? .white: AppTheme.appThemeOrange )
                                    .cornerRadius(5)
                                    .shadow(
                                        color: Color.gray.opacity(0.7),
                                        radius: 8,
                                        x: 0, y: 0)
                            )
                            .padding(.horizontal, 10)
                        }
                        
                        
                    }.padding()
                
                
                ScrollView {
                    VStack {
                        
                        if isSeating {
                            if let safeSeats = qrData?.seatData {
                                ForEach(Array(safeSeats.enumerated()), id: \.offset) { index, element in
                                    VStack {
                                            QRSubView(qrData: qrData ?? QRData(), isSeating: isSeating, qRSeatData: element)
                                        BookedActionsView(qrData: qrData ?? QRData(), seatData: element, isSeating: isSeating)
                                        
                                    }.padding(.bottom, 30)
                                        .background(
                                         Rectangle()
                                         .fill(.white)
                                         .cornerRadius(12)
                                          .shadow(
                                           color: Color.gray.opacity(0.7),
                                           radius: 8,
                                           x: 0, y: 0)
                                          )
                                    
                                }
                            }
                            
                        } else {
                            VStack {
                                QRSubView(qrData: qrData ?? QRData(), isSeating: isSeating)
                                BookedActionsView(qrData: qrData ?? QRData(), seatData: nil, isSeating: isSeating)
                            }
                            
                        }
                        
                        
                    }
                    
                    .padding()

                }.padding(.top, -20)
            }
            
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
            }.padding()
            
            
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text("QR").font(.subheadline)
                    }.foregroundColor(.white)
                }
            }
            
//            .toolbar { // <2>
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    TopNavItemView()
//                }
//            }
        }.onAppear {
            if (qrData?.seatData?.count ?? 0) == 0 {
                isSeating = false
            }
            
            
        }.navigationBarBackButtonHidden(true)
        
    }
}

struct QRView_Previews: PreviewProvider {
    static var previews: some View {
        QRView(data: QRData())
    }
}


