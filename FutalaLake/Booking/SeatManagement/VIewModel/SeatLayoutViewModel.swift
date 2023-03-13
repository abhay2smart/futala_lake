//
//  SeatLayoutViewModel.swift
//  FutalaLake
//
//  Created by Abhayjeet Singh on 10/03/23.
//

import Foundation
class SeatLayoutViewModel: ObservableObject {
    @Published var showAlert = false
    @Published var errorMessage = ""
    @Published var isLoading = false
    @Published var totalSeats:[Seats] = [Seats]()
    
    func getSeatMasterData() {
        isLoading = true
        //mobile/seatConfig/seatMaster
        let url = Constants.baseUrl + Constants.API.seatMaster
        
        APIService.shared.makeApiTypeRequest(url: url, param: nil, methodType: .get, expecting: SeatLayoutModel.self) { result in
            
            DispatchQueue.main.async {
                self.isLoading = false
            }
            
            
            switch result {
            case .success(let respData):
                DispatchQueue.main.async {
                    if respData.status ?? false {
                        print("Seat master data recieved \(respData.data?.first?.seats?.count)")
                        if let totalseat = respData.data?.first?.seats {
                            self.totalSeats = totalseat
                        }
                            
                    }
                }
                
            case .failure(let error):
                print("Something went wrong")
            }
            
            
        }
    }
}
