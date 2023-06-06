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
    @State var yesButtonPressed = false
    @State var noButtonPressed = false
    @State var isSignOutButtonPressed = false
    @State var isInstructionBtnPresssed = false
    @State var generalInstrcutionOkBtnPressed = false
    @State var cancellationBtnPressed = false
    @EnvironmentObject var session: SessionManager
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    HStack {
                        Button {
                            isInstructionBtnPresssed = true
                        } label: {
                            HStack {
                                Text("General Instruction")
                                Spacer()
                                Image("instructions")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .scaledToFit()
                                .padding(.trailing)
                            }
                        }
                        
                    }
                    
                    Divider()
                    
                    HStack {
                        Button {
                            cancellationBtnPressed = true
                        } label: {
                            HStack {
                                Text("Refund Cancellation Policy")
                                Spacer()
                                Image("refund_policy")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .scaledToFit()
                                .padding(.trailing)
                            }
                        }
                        
                    }
                    
                    Divider()
                    
                    HStack {
                        Button {
                            isSignOutButtonPressed = true
                            //session.signout()
                        } label: {
                            HStack {
                                Text("Sign out")
                                Spacer()
                                Image("power")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .scaledToFit()
                                .padding(.trailing)
                            }
                        }
                        
                    }
                    Divider()
                    Spacer()
                    
                }.padding()
                    .foregroundColor(.black)
                if isSignOutButtonPressed {
                    AlertViewWithTwoButtons(description: "Do you really want to sign out?",  yesButtonPressed: $yesButtonPressed, noButtonPressed: $noButtonPressed)
                        .onChange(of: yesButtonPressed) { value in
                        if value {
                            session.signout()
                        }
                    }
                    .onChange(of: noButtonPressed) { value in
                        isSignOutButtonPressed = false
                        noButtonPressed = false
                    }
                }
                
                if isInstructionBtnPresssed {
                    PolicyInstruction(title: "General Instructions", description: Constants.StringConstant.instructions, buttonAction: $generalInstrcutionOkBtnPressed)
                        .onChange(of: generalInstrcutionOkBtnPressed) { newValue in
                            isInstructionBtnPresssed = false
                            generalInstrcutionOkBtnPressed = false
                        }
                }
                
                if cancellationBtnPressed {
                    PolicyInstruction(title: "Cancellation Policy", description: Constants.StringConstant.cancellationPolicy, buttonAction: $generalInstrcutionOkBtnPressed)
                        .onChange(of: generalInstrcutionOkBtnPressed) { newValue in
                            cancellationBtnPressed = false
                            generalInstrcutionOkBtnPressed = false
                        }
                }
                
                
                
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Setting")
            
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}



