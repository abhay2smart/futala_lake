//
//  TransanctionCellView.swift
//  FutalaLake
//
//  Created by Abhayjeet Singh on 26/12/22.
//

import SwiftUI

struct BookingHistoryCellView: View {
    @Binding var isTicketInfoPreseneted: Bool
    @Binding var isViewButtonPressed: Bool
    @Binding var historyDataIndex: Int
    
    private var historyData:HistoryData?
    private var index:Int = 0
    
    init(data: HistoryData, historyDataIndex: Binding<Int>,isTicketInfoPreseneted: Binding<Bool>, isViewButtonPressed: Binding<Bool>, index: Int) {
        self._historyDataIndex = historyDataIndex
        self.historyData = data
        self._isTicketInfoPreseneted = isTicketInfoPreseneted
        self._isViewButtonPressed = isViewButtonPressed
        self.index = index
        //self.historyDataIndex = 0
    }
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top, spacing: 0) {
                VStack(alignment: .center, spacing: 5) {
                    Text("Show Time")
                        .foregroundColor(AppTheme.appThemeOrange)
                    Text(CommonUtil.convertTimeTwentyFourIntoTwelve(time: self.historyData?.startTime ?? "") ?? "")
                }
                Spacer()
                
                VStack(alignment: .center, spacing: 5) {
                    Text("Date")
                        .foregroundColor(AppTheme.appThemeOrange)
                    Text(CommonUtil.showDate(date: self.historyData?.showDate ?? ""))
                }
                Spacer()
                
                VStack(alignment: .center, spacing: 5) {
                    Text("Ticket ID")
                        .foregroundColor(AppTheme.appThemeOrange)
                    Text(self.historyData?.ticketID ?? "")
                        
                }
            }.font(.system(size: 15, weight: .regular, design: .default))
            
            
            
            if (historyData?.seats?.count ?? 0) > 0 {
                Divider()
                    .padding(.horizontal, 2)
                
                VStack {
                    HStack {
                        Text("Adult seat:")
                            .foregroundColor(AppTheme.appThemeOrange)
                        Text("\(self.historyData?.getAdultSeatStr() ?? "")")
                    }.font(.system(size: 15, weight: .regular, design: .default))
                }
                .padding(.bottom, 2)
                
                HStack {
                    Text("Child seat:")
                        .foregroundColor(AppTheme.appThemeOrange)
                    Text("\(self.historyData?.getChildSeatStr() ?? "")")
                }.font(.system(size: 15, weight: .regular, design: .default))
                    
            }
            
            
            if (historyData?.standing?.count ?? 0) > 0 {
                Divider()
                    .padding(.horizontal, 2)
                
                HStack {
                    Text("Standing Count")
                        .foregroundColor(AppTheme.appThemeOrange)
                    Group {
                        Text("Adult: \(self.historyData?.getStandingAdultCount() ?? 0)")
                        Text(" | ")
                        Text("Child: \(self.historyData?.getStandingChildCount() ?? 0)")
                    }
                    
                    
                }.font(.system(size: 15, weight: .regular, design: .default))
            }
            
            
            
            
            
            
            HStack {
                Spacer()
                if historyData?.bookingStatus == 3 {
                    HStack(spacing: 5) {
                        Image("failled").resizable()
                            .frame(width: 20, height: 20)
                        Text("Payment Failed")
                            .foregroundColor(.red)
                            .font(.system(size: 16, weight: .medium, design: .default))
                            
                    }.padding(.bottom, 10)
                    
                } else {
                    Button {
                        self.historyDataIndex = index
                        isViewButtonPressed = true
                    } label: {
                        Text("View")
                    }
                    .padding(5)
                    .padding(.horizontal)
                    .background(AppTheme.appThemeBlue)
                    .foregroundColor(.white)
                    .clipShape(Capsule())
                }
                
                

            }
        }.padding(10)
            
        
        .background(
                Rectangle()
                    .fill(.white)
                    .cornerRadius(12)
                    .shadow(
                        color: Color.gray.opacity(0.7),
                        radius: 8,
                        x: 0,
                        y: 0
                    )
            )
    }
}

struct BookingHistoryCellView_Previews: PreviewProvider {
    static var previews: some View {
        BookingHistoryCellView(data: HistoryData(from: nil), historyDataIndex: .constant(0), isTicketInfoPreseneted: .constant(false), isViewButtonPressed: .constant(false), index: 0)
    }
}
