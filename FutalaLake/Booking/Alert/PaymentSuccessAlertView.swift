//
//  PaymentSuccessAlertView.swift
//  FutalaLake
//
//  Created by Abhayjeet Singh on 04/01/23.
//

import SwiftUI

struct PaymentSuccessAlertView: View {
    var body: some View {
        ZStack {
            AppTheme.appThemeSkyBlue
            VStack {
                VStack(alignment: .center, spacing: 5) {
                    Group {
                        VStack(alignment: .center) {
                            Image("check_gif")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                            
                            
                            Text("Payment Success")
                            .multilineTextAlignment(.center)
                                                .font(.system(size: 20, weight: .medium, design: .default))
                                                .foregroundColor(.black)
                                                .padding(.bottom, 5)
                            
                            Text("We've recieved your payment")
                            .multilineTextAlignment(.center)
                                                .font(.system(size: 20, weight: .regular, design: .default))
                                                .foregroundColor(.blue)
                                                .padding(.bottom, 5)
                        }
                        
                    }
                    
                    Divider()
                        .background(.black)
                        .frame(height: 3)
                        .padding(.vertical)
                    
                    Group {
                        HStack {
                            Spacer()
                            Text("Payment details")
                            .multilineTextAlignment(.center)
                                                .font(.system(size: 16, weight: .medium, design: .default))
                                                .foregroundColor(AppTheme.appThemeOrange)
                                                .padding(.bottom, 5)
                            Spacer()
                        }
                        
                        HStack {
                            Text("Payment Amount")
                            Spacer()
                            Text("₹300")
                        }
                        .font(.system(size: 15, weight: .regular, design: .default))
                        .foregroundColor(.black)
                        .padding(.bottom, 5)
                        
                        Divider()
                        
                        HStack {
                            Text("Payment Date")
                            Spacer()
                            Text("5 Dec - 2022")
                            
                        }
                            
                        .font(.system(size: 15, weight: .regular, design: .default))
                            .foregroundColor(.black)
                            .padding(.vertical, 5)
                        
                        Divider()
                        
                        HStack {
                            Text("Payment Method")
                            Spacer()
                            
                            Text("SBI UPI")
                            
                        }
                        .font(.system(size: 15, weight: .regular, design: .default))
                            .foregroundColor(.black)
                            .padding(.vertical, 5)
                        
                        Divider()
                        
                        HStack {
                            Text("Bank Transfer ID")
                            Spacer()
                            
                            Text("2763876383")
                            
                        }
                        .font(.system(size: 15, weight: .regular, design: .default))
                            .foregroundColor(.black)
                            .padding(.vertical, 5)
                        
                        Divider()
                        
                        
                        HStack {
                            Text("Total Amount")
                            Spacer()
                            
                            Text("₹320")
                            
                        }
                        .font(.system(size: 15, weight: .regular, design: .default))
                            .foregroundColor(.black)
                            .padding(.vertical, 5)
                        
                    }

                    //Divider()
                    
                    // Group is required if adding more items within the stack
                    

                }
                .padding()
                .background(Color(UIColor(hexString: "#C0C5F7")))
                .cornerRadius(10)
                .padding()
                
                
                NavigationLink {
                    QRView()
                } label: {
                    Text("Done")
                        .modifier(CustomButtonModifiers())
                }.navigationTitle("")
                
                
                
                
                Spacer()
            }
            
            
            
        }

    }
}

struct PaymentSuccessAlertView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentSuccessAlertView()
    }
}
