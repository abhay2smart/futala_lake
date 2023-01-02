//
//  CancelTicketAlertView.swift
//  FutalaLake
//
//  Created by Abhayjeet Singh on 28/12/22.
//

import SwiftUI

struct CancelTicketAlertView: View {
    @Binding var isTicketCancelSuccessPreseneted: Bool
    @Binding var isTicketInfoPreseneted:Bool
    var body: some View {
        ZStack {
            AppTheme.appThemeBlue
                .ignoresSafeArea()
                .opacity(0.8)
            VStack(alignment: .center, spacing: 0) {
                Text("Cancel Ticket")
                    .multilineTextAlignment(.center)
                    .font(.system(size: 20, weight: .medium, design: .default))
                    .foregroundColor(AppTheme.appThemeOrange)
                    .padding(10)
                HStack {
                    Text("Ticket Information")
                        .font(.system(size: 18, weight: .medium, design: .default))
                        .foregroundColor(.black)
                        .padding(.horizontal)
                    Spacer()
                    
                }
                Divider()
                    .background(.black)
                    .padding(.horizontal, 15)
                    .padding(.vertical, 10)
                
                
                Group {
                    //Seat No
                    VStack {
                        HStack {
                            Text("Seat No")
                                .font(.system(size: 15, weight: .medium, design: .default))
                                .foregroundColor(.black)
                                .padding(.horizontal)
                            Spacer()
                            
                            Text("A10, A11")
                                .font(.system(size: 15, weight: .medium, design: .default))
                                .foregroundColor(.black)
                                .padding(.horizontal)
                            
                        }
                    }
                    Divider()
                        .background(.black)
                        .padding(.horizontal, 15)
                        .padding(.vertical, 10)
                    
                    //Ticket Amt
                    
                    VStack {
                        HStack {
                            Text("Ticket Amount")
                                .font(.system(size: 15, weight: .medium, design: .default))
                                .foregroundColor(.black)
                                .padding(.horizontal)
                            Spacer()
                            
                            Text("₹200")
                                .font(.system(size: 15, weight: .medium, design: .default))
                                .foregroundColor(.black)
                                .padding(.horizontal)
                            
                        }
                    }
                    Divider()
                        .background(.black)
                        .padding(.horizontal, 15)
                        .padding(.vertical, 10)
                    
                    
                   // Admin charges
                    
                    VStack {
                        HStack {
                            Text("Admin Charges")
                                .font(.system(size: 15, weight: .medium, design: .default))
                                .foregroundColor(.black)
                                .padding(.horizontal)
                            Spacer()
                            
                            Text("₹40")
                                .font(.system(size: 15, weight: .medium, design: .default))
                                .foregroundColor(.black)
                                .padding(.horizontal)
                            
                        }
                    }
                    Divider()
                        .background(.black)
                        .padding(.horizontal, 15)
                        .padding(.vertical, 10)
                    
                    // Refund amt
                    
                    HStack {
                        Text("Refund Amount")
                            .font(.system(size: 15, weight: .medium, design: .default))
                            .foregroundColor(.black)
                            .padding(.horizontal)
                        Spacer()
                        
                        Text("₹160")
                            .font(.system(size: 15, weight: .medium, design: .default))
                            .foregroundColor(.black)
                            .padding(.horizontal)
                    }
                }
                
                
                
                // Refund Amount
                
                Button {
                    //
                    isTicketInfoPreseneted = false
                    isTicketCancelSuccessPreseneted.toggle()
                } label: {
                    HStack {
                        HStack{
                            Image("cross")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                                .padding(.horizontal, 10)
                                .padding(.leading, 5)
                            Color.white.frame(width: 5 / UIScreen.main.scale)
                                .frame(width: 1, height: 30)
                                .padding(.leading, -5)
                            Text("CANCEL")
                                .foregroundColor(.white)
                                .padding(.trailing)
                                .padding(.leading, -4)
                            //
                        }.frame(height: 35)
                    }
                }
                .background(AppTheme.appThemeRed)
                    .clipShape(Capsule())
                    .padding(.vertical, 30)

                
                
                
                
                
                
                Spacer()
                
            }.frame(width: 340, height: 320)
                .background(AppTheme.appThemeSkyBlue)
                .cornerRadius(20)
        }
    }
}

struct CancelTicketAlertView_Previews: PreviewProvider {
    static var previews: some View {
        CancelTicketAlertView(isTicketCancelSuccessPreseneted: .constant(false), isTicketInfoPreseneted: .constant(false))
    }
}
