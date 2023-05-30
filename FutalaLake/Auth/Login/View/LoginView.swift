//
//  LoginView.swift
//  FutalaLake
//
//  Created by Abhayjeet Singh on 08/12/22.
//

import SwiftUI
import Combine

struct LoginView: View {
    @EnvironmentObject var session: SessionManager
    @State var mobileNumber:String = "8173954048"
    //@State var mobileNumber:String = ""
    
    @State var shouldShowDetails:Bool = false
    @Binding var isLogggedIn : Bool
    @ObservedObject var loginVM = LoginVM()
    @FocusState var isInputActive: Bool
    
    
    
    // setting default value for isLoading var
    init(isLogggedIn: Binding<Bool> = .constant(false) ) {
        _isLogggedIn = isLogggedIn
        
    }
    
    
    var body: some View {
        ZStack(alignment: .top) {
            
            AppTheme.appThemeSkyBlue
            .edgesIgnoringSafeArea(.all)
            
            Image("login_top_img")
            
                .resizable()
                .scaledToFit()
                .frame(width: UIScreen.main.bounds.width)
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
                .padding(.bottom, 160)
                
                
                
                Text("Login")
                    .padding(.bottom, 0)
                    .font(.system(size: 20, weight: .medium, design: .default))
                    .foregroundColor(Color.black)
                
                
                VStack(alignment: .leading) {
                    Text("Mobile No.")
                        .font(.system(size: 20, weight: .medium, design: .default))
                    
                    HStack(spacing: 0) {
                        
                        TextField("Mobile No.", text: $mobileNumber)
                            .onReceive(Just(mobileNumber)) { _ in limitText(10) }
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
                            .padding(.leading, 0)
                            .padding(.trailing, -35)
                        
                        HStack {
                            //Image("mobile")
                            //.padding(.trailing, 20)
                            if loginVM.isOTPRecieved {
                                Image("check_green")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                            } else {
                                Button {
                                if loginVM.isValidatedMobile(mobileNumber: mobileNumber) {
                                    loginVM.getOTP(mobileNumber: mobileNumber)
                                }
                                    
                                } label: {
                                    Text("GET OTP")
                                    .font(.system(size: 12, weight: .regular, design: .default))
                                    .foregroundColor(.white)
                                    .padding(.leading, 0)
                                }
                            }
                            

                            
                        }
                        .frame(width: 60, height: 45)
                        .padding(.leading, 20)
                        .padding(.trailing, 25)
                        
                        .background(AppTheme.appThemeBlue)
                        .clipShape(Capsule())
                    }
                    
                    if loginVM.isOTPRecieved {
                        TextField("OTP", text: $loginVM.otp)
                            .keyboardType(.numberPad)
                        
                            .focused($isInputActive)
//                            .toolbar {
//                                ToolbarItemGroup(placement: .keyboard) {
//                                    Spacer()
//
//                                    Button("Done") {
//                                        isInputActive = false
//                                    }
//                                }
//                            }
                        
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
                            .padding(.vertical)
                        
                        HStack {
                            Spacer()
                            
                            if loginVM.isTimerFinished {
                                Button {
                                    if loginVM.isValidatedMobile(mobileNumber: mobileNumber) {
                                        loginVM.getOTP(mobileNumber: mobileNumber)
                                    }
                                } label: {
                                    Text("Resend OTP")
                                        .underline()
                                        .foregroundColor(AppTheme.appThemeBlue)
                                }
                                
                            } else {
                                Text("Resend OTP in: \(loginVM.displayCountDown)")
                            }
                            Spacer()
                        }.padding(.top, 0)
                    }
                    
                }.padding(20)
                
                Group {
                    Button {
                        loginVM.startCountdown()
                        if loginVM.isValidatedMobileAndOTP(otp: loginVM.otp, mobileNumber: self.mobileNumber) {
                            loginVM.fetchToeken(mobileNumber: self.mobileNumber)
                        }
                        
                    } label: {
                        Text("Login")
                            .frame(maxWidth: .infinity)
                            .frame(height: 45)
                            .foregroundColor(loginVM.isOTPRecieved ? .white: .gray)
                            .background(AppTheme.appThemeOrange)
                            .clipShape(Capsule())
                            .padding(.horizontal)
                            .font(.system(size: 20, weight: .regular, design: .default))
                        
                    }.disabled(loginVM.isOTPRecieved ? false : true)
                    
                    
                    NavigationLink(isActive: $loginVM.shouldMoveToOTPView) {
                        OtpView(otp: self.loginVM.otp, mobile: self.mobileNumber )
                    } label: {
                        
                    }
                }
                
                Spacer()
                
            }
            
            .onChange(of: loginVM.isLoggedIn) { isLoggedIn in
                if isLoggedIn {
                    print("some action")
                    self.session.signIn()
                    
                }
            }
            
            
            
            .toast(message: loginVM.errorMessage,
                   isShowing: $loginVM.showAlert,
                   duration: Toast.short)
            
            .navigationTitle("") // remove the text for back button on next screen
            
            if loginVM.isLoading {
                Loader()
            }
            
            
        }.allowsHitTesting(loginVM.isLoading ? false : true)
        
    }
    
    //Function to keep text length in limits
    func limitText(_ upper: Int) {
        if mobileNumber.count > upper {
            mobileNumber = String(mobileNumber.prefix(upper))
        }
    }
    
    
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}




