//
//  TicketCancelSuccessAlertView.swift
//  FutalaLake
//
//  Created by Abhayjeet Singh on 28/12/22.
//

import SwiftUI

struct TicketCancelSuccessAlertView: View {
    @Binding var isGoHomeBtnPressed: Bool
    var body: some View {
        ZStack {
            AppTheme.appThemeBlue
                .ignoresSafeArea()
                .opacity(0.8)
            VStack(alignment: .center, spacing: 0) {
                Image("check_gif")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .padding(10)
                Text("Ticket Cancelled Successfully")
                    .multilineTextAlignment(.center)
                    .font(.system(size: 23, weight: .medium, design: .default))
                    .foregroundColor(AppTheme.appThemeOrange)
                    .padding(.horizontal)
                
                Text("Refund will be processed and reflected in original payment mode in 3 business days")
                    .multilineTextAlignment(.center)
                    .font(.system(size: 16, weight: .regular, design: .default))
                    .foregroundColor(.black)
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                
                Button {
                    isGoHomeBtnPressed.toggle()
                    
                } label: {
                    HStack {
                        HStack{
                            Image("home")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 18, height: 18)
                                .padding(.horizontal, 10)
                                .padding(.leading, 5)
                            Color.white.frame(width: 5 / UIScreen.main.scale)
                                .frame(width: 1, height: 30)
                                .padding(.leading, -5)
                            Text("GO HOME")
                                .foregroundColor(.white)
                                .padding(.trailing)
                                .padding(.leading, -4)
                            //
                        }.frame(height: 35)
                    }
                }
                .background(AppTheme.appThemeBlue)
                    .clipShape(Capsule())
                    .padding(.vertical, 30)
                
                Spacer()
                
            }.frame(width: 340, height: 320)
                .background(AppTheme.appThemeSkyBlue)
                .cornerRadius(20)
        }
    }
}

struct TicketCancelSuccessAlertView_Previews: PreviewProvider {
    static var previews: some View {
        TicketCancelSuccessAlertView(isGoHomeBtnPressed: .constant(false))
    }
}
