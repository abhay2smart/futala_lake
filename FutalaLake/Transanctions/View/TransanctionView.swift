//
//  TransanctionView.swift
//  FutalaLake
//
//  Created by Abhayjeet Singh on 23/12/22.
//

import SwiftUI

struct TransanctionView: View {
    var body: some View {
        ScrollView {
            VStack {
                BookingHistoryCellView()
                    .padding(.horizontal, 15)
                    .padding(.vertical, 0)
                
                BookingHistoryCellView()
                    .padding(.horizontal, 15)
                    .padding(.vertical, 0)
                BookingHistoryCellView()
                    .padding(.horizontal, 15)
                    .padding(.vertical, 0)
                
                BookingHistoryCellView()
                    .padding(.horizontal, 15)
                    .padding(.vertical, 0)
                
                BookingHistoryCellView()
                    .padding(.horizontal, 15)
                    .padding(.vertical, 0)
                BookingHistoryCellView()
                    .padding(.horizontal, 15)
                    .padding(.vertical, 0)
            }.padding(.top, 20)
            
            
            
            
            
        }
        
    }
}

struct TransanctionView_Previews: PreviewProvider {
    static var previews: some View {
        TransanctionView()
    }
}
