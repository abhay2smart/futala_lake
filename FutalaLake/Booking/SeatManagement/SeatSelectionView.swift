//
//  SeatSelectionView.swift
//  FutalaLake
//
//  Created by Abhayjeet Singh on 02/01/23.
//

import SwiftUI

struct SeatSelectionView: View {
    @State private var gateSelection = "0"
    @State private var showToast = false
    private let gates = ["0", "1", "2", "3", "4", "5", "6"]
    
    @State var maturityType: String = "Adult"
    
    
    @State private var isSeating = true
    
    @State var noOfAdults = "0"
    @State var noOfChildren = "0"
    @State var total = "0"
    
    @State var isPresented: Bool = false
    
    @StateObject var seatLayoutViewModel = SeatLayoutViewModel()
    
    @State var setas = [Seats]()
    
    var body: some View {
        ZStack {
            Color.white
            
            VStack {
                HStack {
                    Text("GATE")
                        .padding(.leading, 23)
                        .font(.system(size: 20, weight: .medium, design: .default))
                        .foregroundColor(AppTheme.appThemeOrange)
                    
                    Spacer()
                    Picker("", selection: $gateSelection) {
                        ForEach(gates, id: \.self) {
                            //Text($0)
                            Text("\((Int($0) ?? 0) + 1)")
                        }
                    }.onReceive([self.gateSelection].publisher.first()) { value in
                        showToast = true
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
                
                // Seat type selection
                
                
                VStack {
                    HStack(alignment: .center) {
                        //Spacer()
                        Button {
                            isSeating = true
                        } label: {
                            Text("Seating")
                                .foregroundColor(isSeating ? .white: .black)
                        }
                        .frame(width: 140)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 10)
                            .background(
                                Rectangle()
                                    .fill(isSeating ? AppTheme.appThemeOrange: .white )
                                .cornerRadius(5)
                                 .shadow(
                                  color: Color.gray.opacity(0.7),
                                  radius: 8,
                                  x: 0, y: 0)
                                 )
                            .padding(.horizontal, 10)
                            
                        
                        Spacer()
                        
                        Button {
                            isSeating = false
                            isPresented = true
                        } label: {
                            Text("Standing")
                                .foregroundColor(isSeating ? .black: .white )
                        }
                        .frame(width: 140)
                        .padding(.all, 10)
                            .background(
                                Rectangle()
                                .fill(isSeating ? .white: AppTheme.appThemeOrange )
                                .cornerRadius(5)
                                 .shadow(
                                  color: Color.gray.opacity(0.7),
                                  radius: 8,
                                  x: 0, y: 0)
                                 )
                            .padding(.horizontal, 10)

                    }
                    
                .padding(.all, 10)
                //.background(.red)
                    if isSeating {
                        HStack {
                            RadioButtonGroup(items: ["Adult", "Child"], selectedId: maturityType) { selected in
                                maturityType = selected
                                print("Selected is: \(selected)")
                                
                            }
                            .frame(width: 200, height: 10)
                            .padding(.leading, 20)
                            Spacer()
                        }.padding(.bottom)
                    }
                    
                }
                
                
                ScrollView {
                    
                    ScrollView(.horizontal) {
                        VStack(spacing: -5) {
                            
                            HStack {
                                GateSectionView(data: seatLayoutViewModel.totalSeats)
                                    .frame(width: 780)
                            }
                            .padding(.top, 10)
                            .padding(.horizontal, 5)
                            
                        }
                        .padding(.horizontal, 8)
                        .padding(.bottom)
                        
                    }
                    .padding(.horizontal, 0)
                    .padding(.vertical, -10)
                    .padding(.top)
                    
                    
                    // color indicator
                    HStack(alignment: .top, spacing: 10) {
                        Rectangle()
                            .fill(.purple)
                            .frame(width: 18, height: 18)
                        
                        Text("Booked")
                            .font(.system(size: 15, weight: .regular, design: .default))
                            .foregroundColor(.black)
                        
                        Spacer()
                        
                        Rectangle()
                            .fill(.green)
                            .frame(width: 18, height: 18)
                        
                        Text("Selected")
                            .font(.system(size: 15, weight: .regular, design: .default))
                            .foregroundColor(.black)
                        
                        Spacer()
                        
                        Text("VIP")
                            .font(.system(size: 15, weight: .regular, design: .default))
                            .foregroundColor(.black)
                        
                        Spacer()
                        
                        Rectangle()
                            .fill(AppTheme.appThemeOrange)
                            .frame(width: 18, height: 18)
                        
                        Text("Classic")
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
                        .navigationTitle("Seat Layout")
                    
                    Spacer()
                }
            }
            
            
            
            .toast(message: "GATE \((Int(gateSelection) ?? 0) + 1) IS SELECTED",
                   isShowing: $showToast,
                   duration: Toast.short)
            if isPresented {
                StandingInputDialog(noOfAdults: $noOfAdults, noOfChildren: $noOfChildren, total: $total, isPresented: $isPresented)
            }
            
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                VStack {
                    Text("Seat layout").font(.subheadline)
                }.foregroundColor(.white)
            }
        }
        
        .toolbar { // <2>
            ToolbarItem(placement: .navigationBarTrailing) {
                TopNavItemView()
            }
        }
        .onAppear {
            seatLayoutViewModel.getSeatMasterData()
        }
        
    }
}

struct SeatSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        SeatSelectionView()
    }
}
