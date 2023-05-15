//
//  CancelTicketStanding.swift
//  FutalaLake
//
//  Created by Abhayjeet Singh on 09/04/23.
//

import SwiftUI

struct CancelTicketStandingCell: View {
    private var data = HistoryDetailData()
    @State private var totalAdultsDropDownList = [Int]()
    @State private var totalChildDropDownList = [Int]()
    @Binding var adultDropDownSelectedItem:Int
    @Binding var childDropDownSelectedItem:Int
    
    private var standingParams:StandingParams?
    
    init(data: HistoryDetailData, standingParams: StandingParams,adultDropDownSelectedItem: Binding<Int> , childDropDownSelectedItem: Binding<Int>) {
        self.data = data
        self.standingParams = standingParams
        self._adultDropDownSelectedItem = adultDropDownSelectedItem
        self._childDropDownSelectedItem = childDropDownSelectedItem
    }
    
    private func fillDropList() {
        totalAdultsDropDownList.append(0)
        if data.standingAdultCount > 0 {
            for i in 1...data.standingAdultCount {
                totalAdultsDropDownList.append(i)
            }
        }
        
        totalChildDropDownList.append(0)
        
        if data.standingChildCount > 0 {
            for i in 1...data.standingChildCount {
                totalChildDropDownList.append(i)
            }
        }
        
        
        
        
    }
    
    var body: some View {
        VStack {
            data.getQRImageForStanding()
                .resizable()
                .frame(width: 200, height: 200)
                .padding()
            
            VStack(spacing: 20) {
                HStack(spacing: 20) {
                    HStack(spacing: 20) {
                        Spacer()
                        HStack {
                            Text("Adult")
                            Text("\(data.standingAdultCount)").foregroundColor(.green)
                            Text(" | ")
                            Text("\(data.standingCancelledAdultCount)").foregroundColor(.red)
                        }.padding(10)
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
                            Text("\(data.standingChildCount)").foregroundColor(.green)
                            Text(" | ")
                            Text("\(data.standingCancelledChildCount)").foregroundColor(.red)
                        }.padding(10)
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
                
                HStack(spacing: 20) {
                    
                    Picker("", selection: $adultDropDownSelectedItem) {
                        ForEach(totalAdultsDropDownList, id: \.self) { item in
                            //Text($0)
                            Text("\(item)")
                        }
                    }
                    .onChange(of: adultDropDownSelectedItem, perform: { value in
                        self.standingParams?.adultCount = value
                    })
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
                            Text("\(item )")
                        }
                    }
                    .onChange(of: childDropDownSelectedItem, perform: { value in
                        self.standingParams?.childCount = value
                    })
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
                    
                    
                }.padding(.bottom)
                
                Spacer()
                
                
            }
            
            
        }
        //.allowsHitTesting(false)
        .onAppear {
            fillDropList()
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
}

struct CancelTicketStanding_Previews: PreviewProvider {
    static var previews: some View {
        CancelTicketStandingCell(data: HistoryDetailData(), standingParams: StandingParams(), adultDropDownSelectedItem: .constant(0), childDropDownSelectedItem: .constant(0))
    }
}


class StandingParams {
    var childCount:Int = 0
    var adultCount:Int = 0
}


