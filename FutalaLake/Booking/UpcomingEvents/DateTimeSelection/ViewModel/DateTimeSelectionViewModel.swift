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
    
    @Published var  seatInventoryData = [SeatInventoryData]()
    @Published var shouldMoveToSeatLayout = false
    
    @Published var message = ""
    //@Published var isPresensted = false
    
    
    @Published var isLoading = false
    
    @Published var currentTimeSlotSelected = ""
    
    @Published  var showToast = false
    
    @Published var masterSeatData:SeatData?
    
    
    
    
    func isValidated()->Bool {
        if currentTimeSlotSelected.isEmpty {
            message = "Please select show time"
            showToast = true
            return false
        }
        
        //shouldMoveToSeatLayout = true
        
        
        return true
    }
    
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
                        self.shows = respData.data?.first?.shows
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
    
    // Get all seat colors
    func getAllSeatColor() {
        isLoading = true
        let url = Constants.baseUrl + Constants.API.seatInventory
        
        APIService.shared.makeApiTypeRequest2(url: url, param: nil, methodType: .get, expecting: GlobResponseModel.self) { resultStatus, error, data  in
            
            DispatchQueue.main.async {
                self.isLoading = false
            }
            
            if !resultStatus {
                print("something went wrong:: SeatLayoutViewModel \(#line)")
                return
            }
            
            
            guard let data = data else {
                return
            }
            
            
            APIService.shared.parseModel(data: data, expecting: SeatInventoryModel.self) { result, data in
                switch result {
                    case .success(let respData):
                    DispatchQueue.main.async {
                        if let data = respData.data {
                            self.seatInventoryData = data
                            
                            // adding more colors
                            var selected = SeatInventoryData()
                            selected.seatType = "Selected"
                            selected.colorName = "Selected"
                            
                            var booked = SeatInventoryData()
                            booked.seatType = "Booked"
                            booked.colorName = "Booked"
                            
                            var maintenance = SeatInventoryData()
                            maintenance.seatType = "Maintenance"
                            maintenance.colorName = "maintenance"
                            
                            self.seatInventoryData.append(booked)
                            self.seatInventoryData.append(selected)
                            self.seatInventoryData.append(maintenance)
                            
                            
                            UserDefaults.standard.setCodableObject(data, forKey: Constants.colorKey)
                        }
                        
                    }
                    
                    case .failure(let error):
                        print("Something went wrong DateTimeSelectionViewModel@\(#line)")
                }
            }
            
            
        }
    }
    
    func getSeatMasterDemo() {
        self.shouldMoveToSeatLayout = true
    }
    
    func getSeatMasterData() {
        isLoading = true
        //mobile/seatConfig/seatMaster
        let url = Constants.baseUrl + Constants.API.seatMaster
        
        APIService.shared.makeApiTypeRequest2(url: url, param: nil, methodType: .get, expecting: GlobResponseModel.self) { resultStatus, error, data  in
            
            DispatchQueue.main.async {
                self.isLoading = false
            }
            
            if !resultStatus {
                print("something went wrong::\(#line) SeatLayoutViewModel")
                return
            }
            
            if resultStatus {
                guard let data = data else {
                    return
                }
                
                
                APIService.shared.parseModel(data: data, expecting: SeatLayoutModel.self) { result, data in
                    switch result {
                        case .success(let respData):
                            DispatchQueue.main.async {
                                if respData.status ?? false {
                                    if let seatData = respData.data?.first {
                                        self.masterSeatData = seatData
                                        self.shouldMoveToSeatLayout = true
                                    }
                                }
                            }
            
                        case .failure(let error):
                            print("Something went wrong::SeatLayoutViewModel@\(#line)")
                        }
                }
            }
        }
    }
    
    
    
    
}

struct ValidationObj {
    let status : Bool
    let message: String
}
