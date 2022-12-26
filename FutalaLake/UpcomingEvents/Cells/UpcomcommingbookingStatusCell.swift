//
//  UpcomcommingbookingStatusCell.swift
//  FutalaLake
//
//  Created by Abhayjeet Singh on 21/12/22.
//

import SwiftUI

struct UpcomcommingbookingStatusCell: View {
    var body: some View {
        ZStack(alignment: .leading) {
            Color.mint
            VStack(alignment: .leading) {
                Text("5-Dec 10:00 ")
                    .font(.system(size: 15, weight: .medium, design: .default))
                    .foregroundColor(AppTheme.appThemeOrange)
                    .padding(.top, 20)
                    .padding(.bottom, 30)
                HStack {
                    VStack(alignment: .leading) {
                        HStack(alignment: .top) {
                            Image(systemName: "person")
                            Image(systemName: "person")
                            Image(systemName: "person")
                            Image(systemName: "person")
                        }
                        .padding(.bottom, 5)
                        Text("Deepak Powar")
                            .padding(.bottom, 20)
                        
                        VStack(alignment: .leading) {
                            Text("Status")
                            Text("Confirmed")
                        }
                    }
                    Spacer()
                    VStack(spacing: 20) {
                        Image(systemName: "house")
                        Button {
                            //
                        } label: {
                            Text("Cancel")
                        }

                    }
                    
                }
                
                Spacer()
            }.padding(10)
              
            
                
            
        }
        .frame(maxHeight:250)
        .cornerRadius(10)
    }
}

struct UpcomcommingbookingStatusCell_Previews: PreviewProvider {
    static var previews: some View {
        UpcomcommingbookingStatusCell()
    }
}
