//
//  SeatSelectionView.swift
//  FutalaLake
//
//  Created by Abhayjeet Singh on 02/01/23.
//

import SwiftUI

enum TicketTypeButtonState:  CaseIterable, Codable {
    case seating
    case standing
    case group
}

struct SeatSelectionView: View {
    @State private var gateSelection = "GATE NO. 1"
    @State private var showToast = false
    private let gates = Constants.GATES
    
    @State var maturityType: String = "Adult"
    
    
    @State private var isSeating = true
    
    @State var noOfAdults = "0"
    @State var noOfChildren = "0"
    @State var total = "0"
    
    @State var isPresented: Bool = false
    
    @ObservedObject var seatLayoutViewModel = SeatLayoutViewModel()
    
    @State var setas = [Seats]()
    
    @State var ticketTypeButtonState:TicketTypeButtonState = .seating
    
    
    
    
    private var showDate: String
    private var showTimeID: String
    private var showDayID: String
    private var showStartTime: String
    private var showEndTime: String
    
    private var seatInventoryData:[SeatInventoryData] = [SeatInventoryData]()
    init(showDate: Date, showTimeID: String, showDayID: String, showStartTime: String, showEndTime: String, seatInventoryData: [SeatInventoryData]) {
        self.seatInventoryData = seatInventoryData
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
                
                VStack(spacing: 5) {
                    HStack {
                        Text("Date")
                        Spacer()
                        Text("Show Time")
                    }
                    .font(.system(size: 16, weight: .regular, design: .default))
                    .padding(.horizontal)
                    
                    HStack {
                        Text(CommonUtil.showDate(date: showDate))
                        Spacer()
                        Text(CommonUtil.convertTimeTwentyFourIntoTwelve(time: showStartTime) ?? "")
                    }
                    .font(.system(size: 20, weight: .medium, design: .default))
                    .padding(.horizontal)
                    .padding(.vertical, 3)
                }
                .padding(.bottom)
                .background(AppTheme.appThemeBlue)
                .foregroundColor(AppTheme.appThemeRed)
                
                
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
                            //self.seatLayoutViewModel.appllyFilterByGate(gameNo: gateSelection)
                            self.seatLayoutViewModel.appllyFilterByGateForSectionList(gateNo: gateSelection)
                        })
                        //showToast = true
                    }
                    .pickerStyle(.menu)
                    .background(.white)
                    .padding(.trailing)
                    
                }
                
                .frame(width: UIScreen.main.bounds.width, height: 45)
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
                    .padding(.top, -10)
                
                // Seat type selection
                
                VStack {
                    HStack(alignment: .center, spacing: -10) {
                        Spacer()
                        Button {
                            //isSeating = true
                            ticketTypeButtonState = .seating
                        } label: {
                            Text("Seating")
                                .foregroundColor(.black)
                        }
                        .frame(width: 100)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 10)
                            .background(
                                Rectangle()
                                    .fill(ticketTypeButtonState == .seating ? AppTheme.appThemeOrange: .white )
                                .cornerRadius(5)
                                 .shadow(
                                  color: Color.gray.opacity(0.7),
                                  radius: 8,
                                  x: 0, y: 0)
                                 )
                            .padding(.horizontal, 10)
                            
                        
                        
                        
                        Button {
                            //isSeating = false
                            ticketTypeButtonState = .standing
                            isPresented = true
                        } label: {
                            Text("Standing")
                                .foregroundColor(.black )
                        }
                        .frame(width: 100)
                        .padding(.all, 10)
                            .background(
                                Rectangle()
                                    .fill(ticketTypeButtonState == .standing ? AppTheme.appThemeOrange : .white  )
                                .cornerRadius(5)
                                 .shadow(
                                  color: Color.gray.opacity(0.7),
                                  radius: 8,
                                  x: 0, y: 0)
                                 )
                            .padding(.horizontal, 10)

                        
                        
                        Button {
                            ticketTypeButtonState = .group
                            seatLayoutViewModel.isGroupPresented = true
                        } label: {
                            Text("Group")
                                .foregroundColor(.black)
                        }
                        .frame(width: 100)
                        .padding(.all, 10)
                            .background(
                                Rectangle()
                                    .fill(ticketTypeButtonState == .group ? AppTheme.appThemeOrange  : .white )
                                .cornerRadius(5)
                                 .shadow(
                                  color: Color.gray.opacity(0.7),
                                  radius: 8,
                                  x: 0, y: 0)
                                 )
                            .padding(.horizontal, 10)
                        
                        Spacer()

                        
                        
                    }
                    
                .padding(.all, 10)
                //.background(.red)
                    HStack {
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
                        
                        Spacer()
                        
                        if ticketTypeButtonState == .group {
                            HStack {
                                Text(seatLayoutViewModel.groupSeats)
                                Text(" | ")
                                Text("\(Global.GroupTiketing.TOTAL_GROUP_SELECTED_COUNT)")
                                    .padding(.trailing, 40)
                            }
                            
                        }
                    }
                    
                    
                }
                
                
                Image("wave")
                    .resizable()
                    .frame(width: (UIScreen.main.bounds.width - 40), height: 40)
                    .padding(.vertical)
                    
                
                
                Text(gateSelection)
                    .font(.system(size: 20, weight: .medium, design: .default))
                
                ScrollView {
                    
                    ScrollView(.horizontal) {
                        VStack(spacing: -5) {
                            HStack(spacing: 0) {
                                if let data = seatLayoutViewModel.gateWithSections {
                                    ForEach(data.sections) { item in
                                        if let safeData = item.seats {
                                            if ticketTypeButtonState == .group {
                                                GateSectionView(data: safeData, maturityStatus: $maturityType, rowCountInASection: item.rowCount, groupSeats: seatLayoutViewModel.groupSeats, groupStanding: seatLayoutViewModel.groupStanding, isGroupTicketing: true, gateWithSections: data)
                                                Image("stair")
                                                    .resizable()
                                                    .frame(width: 80)
                                            } else {
                                                GateSectionView(data: safeData, maturityStatus: $maturityType, rowCountInASection: item.rowCount, groupSeats: "0", groupStanding: "0", isGroupTicketing: false)
                                                Image("stair")
                                                    .resizable()
                                                    .frame(width: 80)
                                            }
                                            
                                        }
                                    }
                                }
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
                    
                    ScrollView(.horizontal) {
                        HStack(alignment: .top, spacing: 7) {
                            
                            ForEach(0..<(seatInventoryData.count)) { index in
                                Rectangle()
                                    .fill(AppTheme.SeatColor.isColorMatched(colorName: seatInventoryData[index].colorName ?? ""))
                                    .frame(width: 18, height: 18)
                                
                                Text(seatInventoryData[index].seatType ?? "")
                                //Text(seatInventoryData[index].colorName ?? "")
                                    .font(.system(size: 15, weight: .regular, design: .default))
                                    .foregroundColor(.black)
                                
                                Spacer()
                            }
                            
                        }
                        .padding(.horizontal, 18)
                        .padding(.vertical, 10)
                    }
                    
                    
                    Group {
                        Button {
                            
                            seatLayoutViewModel.standingAdultCount = self.noOfAdults
                            seatLayoutViewModel.standingChildCount = self.noOfChildren
                            seatLayoutViewModel.showStartTime = self.showStartTime
                            seatLayoutViewModel.showEndTime = self.showEndTime
                            if seatLayoutViewModel.validate(isSeating: self.isSeating) {
                                seatLayoutViewModel.submitAction()
                            }
                            
                            self.showToast = seatLayoutViewModel.showAlert
                            
                            
                        } label: {
                            Text("Book Ticket")
                            .modifier(CustomButtonModifiers())
                        }.padding(.top, 40)
                        
                        NavigationLink(isActive: $seatLayoutViewModel.shouldMoveToCheckoutView) {
                            CheckoutVIew(bookingData: seatLayoutViewModel.submitResponseData, dataDic: seatLayoutViewModel.bookedDataDic)
                        } label: {
                            
                        }.navigationTitle("Seat Layout")
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
            
            if seatLayoutViewModel.isGroupPresented {
                GroupInputDialogView(standing: $seatLayoutViewModel.standings, isGroupDialogPresented: $seatLayoutViewModel.isGroupPresented, groupSeats: $seatLayoutViewModel.groupSeats, groupStanding: $seatLayoutViewModel.groupStanding, minVal: seatLayoutViewModel.minGroupValue, maxVal: seatLayoutViewModel.maxGroupValue, ticketTypeButtonState: $ticketTypeButtonState)
            }
            
            if self.seatLayoutViewModel.isLoading {
                Loader()
            }
            
            
        }.allowsHitTesting(seatLayoutViewModel.isLoading ? false : true)
        .onAppear {
            seatLayoutViewModel.updateParameters(showDate: showDate, showTimeID: showTimeID, showDayID: showDayID)
            Global.GroupTiketing.TOTAL_GROUP_SELECTED_COUNT = 0
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                VStack {
                    Text("Seat layout").font(.subheadline)
                }.foregroundColor(.white)
            }
        }
        
//        .toolbar { // <2>
//            ToolbarItem(placement: .navigationBarTrailing) {
//                TopNavItemView()
//            }
//        }
        .onAppear {
            //seatLayoutViewModel.getSeatMasterData()
            self.seatLayoutViewModel.getReservedSeatData()
            
        }
        
        
    }
}

struct SeatSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        SeatSelectionView(showDate: Date(), showTimeID: "", showDayID: "", showStartTime: "", showEndTime: "", seatInventoryData: [SeatInventoryData()])
    }
}
