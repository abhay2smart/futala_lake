//
//  TransanctionView.swift
//  FutalaLake
//
//  Created by Abhayjeet Singh on 23/12/22.
//

import SwiftUI

struct TransanctionView: View {
    @State private var isCancelConfirmPreseneted = false
    @State private var isTicketInfoPreseneted = false
    @State private var isTicketCancelSuccessPreseneted = false
    @State private var isViewButtonPressed = false
    var body: some View {
        NavigationView {
            ZStack {
                ScrollView {
                    VStack {
                        ForEach(1..<11) { index in
                            BookingHistoryCellView(isCancelConfirmPreseneted: $isCancelConfirmPreseneted, isTicketInfoPreseneted: $isTicketInfoPreseneted, isViewButtonPressed: $isViewButtonPressed)
                                .padding(.horizontal, 15)
                                .padding(.vertical, 0)
                            
                        }
                        
                    }.padding(.top, 20)
                    
                }
                if isCancelConfirmPreseneted {
                    CancelTicketConfirmAlertView(isPresented: $isCancelConfirmPreseneted, isConfirmPressed: $isTicketInfoPreseneted)
                }
                
                else if isTicketInfoPreseneted {
                    // ticket info
                    CancelTicketAlertView(isTicketCancelSuccessPreseneted: $isTicketCancelSuccessPreseneted, isTicketInfoPreseneted: $isTicketInfoPreseneted)
                }
                
                else if isTicketCancelSuccessPreseneted {
                    TicketCancelSuccessAlertView(isGoHomeBtnPressed: $isTicketCancelSuccessPreseneted)
                }
                NavigationLink(destination: BookedTicketHistoryView(), isActive: $isViewButtonPressed) {
                    Text("")
                }.navigationTitle("") // to remove text of back button on next screen
                
            }
        }
        
        //        NavigationLink(destination: BookedTicketHistoryView(), isActive: $isViewButtonPressed) {
        //        Text("")
        //        }
        
        
    }
}

struct TransanctionView_Previews: PreviewProvider {
    static var previews: some View {
        TransanctionView()
    }
}
