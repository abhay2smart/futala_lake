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
                        .padding(.horizontal)
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
                    
                    
                }.frame(width: UIScreen.main.bounds.width, height: 50)
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
                
                // TIME SLOT SECTION
                
                // SEAT LAYOUT SECTION
                //Text("GATE 1")
                
                ScrollView(.horizontal) {
                    VStack(spacing: 25) {
                        HStack {
                            GateSectionView(color: .white, wingTitle: "WING A")
                                .frame(width: 780, height: 220)
                            GateSectionView(color: .white, wingTitle: "WING C")
                                .frame(width: 780, height: 220)
                        }
                        .padding(5)
                        HStack {
                            GateSectionView(color: .white, wingTitle: "WING B")
                                .frame(width: 780, height: 220)
                            GateSectionView(color: .white, wingTitle: "WING D")
                                .frame(width: 780, height: 220)
                        }
                    }
                    .padding(0)
                    
                }
                .padding(.horizontal, 5)
                .padding(.vertical, 30)
                    //.background(.green)
                
                Spacer()
            }
            
        }
    }
}

struct SeatSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        SeatSelectionView()
    }
}
