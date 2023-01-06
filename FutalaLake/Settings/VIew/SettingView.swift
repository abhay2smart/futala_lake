//
//  SettingView.swift
//  FutalaLake
//
//  Created by Abhayjeet Singh on 23/12/22.
//

import SwiftUI

struct SettingView: View {
    @State private var isWhatsappNoticationOn: Bool = false
    @State private var isLocationOn: Bool = false
    @State private var isSavePaymentModeOn: Bool = false
    var body: some View {
        NavigationView {
            ZStack {
                AppTheme.appThemeSkyBlue
                VStack(spacing: 0) {
                    VStack(spacing: -10) {
                        Group {
                            Toggle("WhatsApp Notification", isOn: $isWhatsappNoticationOn)
                                .frame(height: 0)
                            Divider()
                            Toggle("Location", isOn: $isLocationOn)
                                .frame(height: 0)
                            
                            Divider()
                            Toggle("Save Payment Modes", isOn: $isSavePaymentModeOn)
                                .frame(height: 0)
                            
                            Divider()
                            
                            Button {
                                //<#code#>
                            } label: {
                                HStack {
                                    Text("Delete Account")
                                        .foregroundColor(.black)
                                    Spacer()
                                    Image("trash")
                                        .resizable()
                                        .scaledToFit()
                                        .padding(.trailing)
                                    
                                }
                            }.frame(height: 20)
                                .padding(.vertical, -10)
                            
                            Divider()
                            
                            Button {
                                //<#code#>
                            } label: {
                                HStack {
                                    Text("Sign out")
                                        .foregroundColor(.black)
                                    Spacer()
                                    Image("power")
                                        .resizable()
                                        .scaledToFit()
                                        .padding(.trailing)
                                    
                                }
                            }.frame(height: 20)
                                .padding(.vertical, -10)
                            
                            Spacer()
                            //
                            
                        }.padding(20)
                        Spacer()
                    }
                    .frame(height: 450)
                    .padding(.vertical)
                    
                    .cornerRadius(10)
                    .background(
                        LinearGradient(
                            gradient: Gradient(
                                colors: [
                                    Color(UIColor(hexString: "#CBD3FB")), .white
                                ]
                            ),
                            startPoint: .top, endPoint: .bottom
                        )
                    )
                    .cornerRadius(8)
                    .padding()
                    Spacer()
                }
                
            }
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}



