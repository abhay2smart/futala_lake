//
//  CancelTicketSeatingCell.swift
//  FutalaLake
//
//  Created by Abhayjeet Singh on 08/04/23.
//

import SwiftUI

struct CancelTicketSeatingCell: View {
    private var ticketData:TicketData?
    private var historyDetailData:HistoryDetailData?
    private let adaptiveColumns = [
        GridItem(.adaptive(minimum: 35))
    ]
    
    @State var seats:[Bool] = [Bool]()
    
    
    init(ticketData: TicketData, historyDetailData: HistoryDetailData) {
        self.ticketData = ticketData
        self.historyDetailData = historyDetailData
    }
    
    var body: some View {
        //Text(data?.encryptedQRString ?? "")
        
            
            VStack(spacing: 0) {
                Text(ticketData?.gateNo ?? "")
                    .font(.system(size: 18, weight: .medium, design: .default))
                    .foregroundColor(AppTheme.appThemeOrange)
                    .padding()
                
                
                ticketData?.getQRImageForSeating(data: self.historyDetailData)
                
                    .resizable()
                    .frame(width: 200, height: 200)
                HStack {
                    Text("Seats:")
                        .font(.system(size: 18, weight: .medium, design: .default))
                        .foregroundColor(AppTheme.appThemeOrange)
                        .padding(.top, 10)
                    Spacer()
                }
                .padding(.horizontal, 20)
                .padding(.top, 10)
                
                
                LazyVGrid(columns: adaptiveColumns) {
                    ForEach(Array((seats.enumerated())), id: \.offset) { index, element in
                        Button {
                            //seats.reversed()
                            seats[index].toggle()
                            ticketData?.seatNo?[index].toggleSelectedStatus()
                            //seats.reversed()
                        } label: {
                            Text(ticketData?.seatNo?[index].seatNumber ?? "")
                                .font(.system(size: 10, weight: .regular, design: .default))
                                .frame(width: 25, height: 25)
                                .foregroundColor(.black)
                        }
                        .background(index < (ticketData?.seatNo?.count ?? 0) ? ticketData?.seatNo?[index].color : .blue  )
                        .cornerRadius(3)

                        
                    }.onChange(of: seats, perform: { value in
                        //seatingParams?.seats.removeAll()
//                        for item in data?.seatNo ?? [] {
//                            if item.isSelected {
//                                var seat = SeatingParams.Seat()
//                                seat.seatNumber = item.seatNumber ?? ""
//                                seat.seatBookingID = item.seatBookingID ?? ""
//                                seat.seatLayoutID = item.seatLayoutID ?? ""
//                                seatingParams?.seats.append(seat)
//                            }
//                        }
                        
                    })
                    
                }.padding()
                
                
                
            }//.allowsTightening(data.isSeatingContainerClickable())
            .onAppear {
                if let safeSeats = ticketData?.seatNo {
                    for _ in safeSeats {
                        seats.append(false)
                    }
                }
            }
        
        //.padding(.top, 10)
        .background(
         Rectangle()
         .fill(.white)
         .cornerRadius(12)
          .shadow(
           color: Color.gray.opacity(0.7),
           radius: 8,
           x: 0, y: 0)
          )
        .padding(.horizontal)
        .padding(.top, 10)
    }
    
}

//struct CancelTicketSeatingCell_Previews: PreviewProvider {
//    static var previews: some View {
//        CancelTicketSeatingCell(data: HistoryDetailsModel.TicketData())
//    }
//}

