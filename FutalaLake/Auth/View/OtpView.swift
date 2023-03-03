//
//  LoginView.swift
//  FutalaLake
//
//  Created by Abhayjeet Singh on 08/12/22.
//

import SwiftUI

struct OtpView: View {
    //@State var mobileNumber:String = ""
    @Binding var isLogggedIn : Bool
    @State var otp:String
    var body: some View {
        ZStack {
//            Image("launch_background")
//                .resizable()
//                .edgesIgnoringSafeArea(.all)
            AppTheme.appThemeSkyBlue
                .edgesIgnoringSafeArea(.all)
                .overlay(alignment: .topTrailing) {
                    Image("login_top_img")
                    
                        .padding([.trailing], -20)
                }
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                VStack(spacing: 4) {
                    Text("Welcome to")
                        .font(.system(size: 22, weight: .medium, design: .default))
                    
                    Text("Futala Fountain Show")
                        .font(.system(size: 30, weight: .heavy, design: .default))
                        //.foregroundColor(.red)
                }
                .foregroundColor(.white)
                .padding(.top, 30)
                Spacer()
                
                
                    Text("OTP").padding(.vertical, 20)
                        .font(.system(size: 20, weight: .medium, design: .default))
                        .foregroundColor(Color.black)
                    
                
                
                
                VStack(alignment: .leading) {
                    Text("OTP")
                        .font(.system(size: 22, weight: .medium, design: .default))
                    
                    HStack(spacing: 0) {
                        HStack {
                            Image("mobile")
                                //.resizable()
                                //.frame(width: 25, height: 25)
                                .padding(.trailing, 25)
                        }
                        .frame(height: 45)
                        .padding(.leading, 20)
                        .padding(.trailing, 25)
                        
                        .background(AppTheme.appThemeBlue)
                        .clipShape(Capsule())
                        
                        
                        TextField("3456", text: $otp)
                            .keyboardType(.numberPad)
                            .frame(height: 45)
                                .textFieldStyle(PlainTextFieldStyle())
                                .padding([.horizontal], 25)
                                //.background(Color.white)
                                .background(
                                        Rectangle()
                                            .fill(Color.white)
                                            .shadow(
                                                color: Color.gray.opacity(0.7),
                                                radius: 8,
                                                x: 0,
                                                y: 0
                                             )
                                    )
                                .cornerRadius(25)
                                .overlay(RoundedRectangle(cornerRadius: 25).stroke(Color.white))
                                //.padding([.horizontal], 24)
                                .padding(.leading, -40)
                    }
                    
                }.padding(.horizontal, 20)
                
                
                Button {
                    //
                } label: {
                    Text("Resend OTP")
                                .underline()
                                .font(.system(size: 18, weight: .medium, design: .default))
                                .foregroundColor(.black)
                }.padding(20)

                
//                NavigationLink {
//                    TabContainerView()
//                } label: {
//                    Text("Login")
//                        .modifier(CustomButtonModifiers())
//                }
                
                Button {
                    isLogggedIn = true
                } label: {
                    Text("SUBMIT")
                        .modifier(CustomButtonModifiers())
                }

                

                Spacer()
                
            }
            
        }
    }
}

struct OtpView_Previews: PreviewProvider {
    static var previews: some View {
        OtpView(isLogggedIn: .constant(false), otp: "")
    }
}
