//
//  DateTimeSelectionViewModel.swift
//  FutalaLake
//
//  Created by Abhayjeet Singh on 06/03/23.
//

import Foundation

class DateTimeSelectionViewModel: ObservableObject {
    @Published var data: [DateTimeSelectionModelData]?
    @Published private (set) var  shows:[Shows]?
    
    @Published var isLoading = false
    
    //API Calls
    
    
    func getShowDays(date: Date = Date()) {
        
        isLoading = true
        
        
        
        

        // Create Date Formatter
        let dateFormatter = DateFormatter()

        // Set Date Format
        dateFormatter.dateFormat = "yyyy-MM-dd"

        // Convert Date to String
        let dateString = dateFormatter.string(from: date)
        
        
        
        print("Abhay666 \(dateString) \(date)")
        
        //return
        
        
        let url = Constants.baseUrl + Constants.API.showsByDays + "?date=\(dateString)"
        APIService.shared.makeApiTypeRequest(url: url, param: nil, methodType: .get, expecting: DateTimeSelectionModel.self, passToken: true) { result, data  in
            
            DispatchQueue.main.async {
                self.isLoading = false
            }
            
            
            switch result {
            case .success(let respData):
                DispatchQueue.main.async {
                    if respData.status ?? false {
                        self.data = respData.data
                        //self.shows = respData.data?.first?.shows
                        print("Abhay88 \(respData.data?.first?.shows?.count)")
                        self.shows = respData.data?.first?.shows
                        //print()
                    }
                    
                }
                
            case .failure(let error):
//                if error as! CustomAPIError == CustomAPIError.tokenExpired {
//                    DispatchQueue.main.async {
//                        print("Something went wrong")
//                    }
//                }
                
                DispatchQueue.main.async {
                    print("Something went wrong34 \(error)")
                }
            }
            
        }
    }
}
