//
//  BookedTicketHistoryView.swift
//  FutalaLake
//
//  Created by Abhayjeet Singh on 28/12/22.
//

import SwiftUI

struct BookedTicketHistoryView: View {
    @Environment(\.presentationMode) var presentationMode
    private var data:HistoryData = HistoryData(from: nil)
    @State private var totalAdultsDropDownList = [Int]()
    @State private var totalChildDropDownList = [Int]()
    @State private var adultDropDownSelectedItem:Int = 0
    @State private var childDropDownSelectedItem:Int = 0
    
    @State var isyesButtonPressed = false
    @State var isNoButtonPressed = false
    
    @State var isPresented:Bool = false
    
    @ObservedObject var cancelTicketViewModel = CancelTicketViewModel()
    
    private let adaptiveColumns = [
        GridItem(.adaptive(minimum: 35))
    ]
    
    @State var buttonStatusArr:[Bool] = [Bool]()
    
    @State var buttonStatusSeatingArr:[[Bool]] = [[Bool]]()
    //@State private var isSeating = true // for button toggle
    
    init(data: HistoryData) {
        self.data = data
    }
    
    var body: some View {
        ZStack {
            //AppTheme.appThemeSkyBlue
            
            VStack {
                HStack(alignment: .center) {
                    //Spacer()
                    if (cancelTicketViewModel.historyDetailData.data?.first?.ticketData?.count ?? 0) > 0 {
                        Button {
                            cancelTicketViewModel.isSeating = true
                        } label: {
                            Text("Seating")
                                .foregroundColor(cancelTicketViewModel.isSeating ? .white: .black)
                        }
                        .frame(width: 140)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 10)
                        .background(
                            Rectangle()
                                .fill(cancelTicketViewModel.isSeating ? AppTheme.appThemeOrange: .white )
                                .cornerRadius(5)
                                .shadow(
                                    color: Color.gray.opacity(0.7),
                                    radius: 8,
                                    x: 0, y: 0)
                        )
                        .padding(.horizontal, 10)
                        
                    }
                    
                    if (cancelTicketViewModel.historyDetailData.data?.first?.standing?.count ?? 0) > 0 {
                        Button {
                            cancelTicketViewModel.isSeating = false
                        } label: {
                            Text("Standing")
                                .foregroundColor(cancelTicketViewModel.isSeating ? .black: .white )
                        }
                        .frame(width: 140)
                        .padding(.all, 10)
                        .background(
                            Rectangle()
                                .fill(cancelTicketViewModel.isSeating ? .white: AppTheme.appThemeOrange )
                                .cornerRadius(5)
                                .shadow(
                                    color: Color.gray.opacity(0.7),
                                    radius: 8,
                                    x: 0, y: 0)
                        )
                        .padding(.horizontal, 10)
                    }
                    
                }
                
                ScrollView {
                    
                    if cancelTicketViewModel.isSeating {
                        if (cancelTicketViewModel.historyDetailData.data?.first?.ticketData) != nil {
                            
                            // Seating
                                ForEach(cancelTicketViewModel.ticketData, id: \.self) { item in
                                    if (cancelTicketViewModel.historyDetailData.data?.first) != nil {
                                        CancelTicketSeatingCell(ticketData: item, historyDetailData: (cancelTicketViewModel.historyDetailData.data?.first)!)
                                    }
                                    
                                }
                            
                            // Seat Indicators
                            ScrollView(.horizontal) {
                                HStack(alignment: .top, spacing: 5) {
                                    
                                    let key = Constants.colorKey
                                    if let retrievedCodableObject = UserDefaults.standard.codableObject(dataType: [SeatInventoryData].self, key: key) {
                                        
                                        ForEach(0..<(retrievedCodableObject.count)) { index in
                                            Rectangle()
                                                .fill(AppTheme.SeatColor.isColorMatched(colorName: retrievedCodableObject[index].colorName ?? ""))
                                                .frame(width: 15, height: 15)
                                            
                                            Text(retrievedCodableObject[index].seatType ?? "")
                                            //Text(seatInventoryData[index].colorName ?? "")
                                                .font(.system(size: 14, weight: .regular, design: .default))
                                                .foregroundColor(.black)
                                            
                                            Spacer()
                                        }
                                        
                                    }
                                    
                                    
                                }.padding(.horizontal, 18)
                                    .padding(.vertical, 10)
                                
                                
                            }.padding(.bottom)
                            
                            }
                        
                    } else {
                        if let data = cancelTicketViewModel.historyDetailData.data?.first {
                            CancelTicketStanding(data: data, standingParams: cancelTicketViewModel.standingParams)
                        }
                        
                    }
                
                    
                    
                    
                    
                }
                
                Button {
                    isPresented.toggle()
                } label: {
                    Text("Cancel")
                        .modifier(CustomButtonModifiers())
                }.padding(.vertical)
                .onChange(of: isyesButtonPressed, perform: { value in
                    if value {
                        cancelTicketViewModel.cancelTicket()
                    }
                })
                
                Spacer()
                
                
            }.padding(.top, 100)
            
            
            
            
            
            
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
                        Text(data.showDate ?? "")
                        Spacer()
                        Text(CommonUtil.convertTimeTwentyFourIntoTwelve(time: data.startTime ?? "") ?? "")
                    }.padding(.horizontal)
                    
