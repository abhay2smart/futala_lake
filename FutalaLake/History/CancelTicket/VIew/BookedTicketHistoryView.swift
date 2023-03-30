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
    
    init(data: HistoryData) {
        self.data = data
    }
    
    var body: some View {
        ZStack {
            //AppTheme.appThemeSkyBlue
            
            
            
            ScrollView {
                
                //Seating
                
                if data.encryptedSeatingQRCode != "" {
                    
                    VStack(spacing: 0) {
                        Text("Seating")
                            .font(.system(size: 18, weight: .medium, design: .default))
                            .foregroundColor(AppTheme.appThemeOrange)
                            .padding()
                        
                            data.getQRImageForSeating()
                        
                            .resizable()
                            .frame(width: 200, height: 200)
                        HStack {
                            Text("Seats:")
                                .font(.system(size: 18, weight: .medium, design: .default))
                                .foregroundColor(AppTheme.appThemeOrange)
                                .padding(.top, 10)
                            Spacer()
                        }.padding(.horizontal, 25)
                        
                        
                        LazyVGrid(columns: adaptiveColumns) {
                            
                            ForEach(Array(buttonStatusArr.enumerated()), id: \.offset) { index, element in
                                Button {
                                    buttonStatusArr.reversed()
                                    buttonStatusArr[index].toggle()
                                    data.seats?[index].toggleSelected()
                                } label: {
                                    if index < (data.seats?.count ?? 0)  {
                                        Text("\(data.seats?[index].seatNumber ?? "")")
                                            .font(.system(size: 10, weight: .regular, design: .default))
                                            .frame(width: 25, height: 25)
                                            .foregroundColor(.black)
                                    }
                                    
                                }
                                .allowsHitTesting(data.seats?[index].isSelectable ?? false)
                                .background(data.seats?[index].color)
                                .cornerRadius(3)
                            }
                            
                        }.padding()
                        
                        
                        
                        
                        
                        
                        
                        
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
                
                //.padding(.top, 10)
                .background(
                 Rectangle()
                 .fill(.white)
                 .cornerRadius(12)
                  .shadow(
                   color: Color.gray.opacity(0.7),
                   radius: 8,
                   x: 0, y: 0)
                  )
                .padding(.horizontal)
                .padding(.top, 10)
                }

                // Standing
                
                if data.encryptedStandingQRCode != "" {
                    VStack {
                        
                        Text("Standing")
                            .font(.system(size: 18, weight: .medium, design: .default))
                            .foregroundColor(AppTheme.appThemeOrange)
                            .padding(.top)
                        
                        data.getQRImageForStanding()
                        
                                       .resizable()
                                       .frame(width: 200, height: 200)
                                       .padding(.bottom)
                          
                        
                        
                        VStack(spacing: 20) {
//                            HStack {
//                                Text("Cancel Ticket Count")
//                                    Spacer()
//                            }
                            
                            
                            HStack(spacing: 20) {
                                Spacer()
                                HStack {
                                    Text("Adult")
                                    Text("\(data.getStandingAdultNonCancelledCount())").foregroundColor(.green)
                                    Text(" | ")
                                    Text("\(data.getStandingAdultCancelledCount())").foregroundColor(.red)
                                }
                                .padding(10)
                                //.border(.red)
                                .background(
                                 Rectangle()
                                 .fill(.white)
                                 .cornerRadius(2)
                                  .shadow(
                                   color: Color.gray.opacity(0.7),
                                   radius: 2,
                                   x: 0, y: 0)
                                  )

                                
                                
                                
                                HStack {
                                    Text("Child")
                                    Text("\(data.getStandingChildNonCancelledCount())").foregroundColor(.green)
                                    Text(" | ")
                                    Text("\(data.getStandingChildCancelledCount())").foregroundColor(.red)
                                }
                                .padding(10)
                                //.border(.red)
                                .background(
                                 Rectangle()
                                 .fill(.white)
                                 .cornerRadius(2)
                                  .shadow(
                                   color: Color.gray.opacity(0.7),
                                   radius: 2,
                                   x: 0, y: 0)
                                  )
                                
                                Spacer()
                            }
                        }
                        .padding(.top)
                        .padding(.bottom, 8)
                        
                        HStack(spacing: 20) {
                            
                            Picker("", selection: $adultDropDownSelectedItem) {
                                ForEach(totalAdultsDropDownList, id: \.self) { item in
                                    //Text($0)
                                    Text("\(item)")
                                }
                            }
                            .padding(.horizontal)
                            .padding(.horizontal)
                            .background(
                             Rectangle()
                             .fill(.white)
                             .cornerRadius(2)
                              .shadow(
                               color: Color.gray.opacity(0.7),
                               radius: 2,
                               x: 0, y: 0)
                              )
                            
                            
                            
                            Picker("", selection: $childDropDownSelectedItem) {
                                ForEach(totalChildDropDownList, id: \.self) { item in
                                    //Text($0)
                                    Text("\(item ?? 0)")
                                }
                            }
                            //.padding(10)
                            .padding(.horizontal)
                            .padding(.horizontal)
                            .background(
                             Rectangle()
                             .fill(.white)
                             .cornerRadius(2)
                              .shadow(
                               color: Color.gray.opacity(0.7),
                               radius: 2,
                               x: 0, y: 0)
                              )

                        }
                        .padding(.bottom)
                        
                        Spacer()
                    }
                    .background(
                     Rectangle()
                     .fill(.white)
                     .cornerRadius(12)
                      .shadow(
                       color: Color.gray.opacity(0.7),
                       radius: 8,
                       x: 0, y: 0)
                      )
                    .padding(.horizontal)
                    
                    .padding(.vertical)
                    
                }
                
                if data.isCancelButtonHidden() == false {
                    Button {
                        isPresented.toggle()
                    } label: {
                        Text("Cancel")
                            .modifier(CustomButtonModifiers())
                    }.padding(.vertical)
                }
                
                
                Spacer()
            }.padding(.top, 80)
            
            
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
            for item in data.seats ?? []{
                buttonStatusArr.append(false)
                print("fsdfdf")
            }
            
            totalAdultsDropDownList.append(0)
            if data.getStandingAdultNonCancelledCount() > 0 {
                for i in 1...data.getStandingAdultNonCancelledCount() {
                    totalAdultsDropDownList.append(i)
                }
            }
            
            
            totalChildDropDownList.append(0)
            if data.getStandingChildNonCancelledCount() > 0 {
                for i in 1...data.getStandingChildNonCancelledCount() {
                    totalChildDropDownList.append(i)
                }
            }
            
            
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
