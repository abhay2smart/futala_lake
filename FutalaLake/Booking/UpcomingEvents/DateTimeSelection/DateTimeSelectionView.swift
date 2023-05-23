//
//  DateTimeSelectionView.swift
//  FutalaLake
//
//  Created by Abhayjeet Singh on 30/12/22.
//

import SwiftUI



struct DateTimeSelectionView: View {
    @ObservedObject private var dateTimeSelectionModel = DateTimeSelectionViewModel()
    @State var selectedDate: Date = Date()
    //@State private var currentTimeSlotSelected = ""
    @State private var showTimeId = ""
    @State private var showDayId = ""
    
    @State var selectedShow: Shows?
    
    @State var color = AppTheme.appThemeBlue
    
    @State var test: Bool = false
    
    //@State var shouldMoveToSeatLayout = false
    
    private let adaptiveColumns = [
        GridItem(.adaptive(minimum: 170))
    ]
    
    
    var body: some View {
        ZStack {
            ScrollView {
                Text("Select Date")
                    .font(.system(size: 20, weight: .medium, design: .default))
                    .foregroundColor(AppTheme.appThemeOrange)
                    .padding(.top, 20)
                
                ZStack(alignment: .top) {
                    
                    DatePicker("Select Date", selection: $selectedDate,in: Date()...Date.now.addingTimeInterval((86400 * 15) - 86400), displayedComponents: [.date])
                        .padding(.horizontal)
                        .datePickerStyle(.graphical)
                    
                    
                    //DatePicker("Select Date", selection: $selectedDate, displayedComponents: [.date])
                        //.padding(.horizontal)
                        //.datePickerStyle(.graphical)
                    
                }.padding(.top, -10)
                    .onChange(of: selectedDate) { selectedDate in
                        dateTimeSelectionModel.currentTimeSlotSelected = ""
                        dateTimeSelectionModel.getShowDays(date: selectedDate)
                    }
                
                VStack(alignment: .leading) {
                    Text("Select Time:")
                        .multilineTextAlignment(.leading)
                        .font(.system(size: 20, weight: .medium, design: .default))
                        .foregroundColor(AppTheme.appThemeOrange)
                        .padding(.leading, 10)
                    
                    LazyVGrid(columns: adaptiveColumns, spacing: 10) {
                        
                        
                        if let _ = dateTimeSelectionModel.data {
                            let dataCount = dateTimeSelectionModel.shows?.count ?? 0
                            if let shows = dateTimeSelectionModel.shows {
                                ForEach(Array(shows.enumerated()), id: \.offset) { index, item  in
                                    ZStack {
                                        if checkIsSelectable(startTime: dateTimeSelectionModel.shows?[index].startTime ?? "") {
                                            
                                            Rectangle().frame(width: 170, height: 40)
                                            
                                                .foregroundColor(dateTimeSelectionModel.currentTimeSlotSelected == (dateTimeSelectionModel.shows?[index].startTime ?? "") ? AppTheme.appThemeOrange : AppTheme.appThemeBlue)
                                                .cornerRadius(5)
                                            
                                        } else {
                                            Rectangle().frame(width: 170, height: 40)
                                            
                                                .foregroundColor(dateTimeSelectionModel.currentTimeSlotSelected == (dateTimeSelectionModel.shows?[index].startTime ?? "") ? AppTheme.appThemeOrange : AppTheme.SeatColor.booked)
                                                .cornerRadius(5)
                                        }
                                        
                                        Text("\(dateTimeSelectionModel.shows?[index].startTimeInTwelveHourFormat ?? "") -  \(dateTimeSelectionModel.shows?[index].endTimeInTwelveHourFormat ?? "")")
                                            .foregroundColor(.white)
                                            .font(.system(size: 15, weight: .medium, design: .default))
                                        
                                    }
                                    .allowsHitTesting(checkIsSelectable(startTime: dateTimeSelectionModel.shows?[index].startTime ?? ""))
                                    .onTapGesture {
                                        self.selectedShow = dateTimeSelectionModel.data?[0].shows?[index]
                                        dateTimeSelectionModel.currentTimeSlotSelected = (dateTimeSelectionModel.data?[0].shows?[index].startTime ?? "")
                                        showTimeId = dateTimeSelectionModel.data?[0].shows?[index].showTimeID ?? ""
                                        
                                        showDayId = dateTimeSelectionModel.data?.first?.showDayID ?? ""
                                    }
                                }
                            }
                        }
                    }.padding(.horizontal, 10)
                }.padding(.horizontal, 10)
                
                
                //shouldMoveToSeatLayout
                
                Group {
                    
                    Button {
                        if dateTimeSelectionModel.isValidated() {
                            dateTimeSelectionModel.getSeatMasterData()
                            //dateTimeSelectionModel.getSeatMasterDemo()
                            
                        }
                    } label: {
                        Text("Proceed")
                        .modifier(CustomButtonModifiers())
                    }.padding(.vertical)

                   
                    NavigationLink(isActive: $dateTimeSelectionModel.shouldMoveToSeatLayout) {
                        SeatSelectionView(showDate: selectedDate, showTimeID: showTimeId, showDayID: showDayId, showStartTime: selectedShow?.startTime ?? "", showEndTime: selectedShow?.endTime ?? "", seatInventoryData: dateTimeSelectionModel.seatInventoryData, seatMasterData: dateTimeSelectionModel.masterSeatData ?? SeatData() )
                    } label: {
                        
                    }
                    .navigationTitle("Date & Time")
                }
            }
            
            .toast(message: dateTimeSelectionModel.message,
                   isShowing: $dateTimeSelectionModel.showToast,
                   duration: Toast.short)
            
            if dateTimeSelectionModel.isLoading {
                Loader()
            }
            
        }
        .allowsHitTesting(dateTimeSelectionModel.isLoading ? false : true)
        .onAppear{
            dateTimeSelectionModel.getShowDays(date: selectedDate)
            dateTimeSelectionModel.getAllSeatColor()
            reset()
        }
        
    }
    
    
}


struct DateTimeSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        DateTimeSelectionView()
    }
}

extension DateTimeSelectionView {
    
    private func reset() {
        dateTimeSelectionModel.currentTimeSlotSelected = ""
    }
    
    private func checkIsSelectable(startTime: String)->Bool {
        //let startTimeDate = CommonUtil.getDateFromDateString(date: self.startTime ?? "")
        
        let currentTimeStr = CommonUtil.getCurrentStrTime()
        
        
        
        let diff = CommonUtil.getTimeDiff(currentTimeStr: startTime, endTimeStr: currentTimeStr ?? "")
        
        let currentDate = CommonUtil.todayDate()
        
        let selectedDate = CommonUtil.excludeTimeFromDateDate(date: selectedDate)
        
        
        
        
        if diff >= 0 && selectedDate == currentDate {
            return false
        }
        
        return true
    }
}
