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
        ZStack {
            Color.cyan
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Upcoming Events")
                        .font(.system(size: 25, weight: .semibold, design: .default))
                    UpcomingEventCellView(alignment: .leading)
                    UpcomingEventCellView(alignment: .trailing)
                    
                    Text("Upcoming Bookings")
                        .font(.system(size: 25, weight: .semibold, design: .default))
                    UpcomcommingbookingStatusCell()
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
