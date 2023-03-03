//
//  QRView.swift
//  FutalaLake
//
//  Created by Abhayjeet Singh on 04/01/23.
//

import SwiftUI

struct QRView: View {
    var body: some View {
        ZStack {
            AppTheme.appThemeSkyBlue
            ScrollView {
                VStack {
                    ZStack(alignment: .top) {
                        Image("qr_bg")
                            .resizable()
                            .scaledToFill()
                            .frame(width: UIScreen.main.bounds.width - 40)
                            .padding()
                        VStack {
                            Image("qr-scan-icon")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 200, height: 200)
                                .padding()
                                .padding(.top, 40)
                            
                            VStack(spacing: 20) {
                                Group {
                                    HStack {
                                        Text("Seat")
                                        .multilineTextAlignment(.center)
                                        .font(.system(size: 17, weight: .regular, design: .default))
                                        .foregroundColor(.black)
                                        
                                        Spacer()
                                        
                                        Text("D3 45")
                                        .multilineTextAlignment(.center)
                                        .font(.system(size: 17, weight: .regular, design: .default))
                                        .foregroundColor(.black)

                                    }
                                    
                                    HStack {
                                        Text("Time")
                                        .multilineTextAlignment(.center)
                                        .font(.system(size: 17, weight: .regular, design: .default))
                                        .foregroundColor(.black)
                                        
                                        Spacer()
                                        
                                        Text("7:30 PM")
                                        .multilineTextAlignment(.center)
                                        .font(.system(size: 17, weight: .regular, design: .default))
                                        .foregroundColor(.black)

                                    }
                                    
                                    HStack {
                                        Text("Date")
                                        .multilineTextAlignment(.center)
                                        .font(.system(size: 17, weight: .regular, design: .default))
                                        .foregroundColor(.black)
                                        
                                        Spacer()
                                        
                                        Text("Sun, Dec 20, 2022")
                                        .multilineTextAlignment(.center)
                                        .font(.system(size: 17, weight: .regular, design: .default))
                                        .foregroundColor(.black)

                                    }
                                    
                                    HStack {
                                        Text("Lake")
                                        .multilineTextAlignment(.center)
                                        .font(.system(size: 17, weight: .regular, design: .default))
                                        .foregroundColor(.black)
                                        
                                        Spacer()
                                        
                                        Text("Futala Lake")
                                        .multilineTextAlignment(.center)
                                        .font(.system(size: 17, weight: .regular, design: .default))
                                        .foregroundColor(.black)

                                    }
                                    
                                    HStack {
                                        Text("City")
                                        .multilineTextAlignment(.center)
                                        .font(.system(size: 17, weight: .regular, design: .default))
                                        .foregroundColor(.black)
                                        
                                        Spacer()
                                        
                                        Text("Nagpur, Maharastra")
                                        .multilineTextAlignment(.center)
                                        .font(.system(size: 17, weight: .regular, design: .default))
                                        .foregroundColor(.black)

                                    }


                                }
                            }
                            .padding(.horizontal, 60)
                            .padding(.vertical, 20)
                            //Spacer()
                        }
                        
                        
                    }
                    
                    HStack {
                        Button {
                            //
                        } label: {
                            VStack(spacing: 8) {
                                ZStack {
                                    Rectangle()
                                        .fill(AppTheme.appThemeOrange)
                                        .frame(width: 50, height: 50)
                                        .clipShape(Circle())
                                    Image("print")
                                        .resizable()
                                        .frame(width: 25, height: 25)
                                    
                                }
                                
                                Text("Print")
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
                        
                        Button {
                            //
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

                    }.padding(.horizontal, 40)
                    
                    Spacer()
                    
                }.padding(.bottom)
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
        QRView()
    }
}
