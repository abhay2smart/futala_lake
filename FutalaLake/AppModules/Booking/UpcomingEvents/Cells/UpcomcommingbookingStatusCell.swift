//
//  UpcomcommingbookingStatusCell.swift
//  FutalaLake
//
//  Created by Abhayjeet Singh on 21/12/22.
//

import SwiftUI

struct UpcomcommingbookingStatusCell: View {
    @EnvironmentObject var session: SessionManager
    var data: HistoryData
    init(data: HistoryData) {
        self.data = data
        
    }
    var body: some View {
        ZStack(alignment: .leading) {
            //AppTheme.appThemeSkyBlue
            VStack(alignment: .leading, spacing: 10) {
                Text("Date & Time: ")
                    //.padding(.bottom, 15)
                    .font(.system(size: 16, weight: .medium, design: .default))
                    .foregroundColor(AppTheme.appThemeOrange)
                    .padding(.top, 20)
                
                Text("\(CommonUtil.showDate(date: data.showDate ?? "")) - \(CommonUtil.convertTimeTwentyFourIntoTwelve(time: data.startTime ?? "") ?? "" )")
                    .font(.system(size: 16, weight: .medium, design: .default))
                    //.foregroundColor(AppTheme.appThemeOrange)
                    .padding(.bottom, 5)
                
                HStack {
                    VStack(alignment: .leading) {
                        HStack(alignment: .top) {
                            Text("Seats: ")
                                .padding(.bottom, 10)
                                .font(.system(size: 16, weight: .medium, design: .default))
                                .foregroundColor(AppTheme.appThemeOrange)
                            
                            Text(data.getSeatsStr())
                                .font(.system(size: 15, weight: .regular, design: .default))
                            
                        }
                        
                        
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Standing:")
                                .padding(.bottom, 0)
                                .font(.system(size: 16, weight: .medium, design: .default))
                                .foregroundColor(AppTheme.appThemeOrange)
                            
                            
                            HStack {
                                
                                Text("Adult: ")
                                    .font(.system(size: 15, weight: .medium, design: .default))
                                    .foregroundColor(AppTheme.appThemeOrange)
                                
                                Text("\(data.getStandingAdultCount())")
                                
                                
                                Text("Child: ")
                                    .font(.system(size: 15, weight: .medium, design: .default))
                                    .foregroundColor(AppTheme.appThemeOrange)
                                
                                Text("\(data.getStandingChildCount())")
                                
                                Spacer()
                                
                                Button {
                                    session.currentTab = 3
                                } label: {
                                    Text("Details")
                                        .font(.system(size: 15, weight: .medium, design: .default))
                                        .foregroundColor(Color.white)
                                        .padding(14)
                                }.frame(height: 35)
                                
                                
                                .background(AppTheme.appThemeOrange)
                                //.padding(.top, -10)
                                .clipShape(Capsule())
                                
                                
                            }
                            
                            
                            
                                
                        }
                    }
                    
                    
                    Spacer()
                    
                    
                }
                
                Spacer()
            }.padding(.horizontal)
              
            
                
            
        }
        
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

//struct UpcomcommingbookingStatusCell_Previews: PreviewProvider {
//    static var previews: some View {
//        UpcomcommingbookingStatusCell(data: nil)
//    }
//}
