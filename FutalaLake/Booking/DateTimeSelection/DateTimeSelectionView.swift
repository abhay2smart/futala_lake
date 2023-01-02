//
//  DateTimeSelectionView.swift
//  FutalaLake
//
//  Created by Abhayjeet Singh on 30/12/22.
//

import SwiftUI

class CalendarData: ObservableObject{
        
   @Published var selectedDate : Date = Date()
   @Published var titleOfMonth : Date = Date()
   @Published var crntPage: Date = Date()
        
}


struct DateTimeSelectionView: View {
    @ObservedObject private var calendarData = CalendarData()
    
    @State private var currentTimeSlotSelected = "06:30"
    
    private var timeSlot: [String] = ["06:30", "07:30", "08:00", "08:30", "09:00", "10:00", "10:30", "11:30"]
    
    var strDateSelected: String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale.current
        return dateFormatter.string(from: calendarData.selectedDate)
    }
    
    var strMonthTitle: String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM yyyy"
        dateFormatter.locale = Locale.current
        return dateFormatter.string(from: calendarData.titleOfMonth)
    }
    
    var body: some View {
        ScrollView {
            Text("Select Date")
                .font(.system(size: 20, weight: .medium, design: .default))
                                    .foregroundColor(AppTheme.appThemeOrange)
                                    .padding(.top, 20)
            
            ZStack(alignment: .top) {
                VStack {
                    CustomCalendarView(dateSelected: $calendarData.selectedDate, mnthNm: $calendarData.titleOfMonth, pageCurrent: $calendarData.crntPage)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 25.0)
                                .foregroundColor(.white)
                                .shadow(color: Color.black.opacity(0.2), radius: 10.0, x: 0.0, y: 0.0)
                        )
                        .frame(height: 280)
                        .padding(15)
                    
                }
                
                HStack {
                    Button(action: {
                                        
                        self.calendarData.crntPage = Calendar.current.date(byAdding: .month, value: -1, to: self.calendarData.crntPage)!
                        
                    }) { Image(systemName: "arrow.left") }
                        .frame(width: 35, height: 35, alignment: .leading)
                    
                    Spacer()
                    
                    Button(action: {
                        
                        self.calendarData.crntPage = Calendar.current.date(byAdding: .month, value: 1, to: self.calendarData.crntPage)!
                        
                    }) { Image(systemName: "arrow.right") }
                    .frame(width: 35, height: 35, alignment: .trailing)
                    
                    
                }.padding(.horizontal, 50)
                    .padding(.vertical, 30)
            }.padding(.top, -10)
            
            VStack(alignment: .leading) {
                Text("Select Time:")
                    .multilineTextAlignment(.leading)
                    .font(.system(size: 20, weight: .medium, design: .default))
                                        .foregroundColor(AppTheme.appThemeOrange)
                
                VStack(alignment: .leading, spacing: 15) {
                    HStack {
                        ForEach(0..<4) { index in
                            Button {
                                self.currentTimeSlotSelected = (timeSlot[index])
                            } label: {
                                Text("\(timeSlot[index]) PM")
                                    .foregroundColor(.white)
                                    .font(.system(size: 16, weight: .medium, design: .default))
                            }.frame(width: 74)
                                .padding(.horizontal, 6)
                                    .padding(.vertical, 10)
                                    .background(currentTimeSlotSelected == timeSlot[index] ?  AppTheme.appThemeOrange :AppTheme.appThemeBlue)
                                    .cornerRadius(2)
                        }
                        
                        
                        

                    }
                    
                    HStack {
                        ForEach(4..<timeSlot.count) { index in
                            Button {
                                self.currentTimeSlotSelected = (timeSlot[index])
                            } label: {
                                Text("\(timeSlot[index]) PM")
                                    .foregroundColor(.white)
                                    .font(.system(size: 16, weight: .medium, design: .default))
                            }
                            .frame(width: 74)
                            .padding(.horizontal, 6)
                                .padding(.vertical, 10)
                                .background(currentTimeSlotSelected == timeSlot[index] ?  AppTheme.appThemeOrange :AppTheme.appThemeBlue)
                                .cornerRadius(2)
                        }
                    }
                }
            }.padding(.horizontal, 10)
            
            
            NavigationLink {
                SeatSelectionView()
            } label: {
                Text("Submit")
            }
            .modifier(CustomButtonModifiers())
            .padding(.top, 30)
                .padding(.horizontal, -5)
            
            
                        
            
        }
    }
}

struct DateTimeSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        DateTimeSelectionView()
    }
}
