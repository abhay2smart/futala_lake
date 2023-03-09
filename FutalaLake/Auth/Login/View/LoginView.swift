//
//  LoginView.swift
//  FutalaLake
//
//  Created by Abhayjeet Singh on 08/12/22.
//

import SwiftUI

struct LoginView: View {
    @State var mobileNumber:String = ""
    
    @State var shouldShowDetails:Bool = false
    @Binding var isLogggedIn : Bool
    @ObservedObject var loginVM = LoginVM()
    @FocusState var isInputActive: Bool
    
    
    
    
    
    // setting default value for isLoading var
    init(isLogggedIn: Binding<Bool> = .constant(false) ) {
        _isLogggedIn = isLogggedIn
        
    }
    
    
    var body: some View {
        ZStack {
//            AppTheme.appThemeSkyBlue
//                .edgesIgnoringSafeArea(.all)
//
//                .overlay(alignment: .topTrailing) {
//                    Image("login_top_img")
//
//                        .resizable()
//                        .padding([.leading, .trailing], -1)
//                        .frame(height: 250)
//
//                }
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
                .padding(.bottom, 160)
                
                
                
                Text("Login / Register")
                    .padding(.bottom, 0)
                    .font(.system(size: 20, weight: .medium, design: .default))
                    .foregroundColor(Color.black)
                
                
                VStack(alignment: .leading) {
                    Text("Mobile No.")
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
                        
                        
                        TextField("+91 - 123 456 7899", text: $mobileNumber)
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
                    
                    
                    
                }.padding(20)
                
                
                
                
                Group {
                    Button("Enter") {
                        loginVM.validate(mobileNumber: mobileNumber)
                    }.modifier(CustomButtonModifiers())
                    
                    NavigationLink(isActive: $loginVM.shouldMoveToOTPView) {
                        OtpView(otp: self.loginVM.otp, mobile: self.mobileNumber )
                    } label: {
                        
                    }
                    
                }
                
                Spacer()
                
            }
            
            
            
            .toast(message: loginVM.errorMessage,
                   isShowing: $loginVM.showAlert,
                   duration: Toast.short)
            
            .navigationTitle("") // remove the text for back button on next screen
            
            if loginVM.isLoading {
                Loader()
            }
            
            
        }.allowsHitTesting(loginVM.isLoading ? false : true)
//            .onAppear {
//                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
//                    self.isLoading = false
//                }
//
//            }
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
