//
//  CancelTicketConfirmView.swift
//  FutalaLake
//
//  Created by Abhayjeet Singh on 28/03/23.
//

import SwiftUI

struct CancelTicketConfirmView: View {
    @Binding var isYesButtonPressed: Bool
    @Binding var isNoButtonPressed: Bool
    @Binding var isPresented: Bool
    
    @ObservedObject var cancelTicketViewModel = CancelTicketViewModel()
    
    
    private var standingAdultCount = 0
    private var standingChildCount = 0
    private var totalAmount = 0
    private var data: HistoryData?
    
    private var adminCharges = 10
    
    init(data: HistoryData, isYesButtonPressed: Binding<Bool>, isNoButtonPressed: Binding<Bool>, isPresented: Binding<Bool>, standingAdultCount: Int, standingChildCount: Int) {
        self._isNoButtonPressed = isNoButtonPressed
        self._isYesButtonPressed = isYesButtonPressed
        self._isPresented = isPresented
        self.standingAdultCount = standingAdultCount
        self.standingChildCount = standingChildCount
        self.data = data
    }
    
    func getSeatsStr()->String {
        var seatsStr = ""
        //var seatsArr = [String]()
        var i = 0
        for seat in data?.seats ?? [] {
            if seat.isSelected {
                //seatsArr.append(seat.seatNumber ?? "")
                seatsStr += (seat.seatNumber ?? "") + ", "
            }
            
            i += 1
        }
        
        return seatsStr
    }
    
    private func calculateTotal()->Int {
        var seatFare = 0
        var standingSingleChildFare = 0
        var standingSingleAdultFare = 0
        
        var total = 0
        
        for item in self.data?.seats ?? [] {
            if item.isSelected {
                seatFare += item.seatFare ?? 0
            }
        }
        
        for item in self.data?.standing ?? [] {
            if item.isAdult == 1 {
                standingSingleAdultFare = Int(item.seatFare ?? 0)
            } else {
                standingSingleChildFare = Int(item.seatFare ?? 0)
            }
        }
        
        
        let totalStandingFare = (standingSingleAdultFare * standingAdultCount) + (standingSingleChildFare * standingChildCount)
        total = seatFare + totalStandingFare
        return total
        
    }
    
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Spacer()
                    Text("Are you sure, want to cancel the ticket?")
                        .font(.system(size: 17, weight: .bold, design: .default))
                    Spacer()
                    
                }.padding(.top)
                    .padding(.bottom, 30)
                
                Group {
                    VStack(spacing: 20) {
                        HStack {
                            Text("Show Date")
                            Spacer()
                            Text("\(data?.showDate ?? "")")
                        }
                        Divider()
                        
                        HStack {
                            Text("Show Time")
                            Spacer()
                            Text("\(CommonUtil.convertTimeTwentyFourIntoTwelve(time: data?.startTime ?? "") ?? "")")
                            Text("-")
                            Text("\(CommonUtil.convertTimeTwentyFourIntoTwelve(time: data?.endTime ?? "") ?? "")")
                        }
                        
                        Divider()
                        
                        HStack {
                            Text("Seat No./Nos")
                            Spacer()
                            Text(getSeatsStr())
                        }
                        
                        Divider()
                        
                        HStack {
                            Text("Standing Adult Count")
                            Spacer()
                            Text("\(standingAdultCount)")
                        }
                        
                        
                        Divider()
                        
                        HStack {
                            Text("Standing Child Count")
                            Spacer()
                            Text("\(standingChildCount)")
                        }
                        
                        
                    }
                    
                    
                    Group {
                        
                        VStack(spacing: 20) {
                            Divider()
                            HStack {
                                Text("Total Amount")
                                Spacer()
                                Text("₹\(calculateTotal())")
                            }
                            
                            Divider()
                            
                            HStack {
                                Text("Admin Charges")
                                Spacer()
                                Text("₹\(adminCharges)")
                            }
                            
                            Divider()
                            
                            HStack {
                                Text("Refund Amount")
                                Spacer()
                                Text("₹\(abs(calculateTotal() - (adminCharges)))")
                            }
                        }
                       
                        
                        
                    }
                    
                    
                }
                
                HStack {
                    Button {
                        isPresented = cancelTicketViewModel.isPresented //false
                        isYesButtonPressed = true
                        self.cancelTicketViewModel.updateCancelTicketStatus(data: data, standingAdultCount: standingAdultCount, standingChildCount: standingChildCount, refundAmt: (abs(calculateTotal() - (adminCharges))))
                    } label: {
                        Text("Yes")
                            .modifier(CustomButtonModifiers())
                    }
                    
                    Button {
                        isPresented = false
                        isNoButtonPressed = true
                    } label: {
                        Text("No")
                            .modifier(CustomButtonModifiers())
                    }

                }.padding(.vertical)
                
                Spacer()
            }.padding()
            
        }
    }
}

struct CancelTicketConfirmView_Previews: PreviewProvider {
    static var previews: some View {
        CancelTicketConfirmView(data: HistoryData(from: nil), isYesButtonPressed: .constant(false), isNoButtonPressed: .constant(false), isPresented: .constant(false), standingAdultCount: 0, standingChildCount: 0)
    }
}
