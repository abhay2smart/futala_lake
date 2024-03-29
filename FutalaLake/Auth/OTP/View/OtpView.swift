//
//  LoginView.swift
//  FutalaLake
//
//  Created by Abhayjeet Singh on 08/12/22.
//

import SwiftUI

struct OtpView: View {
    @State var mobile:String
    @FocusState var isInputActive: Bool
    @ObservedObject var otpVM = OTPViewModel()
    @EnvironmentObject var session: SessionManager
    
    // setting default value for isLoading var
    
    
    init(otp: String, mobile: String) {
        print("OTP recieved \(otp)")
        self.mobile = mobile
        otpVM.otp = otp
    }
    
    
    
    var body: some View {
        ZStack (alignment: .top){
           
            AppTheme.appThemeSkyBlue
            .edgesIgnoringSafeArea(.all)
            
            Image("login_top_img")
            
                .resizable()
                .scaledToFit()
                .frame(width: UIScreen.main.bounds.width)
                .edgesIgnoringSafeArea(.all)
                //.padding(.top, -30)
            
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
                .padding(.bottom, 160)
                
                
                
                Text("OTP")
                    .padding(.bottom, 0)
                    .font(.system(size: 20, weight: .medium, design: .default))
                    .foregroundColor(Color.black)
                
                
                VStack(alignment: .leading) {
                    Text("OTP")
                        .font(.system(size: 20, weight: .medium, design: .default))
                    
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
                        
                        
                        TextField("7897", text: $otpVM.otp)
                            .keyboardType(.numberPad)
                        
                            .focused($isInputActive)
                            .toolbar {
                                ToolbarItemGroup(placement: .keyboard) {
                                    Spacer()
                                    
                                    Button("Done") {
                                        isInputActive = false
                                    }
                                }
                            }
                        
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
                    HStack {
                        Spacer()
                        Button {
                            otpVM.getOTP(mobileNumber: self.mobile)
                        } label: {
                            Text("Resend OTP")
                                .underline()
                                .foregroundColor(AppTheme.appThemeBlue)
                        }
                        Spacer()
                    }.padding(.top, 10)
                    
                }.padding(20)
                
                
                
                
                Group {
                    Button("Submit") {
                        if otpVM.isValidated(otp: otpVM.otp) {
                            otpVM.fetchToeken(mobileNumber: self.mobile)
                        }
                    }.modifier(CustomButtonModifiers())
                    
//                    NavigationLink(isActive: $loginVM.shouldMoveToOTPView)
//                    {
//                        OtpView()
//                    } label: {
//
//                    }
                    
                }
                
                Spacer()
                
            }
            
            
            
            .toast(message: otpVM.errorMessage,
                   isShowing: $otpVM.showAlert,
                   duration: Toast.short)
            
            
            .navigationTitle("") // remove the text for back button on next screen
            //.navigationBarBackButtonHidden(true)
            
            if otpVM.isLoading {
                Loader()
            }
            
            
        }
        .onChange(of: otpVM.isLoggedIn) { isLoggedIn in
            if isLoggedIn {
                print("some action")
                self.session.signIn()
                
            }
        }
        .allowsHitTesting(otpVM.isLoading ? false : true)
        
    }
}

struct OtpView_Previews: PreviewProvider {
    static var previews: some View {
        OtpView(otp: "4566", mobile: "234234")
    }
}
