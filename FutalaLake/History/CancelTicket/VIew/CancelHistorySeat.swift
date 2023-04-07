//
//  CancelHistorySeat.swift
//  FutalaLake
//
//  Created by Abhayjeet Singh on 27/03/23.
//

import SwiftUI

struct CancelHistorySeat: View {
    @Binding var data:[HistorySeats]
    
    private let adaptiveColumns = [
        GridItem(.adaptive(minimum: 30))
    ]
    var body: some View {
        VStack(spacing: 0) {
            LazyVGrid(columns: adaptiveColumns) {
                ForEach(Array(data.enumerated()), id: \.offset) { index, element in
                    Button {
                        //data[index].toggleIsSelectedStatus()
                        data.reverse()
                        element.toggleSelected()
                        data.reverse()
                    } label: {
                        Text(element.seatNumber ?? "")
                            .font(.system(size: 9, weight: .bold, design: .default))
                            .frame(width: 30, height: 30)
                            .foregroundColor(.white)
                    }
                    .background(element.color)
                    //.background(AppTheme.appThemeOrange)
                    .cornerRadius(3)
                    //.allowsHitTesting(element.isSelectable)
                    
                    //Text("Helo")
                }
            }.padding(10)
            Spacer()
            
        }
    }
}

struct CancelHistorySeat_Previews: PreviewProvider {
    static var previews: some View {
        CancelHistorySeat(data: .constant([HistorySeats]()))
    }
}




