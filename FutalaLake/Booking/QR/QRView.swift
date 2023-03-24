//
//  QRView.swift
//  FutalaLake
//
//  Created by Abhayjeet Singh on 04/01/23.
//

import SwiftUI

struct QRView: View {
    
//    private var encriptedSeatingData:String = ""
    private var encriptedStandingData:String = ""
    var qrData:QRData?
    @EnvironmentObject var session: SessionManager
    
    @State private var isSeating = true // for button toggle
    
    init(data: QRData) {
//        encriptedSeatingData = data.seatData?.first?.encryptedSeatingQRCode ?? ""
        encriptedStandingData = data.qrStandingData?.first?.encryptedStandingQRCode ?? ""
        self.qrData = data
    }
    
    var body: some View {
        ZStack {
            //AppTheme.appThemeSkyBlue
            VStack {
                
                if encriptedStandingData != "" {
                    HStack(alignment: .center) {
                        //Spacer()
                        
                        
                        
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
                        
                        
                        Spacer()
                        
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
                        
                    }.padding()
                }
                
                ScrollView {
                    VStack {
                        QRSubView(qrData: qrData ?? QRData(), isSeating: isSeating)
                        
                        HStack {
                            Spacer()
                            
//                            Button {
//                                //
//                            } label: {
//                                VStack(spacing: 8) {
//                                    ZStack {
//                                        Rectangle()
//                                            .fill(AppTheme.appThemeOrange)
//                                            .frame(width: 50, height: 50)
//                                            .clipShape(Circle())
//                                        Image("print")
//                                            .resizable()
//                                            .frame(width: 25, height: 25)
//
//                                    }
//
//                                    Text("Print")
//                                        .multilineTextAlignment(.center)
//                                        .font(.system(size: 16, weight: .medium, design: .default))
//                                        .foregroundColor(AppTheme.appThemeOrange)
//
//                                }
//
//                            }
//
//                            Spacer()
                            
                            Button {
                                //
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
                                    
                                    Text("SMS")
                                        .multilineTextAlignment(.center)
                                        .font(.system(size: 16, weight: .medium, design: .default))
                                        .foregroundColor(AppTheme.appThemeOrange)
                                }
                                
                            }
                            
                            Spacer()
                            
                            Button {
                                //
                            } label: {
                                VStack(spacing: 5) {
                                    ZStack {
                                        Rectangle()
                                            .fill(AppTheme.appThemeOrange)
                                            .frame(width: 50, height: 50)
                                            .clipShape(Circle())
                                        Image("email")
                                            .resizable()
                                            .frame(width: 25, height: 25)
                                        
                                    }
                                    
                                    Text("Email")
                                        .multilineTextAlignment(.center)
                                        .font(.system(size: 16, weight: .medium, design: .default))
                                        .foregroundColor(AppTheme.appThemeOrange)
                                }
                                
                            }
                            
                            Spacer()
//
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
                                        Image("whatsapp")
                                            .resizable()
                                            .frame(width: 25, height: 25)

                                    }

                                    Text("Whatsapp")
                                        .multilineTextAlignment(.center)
                                        .font(.system(size: 16, weight: .medium, design: .default))
                                        .foregroundColor(AppTheme.appThemeOrange)
                                }



                            }
//
                            Spacer()
                            
                        }
                        
                    }
                }.padding(.top, -20)
            }
            
            
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text("QR").font(.subheadline)
                    }.foregroundColor(.white)
                }
            }
            
            .toolbar { // <2>
                ToolbarItem(placement: .navigationBarTrailing) {
                    TopNavItemView()
                }
            }
        }
        
    }
}

struct QRView_Previews: PreviewProvider {
    static var previews: some View {
        QRView(data: QRData())
    }
}


