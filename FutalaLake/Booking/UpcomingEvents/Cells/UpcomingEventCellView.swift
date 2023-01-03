//
//  UpcomingEventCellView.swift
//  FutalaLake
//
//  Created by Abhayjeet Singh on 09/12/22.
//

import SwiftUI

struct UpcomingEventCellView: View {
    
    var body: some View {
//        ZStack(alignment: alignment) {
//
//            Image("upcoming_event1")
//                .resizable()
//                .frame(height:250)
//        }
//        .frame(height:250)
//        .cornerRadius(10)
        
        Image("upcoming_event1")
            .resizable()
            .aspectRatio( contentMode: .fit)
            .frame(width: UIScreen.main.bounds.width)
    }
}

struct UpcomingEventCellView_Previews: PreviewProvider {
    static var previews: some View {
        UpcomingEventCellView()
    }
}
