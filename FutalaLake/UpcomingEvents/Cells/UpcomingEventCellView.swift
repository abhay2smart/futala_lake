//
//  UpcomingEventCellView.swift
//  FutalaLake
//
//  Created by Abhayjeet Singh on 09/12/22.
//

import SwiftUI

struct UpcomingEventCellView: View {
    private var alignment: Alignment = .leading
    init(alignment: Alignment) {
        self.alignment = alignment
    }
    var body: some View {
        ZStack(alignment: alignment) {
            
            Image("launch_background")
                .resizable()
                .frame(height:250)
            VStack(spacing: 12) {
                Text("Duniya ka sabse bada")
                    .font(.system(size: 25, weight: .bold, design: .default))
                    .frame(width: 200)
                    .foregroundColor(AppTheme.appThemeOrange)
                Text("Musical Fountain")
                    .font(.system(size: 25, weight: .semibold, design: .default))
                    .frame(width: 250)
            }
            .padding(.horizontal, 10)
            
            
                
            
        }
        .frame(height:250)
        .cornerRadius(10)
    }
}

struct UpcomingEventCellView_Previews: PreviewProvider {
    static var previews: some View {
        UpcomingEventCellView(alignment: .leading)
    }
}