                    HStack {
                        Text("Ticket Id")
                        Spacer()
                        Text(data.ticketID ?? "")
                    }.padding(.horizontal, 0)
                    
                        .font(.system(size: 18, weight: .medium, design: .default))
                        .padding(.horizontal)
                        .padding(.vertical, 3)
                }.background(AppTheme.appThemeBlue)
                    .foregroundColor(AppTheme.appThemeRed)
                Spacer()
            }
            .onChange(of: isPresented, perform: { value in
                if value == false {
                    presentationMode.wrappedValue.dismiss()
                }
                
            })
            
            .sheet(isPresented: $isPresented) {
                CancelTicketConfirmView(data: data, isYesButtonPressed: $isyesButtonPressed, isNoButtonPressed: $isNoButtonPressed, isPresented: $isPresented, standingAdultCount: adultDropDownSelectedItem, standingChildCount: childDropDownSelectedItem)
            }
            
            .navigationBarTitle("Cancel Ticket")
            
            
        }.onAppear {
            
            

            
            //cancelTicketViewModel.getHistoryDetails(bookingId: data.bookingID ?? "")
            cancelTicketViewModel.getHistoryDetails(bookingId: data.bookingID ?? "")
            
//            if (cancelTicketViewModel.historyDetailData.data?.first?.ticketData?.count ?? 0) == 0 {
//                isSeating = false
//            } else {
//                isSeating = true
//            }
            
            
            for _ in data.seats ?? []{
                buttonStatusArr.append(false)
            }
            
//            totalAdultsDropDownList.append(0)
//            if data.getStandingAdultNonCancelledCount() > 0 {
//                for i in 1...data.getStandingAdultNonCancelledCount() {
//                    totalAdultsDropDownList.append(i)
//                }
//            }
//
//
//            totalChildDropDownList.append(0)
//            if data.getStandingChildNonCancelledCount() > 0 {
//                for i in 1...data.getStandingChildNonCancelledCount() {
//                    totalChildDropDownList.append(i)
//                }
//            }
            
            
            //totalChildDropDownList = data.getStandingChildNonCancelledCount()
            //self.buttonStatusArr.reversed()
        }
        
        
    }
}

struct BookedTicketHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        BookedTicketHistoryView(data: HistoryData(from: nil))
    }
}



struct CheckboxStyle: ToggleStyle {
    
    func makeBody(configuration: Self.Configuration) -> some View {
        
        return HStack {
            //Image(systemName: configuration.isOn ? "checkmark.square" : "square")
            Image(systemName: "square")
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundColor(configuration.isOn ? .blue : .gray)
                .font(.system(size: 20, weight: .regular, design: .default))
                .background(configuration.isOn ? AppTheme.appThemeBlue : AppTheme.appThemeOrange)
            
            configuration.label
                .multilineTextAlignment(.center)
                .padding(.leading, -27)
                .font(.system(size: 10, weight: .regular, design: .default))
                .foregroundColor(.white)
            
            
        }
        .onTapGesture { configuration.isOn.toggle() }
        
    }
}
