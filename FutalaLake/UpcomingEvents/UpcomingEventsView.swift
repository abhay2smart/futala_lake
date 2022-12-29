//
//  UpcomingEventsView.swift
//  FutalaLake
//
//  Created by Abhayjeet Singh on 09/12/22.
//

import SwiftUI

struct UpcomingEventsView: View {
    let numbers = [
            1, 2, 5
        ]
    var body: some View {
        NavigationView {
            ZStack(alignment: .center) {
                AppTheme.appThemeSkyBlue
                ScrollView {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Upcoming Events")
                            .font(.system(size: 18, weight: .medium, design: .default))
                            .padding(.horizontal, 15)
                            .padding(.top, 20)
                        
                        
                        UpcomingEventCellView()
                        
                        UpcomingEventCellView()
                        
                        UpcomingEventCellView()
                        
                        
                        Text("Upcoming Booking")
                            .font(.system(size: 18, weight: .medium, design: .default))
                            .padding(.horizontal, 15)
                            .padding(.top, 20)
                            .padding(.bottom, 10)
                        
                        UpcomcommingbookingStatusCell()
                            .padding(.horizontal, 10)
                            .padding(.bottom, 30)
                        
                    }
                    
                }
            }
        }
    }
}

struct UpcomingEventsView_Previews: PreviewProvider {
    static var previews: some View {
        UpcomingEventsView()
    }
}
