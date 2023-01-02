//
//  TransanctionCellView.swift
//  FutalaLake
//
//  Created by Abhayjeet Singh on 26/12/22.
//

import SwiftUI

struct BookingHistoryCellView: View {
    @Binding var isCancelConfirmPreseneted: Bool
    @Binding var isTicketInfoPreseneted: Bool
    @Binding var isViewButtonPressed: Bool
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top, spacing: 0) {
                VStack(alignment: .center, spacing: 5) {
                    Text("Show")
                        .font(.system(size: 17, weight: .regular, design: .default))
                        .foregroundColor(AppTheme.appThemeOrange)
                    Text("7:00 PM")
                }
                Spacer()
                
                VStack(alignment: .center, spacing: 5) {
                    Text("Date")
                        .font(.system(size: 17, weight: .regular, design: .default))
                        .foregroundColor(AppTheme.appThemeOrange)
                    
                    Text("7:00 PM")
                }
                Spacer()
                
                VStack(alignment: .center, spacing: 5) {
                    Text("Ticket")
                        .font(.system(size: 17, weight: .regular, design: .default))
                        .foregroundColor(AppTheme.appThemeOrange)
                    Text("D3, 34")
                }
                Spacer()
                
                VStack(alignment: .center, spacing: 5) {
                    Text("Booking ID")
                        .font(.system(size: 17, weight: .regular, design: .default))
                        .foregroundColor(AppTheme.appThemeOrange)
                    
                    Text("1219831983")
                }
            }
            
            Divider()
                .padding(.horizontal, 2)
            HStack {
                Spacer()
                Button {
                    isViewButtonPressed = true
                } label: {
                    Text("View")
                }
                .padding(5)
                .padding(.horizontal)
                .background(AppTheme.appThemeBlue)
                .foregroundColor(.white)
                .clipShape(Capsule())
                
                Button {
                    //
                    isCancelConfirmPreseneted = true
                    //isTicketInfoPreseneted = true
                } label: {
                    Text("Cancel")
                }
                .padding(5)
                .padding(.horizontal)
                .background(AppTheme.appThemeRed)
                .foregroundColor(.white)
                .clipShape(Capsule())

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
        BookingHistoryCellView(isCancelConfirmPreseneted: .constant(false), isTicketInfoPreseneted: .constant(false), isViewButtonPressed: .constant(false))
    }
}
