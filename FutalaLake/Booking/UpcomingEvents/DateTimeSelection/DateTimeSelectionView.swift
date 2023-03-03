//
//  DateTimeSelectionView.swift
//  FutalaLake
//
//  Created by Abhayjeet Singh on 30/12/22.
//

import SwiftUI



struct DateTimeSelectionView: View {
    @State var selectedDate: Date = Date()
    @State private var currentTimeSlotSelected = "06:30"
    private var timeSlot: [String] = ["06:30", "07:30", "08:00", "08:30", "09:00", "10:00", "10:30", "11:30"]
    
    var body: some View {
        ScrollView {
            Text("Select Date")
                .font(.system(size: 20, weight: .medium, design: .default))
                                    .foregroundColor(AppTheme.appThemeOrange)
                                    .padding(.top, 20)
            
            ZStack(alignment: .top) {
                
                DatePicker("Select Date", selection: $selectedDate,in: Date()..., displayedComponents: [.date])
                    .padding(.horizontal)
                    .datePickerStyle(.graphical)
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
                    .modifier(CustomButtonModifiers())
            }
            .navigationTitle("Calendar")
            
            .padding(.top, 30)
                .padding(.horizontal, 13)
                
            
            
            .navigationBarTitleDisplayMode(.inline)
            
                    .toolbar { // <2>
                        ToolbarItem(placement: .navigationBarTrailing) { // <3>
                            TopNavItemView()
                        }
                    }
            
                        
        }
        
        
        
    }
}

struct DateTimeSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        DateTimeSelectionView()
    }
}
