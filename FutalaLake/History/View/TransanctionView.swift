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
    
    @State private var historyDataIndex:Int = 0
    
    @ObservedObject var historyViewModel = HistoryViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                ScrollView {
                    VStack {
                        if historyViewModel.historyData.count == 0 {
                            Text("No history found")
                                .foregroundColor(.gray)
                        } else {
                            ForEach(Array(historyViewModel.historyData.enumerated()), id: \.offset) { index, element in
                                BookingHistoryCellView(data: element, historyDataIndex: $historyDataIndex, isTicketInfoPreseneted: $isTicketInfoPreseneted, isViewButtonPressed: $isViewButtonPressed, index: index)
                                    .padding(.horizontal, 15)
                                    .padding(.vertical, 0)
                            }
                        }
                        
                        
                        
                    }.padding(.top, 20)
                    
                }
                
                if historyDataIndex < historyViewModel.historyData.count {
                    NavigationLink(destination: BookedTicketHistoryView(data: historyViewModel.historyData[historyDataIndex]), isActive: $isViewButtonPressed) {
                    }.navigationTitle("History") // to change the text on back button on next
                }
                 
                
                if self.historyViewModel.isLoading {
                    Loader()
                }
                
            }
            
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text("History").font(.subheadline)
                    }.foregroundColor(.white)
                }
            }
            
//            .toolbar { // <2>
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    TopNavItemView()
//                }
//            }
            .onAppear {
                historyViewModel.fetchHistory()
            }
        }.navigationViewStyle(StackNavigationViewStyle())
        
            
        
    }
}

struct TransanctionView_Previews: PreviewProvider {
    static var previews: some View {
        TransanctionView()
    }
}
