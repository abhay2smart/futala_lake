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
            //AppTheme.appThemeSkyBlue
            VStack(alignment: .leading) {
                Text("5 - Dec - 7:00 PM")
                    .font(.system(size: 15, weight: .medium, design: .default))
                    .foregroundColor(AppTheme.appThemeOrange)
                    .padding(.top, 20)
                    .padding(.bottom, 20)
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
                            .padding(.bottom, 10)
                            .font(.system(size: 15, weight: .medium, design: .default))
                            .foregroundColor(AppTheme.appThemeOrange)
                        
                        VStack(alignment: .leading) {
                            Text("Status")
                                .font(.system(size: 15, weight: .medium, design: .default))
                                .foregroundColor(AppTheme.appThemeOrange)
                            Text("Confirmed")
                                .font(.system(size: 15, weight: .medium, design: .default))
                                .foregroundColor(Color.green)
                        }
                    }
                    Spacer()
                    VStack(spacing: 20) {
                        Image("qr-scan-icon")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 80, height: 80)
                            .padding(.top, -30)
                        Button {
                            //
                        } label: {
                            HStack {
                              Image("cross")
                                    .resizable()
                                    .frame(width: 18, height: 18)
                                    
                                Text("Cancel")
                                    .font(.system(size: 15, weight: .medium, design: .default))
                                    .foregroundColor(Color.white)
                                    .padding(.trailing, 5)
                            }
                            
                        }
                        .padding(8)
                        
                        .background(AppTheme.appThemeRed)
                        //.padding(.top, -10)
                        .clipShape(Capsule())
                        

                    }
                    
                }
                
                Spacer()
            }.padding(10)
              
            
                
            
        }
        .frame(maxHeight:190)
        .background(
                Rectangle()
                    .fill(AppTheme.appThemeSkyBlue)
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

struct UpcomcommingbookingStatusCell_Previews: PreviewProvider {
    static var previews: some View {
        UpcomcommingbookingStatusCell()
    }
}
