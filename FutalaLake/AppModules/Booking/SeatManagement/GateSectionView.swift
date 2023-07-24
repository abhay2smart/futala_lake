//
//  GateSectionView.swift
//  FutalaLake
//
//  Created by Abhayjeet Singh on 02/01/23.
//

import SwiftUI

struct GateSectionView: View {
    var data:[Seats]
    
    var actionPerformed: ((TicketTypeButtonState) -> () )?
    var ticketTypeButtonState:TicketTypeButtonState?
    
    private let adaptiveColumns = [
        GridItem(.adaptive(minimum: 40))
    ]
    
    let perBlockSpace = 48.0
    var sectionWidth = 0.0
    var rowCount = 0
    
    @Binding var maturityStatus:String
    
    var groupSeating: Int = 0
    var groupStanding: Int = 0
    var isGroupTicketing = false
    
    var seatsInAGate: GateWithSections?
    
    @Binding var isPresentedSeatFareNotSet: Bool
    
    init(data: [Seats], maturityStatus: Binding<String>, rowCountInASection: Int, groupSeats: String, groupStanding: String, isGroupTicketing: Bool, gateWithSections: GateWithSections? = nil, actionPerformed: ((TicketTypeButtonState) -> () )?, ticketTypeButtonState: TicketTypeButtonState, isPresentedSeatFareNotSet: Binding<Bool>) {
        self.actionPerformed = actionPerformed
        self.ticketTypeButtonState = ticketTypeButtonState
        self.data = data
        self._maturityStatus = maturityStatus
        self._isPresentedSeatFareNotSet = isPresentedSeatFareNotSet
        self.rowCount = rowCountInASection
        
        
        self.sectionWidth = (Double(rowCountInASection) * perBlockSpace) + 30
        
        self.groupSeating = Int(groupSeats) ?? 0
        self.groupStanding = Int(groupStanding) ?? 0
        self.isGroupTicketing = isGroupTicketing
        self.seatsInAGate = gateWithSections
    }
    
//    init(data: [Seats]) {
//        self.data = data
//    }
    
    var body: some View {
        VStack(spacing: 0) {
            LazyVGrid(columns: adaptiveColumns) {
                ForEach(Array(data.enumerated()), id: \.offset) { index, element in
                    Button {
                        //data[index].toggleIsSelectedStatus()
                        //data.reverse()
                        if element.isFareSetForSeat(seat: element) {
                            if isGroupTicketing {
                                element.selectGroupSeats(seats: data, startIndex: index, maxGroupSeat: groupSeating, seatsInAGate: seatsInAGate)
                            } else {
                                element.toggleIsSelectedStatus(maturityStatus: maturityStatus)
                            }
                        } else {
                            isPresentedSeatFareNotSet = true
                        }
                        
                        
                        actionPerformed?(ticketTypeButtonState ?? .seating)
                        
                    } label: {
                        Text(element.seatNumber ?? "")
                            .font(.system(size: 10, weight: .bold, design: .default))
                            .frame(width: 40, height: 40)
                            .foregroundColor(.white)
                    }
                    .background(element.color)
                    //.background(AppTheme.appThemeOrange)
                    .cornerRadius(3)
                    .allowsHitTesting(element.isSelectable)
                    
                    //Text("Helo")
                }
            }.padding(10)
            Spacer()
            
        }
        .onAppear {
            //sectionWidth = (sectionWidth * perBlockSpace) + 30
            
        }
        
        .cornerRadius(12)
        .frame(width: sectionWidth)
        
        
        
        .background(
            Rectangle()
            .fill(.white)
            .cornerRadius(5)
             .shadow(
              color: Color.gray.opacity(0.7),
              radius: 8,
              x: 0, y: 0)
             )
        
        

            
    }
}

//struct GateSectionView_Previews: PreviewProvider {
//    static var previews: some View {
//        GateSectionView(data: Seats(from: Decoder()) )
//    }
//}
