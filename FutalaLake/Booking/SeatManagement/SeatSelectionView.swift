//
//  SeatSelectionView.swift
//  FutalaLake
//
//  Created by Abhayjeet Singh on 02/01/23.
//

import SwiftUI

struct SeatSelectionView: View {
    @State private var gateSelection = "GATE NO. 1"
    @State private var showToast = false
    private let gates = ["GATE NO. 1", "GATE NO. 2", "GATE NO. 3", "GATE NO. 4", "GATE NO. 5", "GATE NO. 6", "GATE NO. 7"]
    
    @State var maturityType: String = "Adult"
    
    
    @State private var isSeating = true
    
    @State var noOfAdults = "0"
    @State var noOfChildren = "0"
    @State var total = "0"
    
    @State var isPresented: Bool = false
    
    @ObservedObject var seatLayoutViewModel = SeatLayoutViewModel()
    
    @State var setas = [Seats]()
    
    private var showDate: String
    private var showTimeID: String
    private var showDayID: String
    private var showStartTime: String
    private var showEndTime: String
    
    
    init(showDate: Date, showTimeID: String, showDayID: String, showStartTime: String, showEndTime: String) {
        let dateFormatter = DateFormatter()
        // Set Date Format
        dateFormatter.dateFormat = "yyyy-MM-dd"
        // Convert Date to String
        let dateString = dateFormatter.string(from: showDate)
        
        self.showDate   = dateString
        self.showTimeID = showTimeID
        self.showDayID  = showDayID
        self.showStartTime  = showStartTime
        self.showEndTime  = showEndTime
        
    }
    
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
                        ForEach(gates, id: \.self) { item in
                            //Text($0)
                            Text(item)
                        }
                    }.onReceive([self.gateSelection].publisher.first()) { value in
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4, execute: {
                            self.seatLayoutViewModel.appllyFilterByGate(gameNo: gateSelection)
                        })
                        //showToast = true
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
                                GateSectionView(data: $seatLayoutViewModel.totalFilteredSeats, maturityStatus: $maturityType)
                                    .frame(width: 820)
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
                    
//                    NavigationLink {
//                        CheckoutVIew()
//                    } label: {
//                        Text("Book Ticket")
//                            .modifier(CustomButtonModifiers())
//                    }.padding(.top, 10)
//                        .padding(.bottom, 20)
//                        .navigationTitle("Seat Layout")
                    
                    
                    Group {
                        Button {
                            
                            seatLayoutViewModel.standingAdultCount = self.noOfAdults
                            seatLayoutViewModel.standingChildCount = self.noOfChildren
                            seatLayoutViewModel.showStartTime = self.showStartTime
                            seatLayoutViewModel.showEndTime = self.showEndTime
                            if seatLayoutViewModel.validate() {
                                seatLayoutViewModel.submitAction()
                            }
                            
                            self.showToast = seatLayoutViewModel.showAlert
                            
                            
                        } label: {
                            Text("Book Ticket")
                            .modifier(CustomButtonModifiers())
                        }
                        
                        NavigationLink(isActive: $seatLayoutViewModel.shouldMoveToCheckoutView) {
                            CheckoutVIew(bookingData: seatLayoutViewModel.submitResponseData, dataDic: seatLayoutViewModel.bookedDataDic)
                        } label: {
                            
                        }
                    }
                    
                    Spacer()
                }
            }
            .toast(message: self.seatLayoutViewModel.errorMessage,
                   isShowing: $showToast,
                   duration: Toast.short)
            if isPresented {
                StandingInputDialog(noOfAdults: $noOfAdults, noOfChildren: $noOfChildren, total: $total, isPresented: $isPresented)
            }
            if self.seatLayoutViewModel.isLoading {
                Loader()
            }
            
            
        }.allowsHitTesting(seatLayoutViewModel.isLoading ? false : true)
        .onAppear {
            seatLayoutViewModel.updateParameters(showDate: showDate, showTimeID: showTimeID, showDayID: showDayID)
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
            //seatLayoutViewModel.getSeatMasterData()
            self.seatLayoutViewModel.getReservedSeatData()
            
        }
        
        
    }
}

struct SeatSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        SeatSelectionView(showDate: Date(), showTimeID: "", showDayID: "", showStartTime: "", showEndTime: "")
    }
}
