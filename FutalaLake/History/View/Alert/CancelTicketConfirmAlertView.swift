//
//  CustomAlertView.swift
//  FutalaLake
//
//  Created by Abhayjeet Singh on 27/12/22.
//

import SwiftUI

struct CancelTicketConfirmAlertView: View {
    @Binding var isPresented: Bool
    @Binding var isConfirmPressed: Bool
    var body: some View {
        ZStack {
            AppTheme.appThemeBlue
                .ignoresSafeArea()
                .opacity(0.8)
            VStack(alignment: .center, spacing: 0) {
                Text("ARE YOU SURE WANT TO CANCEL THE TICKET")
                    .multilineTextAlignment(.center)
                    .font(.system(size: 20, weight: .medium, design: .default))
                    .foregroundColor(AppTheme.appThemeOrange)
                    .padding(.horizontal)
                HStack {
                    
                    // confirm button
                    Button {
                        isPresented = false
                        isConfirmPressed.toggle()
                    } label: {
                        HStack {
                            HStack{
                                Image("check_mark")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20, height: 20)
                                    .padding(.horizontal, 10)
                                    .padding(.leading, 5)
                                Color.white.frame(width: 5 / UIScreen.main.scale)
                                    .frame(width: 1, height: 30)
                                    .padding(.leading, -5)
                                Text("CONFIRM")
                                    .foregroundColor(.white)
                                    .padding(.trailing)
                                    .padding(.leading, -4)
                                //
                            }.frame(height: 35)
                        }
                        
                    }
                    
                        .background(.green)
                        .clipShape(Capsule())
                    
                    // cancel button
                    Button {
                        //
                        isPresented.toggle()
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
                    

                }
                .padding(.top,20)
            }.frame(width: 340, height: 150)
                .background(AppTheme.appThemeSkyBlue)
                .cornerRadius(20)
        }
        
        
    }
}

struct CancelTicketConfirmAlertView_Previews: PreviewProvider {
    static var previews: some View {
        CancelTicketConfirmAlertView(isPresented: .constant(false), isConfirmPressed: .constant(false))
    }
}
