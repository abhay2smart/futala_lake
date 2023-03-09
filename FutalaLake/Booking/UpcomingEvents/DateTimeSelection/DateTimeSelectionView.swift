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
    @State private var currentTimeSlotSelected = ""
    
    private let adaptiveColumns = [
        GridItem(.adaptive(minimum: 110))
    ]
    
    var body: some View {
        ZStack {
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
                    .onChange(of: selectedDate) { selectedDate in
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
                            //let dataCount = dateTimeSelectionModel.data?.first?.shows?.count ?? 0
                            let dataCount = dateTimeSelectionModel.shows?.count ?? 0
                            
                            ForEach(0..<dataCount) { index in
                                
                                ZStack {
                                    Rectangle().frame(width: 110, height: 40)
                                        .foregroundColor(currentTimeSlotSelected == (dateTimeSelectionModel.shows?[index].startTime ?? "") ? AppTheme.appThemeOrange : AppTheme.appThemeBlue)
                                        .cornerRadius(5)
                                    Text("\(dateTimeSelectionModel.shows?[index].startTimeInTwelveHourFormat ?? "")")
                                        .foregroundColor(.white)
                                        .font(.system(size: 16, weight: .medium, design: .default))
                                    
                                    
                                    
                                }.onTapGesture {
                                    
                                    self.currentTimeSlotSelected = (dateTimeSelectionModel.data?[0].shows?[index].startTime ?? "")
                                }
                                //print("Hello Abhay \(index)")
                                
                                
                            }
                        }
                        
                        
                    }.padding(.horizontal, 10)
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
            
            if dateTimeSelectionModel.isLoading {
                Loader()
            }
            
        }.onAppear{
            dateTimeSelectionModel.getShowDays(date: selectedDate)
        }
        
    }
}

struct DateTimeSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        DateTimeSelectionView()
    }
}
