//
//  SettingView.swift
//  FutalaLake
//
//  Created by Abhayjeet Singh on 23/12/22.
//

import SwiftUI

struct SettingView: View {
//    @State private var isWhatsappNoticationOn: Bool = false
//    @State private var isLocationOn: Bool = false
//    @State private var isSavePaymentModeOn: Bool = false
    @EnvironmentObject var session: SessionManager
    var body: some View {
        NavigationView {
            ZStack {
                AppTheme.appThemeSkyBlue
                    //.ignoresSafeArea()
                VStack(spacing: 0) {
                    VStack(spacing: -10) {
                        Group {
//                            Toggle("WhatsApp Notification", isOn: $isWhatsappNoticationOn)
//                                .frame(height: 0)
//                            Divider()
//                            Toggle("Location", isOn: $isLocationOn)
//                                .frame(height: 0)
//
//                            Divider()
//                            Toggle("Save Payment Modes", isOn: $isSavePaymentModeOn)
//                                .frame(height: 0)
//
//                            Divider()
//
//                            Button {
//                                //<#code#>
//                            } label: {
//                                HStack {
//                                    Text("Delete Account")
//                                        .foregroundColor(.black)
//                                    Spacer()
//                                    Image("trash")
//                                        .resizable()
//                                        .scaledToFit()
//                                        .padding(.trailing)
//
//                                }
//                            }.frame(height: 20)
//                                .padding(.vertical, -10)
                            
                            //Divider()
                            
                            
                            HStack {
                                Text("Sign out")
                                    .foregroundColor(.black)
                                Spacer()
                                
                                Button {
                                    print("Sign out button pressed")
                                    session.signout()
                                    
                                } label: {
                                    Image("power")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                        .scaledToFit()
                                        .padding(.trailing)
                                }
                                
                            }.padding(.vertical, -10)
                            .padding(.top, 30)
                            
                            Spacer()
                            //
                            
                        }.padding(20)
                        Spacer()
                    }
                    .frame(maxHeight: 40)
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
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text("Setting").font(.subheadline)
                    }.foregroundColor(.white)
                }
            }
            
//            .toolbar { // <2>
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    TopNavItemView()
//                }
//            }
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}



