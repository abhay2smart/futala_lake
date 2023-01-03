//
//  SeatSelectionView.swift
//  FutalaLake
//
//  Created by Abhayjeet Singh on 02/01/23.
//

import SwiftUI

struct SeatSelectionView: View {
    @State private var gateSelection = "0"
    private let gates = ["0", "1", "2", "3", "4", "5", "6"]
    
    var body: some View {
        ZStack {
            Color.white
            
            VStack {
                HStack {
                    Text("GATE")
                        .padding(.horizontal, 15)
                        .font(.system(size: 20, weight: .medium, design: .default))
                        .foregroundColor(AppTheme.appThemeOrange)
                    
                    Spacer()
                    Picker("", selection: $gateSelection) {
                        ForEach(gates, id: \.self) {
                            //Text($0)
                            Text("\((Int($0) ?? 0) + 1)")
                        }
                    }
                    
                    .pickerStyle(.menu)
                    .background(.white)
                    .padding(.trailing)
                    
                    
                }.frame(width: UIScreen.main.bounds.width, height: 45)
                    .background(
                        Rectangle()
                            .fill(Color.white)
                        //.cornerRadius(12)
                            .shadow(
                                color: Color.gray.opacity(0.7),
                                radius: 8,
                                x: 0,
                                y: 0
                            )
                    )
                
                
                ScrollView {
                    
                    ScrollView(.horizontal) {
                        VStack(spacing: -5) {
                            HStack {
                                GateSectionView(color: .white, wingTitle: "WING A")
                                    .frame(width: 780, height: 220)
                                
                                GateSectionView(color: .white, wingTitle: "WING C")
                                    .frame(width: 780, height: 220)
                            }
                            .padding(.top, 10)
                            .padding(.horizontal, 5)
                            
                            HStack {
                                GateSectionView(color: .white, wingTitle: "WING B")
                                    .frame(width: 780, height: 220)
                                
                                GateSectionView(color: .white, wingTitle: "WING D")
                                    .frame(width: 780, height: 220)
                                
                            }.padding(.top, 10)
                                .padding(5)
                                .padding(.bottom, 10)
                        }
                        .padding(.horizontal, 8)
                        
                    }
                    .padding(.horizontal, 0)
                    .padding(.vertical, -10)
                    
                    // color indicator
                    HStack(alignment: .top, spacing: 10) {
                        Rectangle()
                            .fill(.purple)
                            .frame(width: 18, height: 18)
                        
                        Text("Sold")
                            .font(.system(size: 15, weight: .regular, design: .default))
                            .foregroundColor(.black)
                        
                        Spacer()
                        
                        Rectangle()
                            .fill(.green)
                            .frame(width: 18, height: 18)
                        
                        Text("Available")
                            .font(.system(size: 15, weight: .regular, design: .default))
                            .foregroundColor(.black)
                        
                        Spacer()
                        
                        Rectangle()
                            .fill(AppTheme.appThemeOrange)
                            .frame(width: 18, height: 18)
                        
                        Text("Selected")
                            .font(.system(size: 15, weight: .regular, design: .default))
                            .foregroundColor(.black)
                        
                        
                    }
                    .padding(.horizontal, 18)
                    .padding(.vertical, 10)
                    
                    // Submit button
                    
                    NavigationLink {
                        CheckoutVIew()
                    } label: {
                        Text("Book Ticket")
                            .modifier(CustomButtonModifiers())
                    }.padding(.top, 10)
                        .padding(.bottom, 20)
                        .navigationTitle("")
                    
                    Spacer()
                }
            }
            
        }
    }
}

struct SeatSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        SeatSelectionView()
    }
}
