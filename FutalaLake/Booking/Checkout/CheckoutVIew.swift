//
//  CheckoutVIew.swift
//  FutalaLake
//
//  Created by Abhayjeet Singh on 03/01/23.
//

import SwiftUI

struct CheckoutVIew: View {
    var body: some View {
        ZStack {
            AppTheme.appThemeSkyBlue
            VStack {
                VStack(alignment: .leading, spacing: 5) {
                    Group {
                        Text("Checkout Summary")
                        .multilineTextAlignment(.leading)
                                            .font(.system(size: 23, weight: .medium, design: .default))
                                            .foregroundColor(AppTheme.appThemeOrange)
                                            .padding(.bottom, 5)
                        HStack {
                            Text("Show Date")
                            Spacer()
                            Text("11 Dec, 2022")
                        }
                        .font(.system(size: 15, weight: .regular, design: .default))
                        .foregroundColor(.black)
                        .padding(.bottom, 5)
                        
                        Divider()
                        
                        HStack {
                            Text("Show Time")
                            Spacer()
                            Text("07:00 PM")
                            
                        }
                            
                        .font(.system(size: 15, weight: .regular, design: .default))
                            .foregroundColor(.black)
                            .padding(.vertical, 5)
                        
                        Divider()
                        
                        HStack {
                            Text("Ticket Type")
                            Spacer()
                            
                            Text("VIP")
                            
                        }
                        .font(.system(size: 15, weight: .regular, design: .default))
                            .foregroundColor(.black)
                            .padding(.vertical, 5)
                        
                        Divider()
                        
                        HStack {
                            Text("Seat no/NOS")
                            Spacer()
                            
                            Text("D3 45")
                            
                        }
                        .font(.system(size: 15, weight: .regular, design: .default))
                            .foregroundColor(.black)
                            .padding(.vertical, 5)
                        
                        Divider()
                        
                        
                        HStack {
                            Text("Ticket Fee")
                            Spacer()
                            
                            Text("₹13")
                            
                        }
                        .font(.system(size: 15, weight: .regular, design: .default))
                            .foregroundColor(.black)
                            .padding(.vertical, 5)
                        
                    }

                    Divider()
                    
                    // Group is required if adding more items within the stack
                    Group {
                        
                        HStack {
                            Text("Booking Fee")
                            Spacer()
                            
                            Text("₹34")
                            
                        }
                        .font(.system(size: 15, weight: .regular, design: .default))
                            .foregroundColor(.black)
                            .padding(.vertical, 5)
                        
                        Divider()
                        
                        
                        HStack {
                            Text("Tax")
                            Spacer()
                            
                            Text("₹4")
                            
                        }
                        .font(.system(size: 15, weight: .regular, design: .default))
                            .foregroundColor(.black)
                            .padding(.vertical, 5)
                        
                        Divider()
                        
                        HStack {
                            Text("Total")
                            Spacer()
                            
                            Text("₹51")
                            
                        }
                        .font(.system(size: 15, weight: .regular, design: .default))
                            .foregroundColor(.black)
                            .padding(.vertical, 5)
                    }
                
                    

                    
                    

                }
                .padding()
                .background(Color(UIColor(hexString: "#C0C5F7")))
                .cornerRadius(10)
                .padding()
                
                NavigationLink {
                    PayNowView()
                } label: {
                    Text("Checkout")
                        .modifier(CustomButtonModifiers())
                }.navigationTitle("")
                
                
                
                Spacer()
            }
            
            
            
        }
        
    }
}

struct CheckoutVIew_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutVIew()
    }
}
