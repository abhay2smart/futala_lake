//
//  CancelTicketViewModel.swift
//  FutalaLake
//
//  Created by Abhayjeet Singh on 28/03/23.
//

import SwiftUI

class CancelTicketViewModel: ObservableObject {
    @Published var totalAdultsDropDownList = [Int]()
    @Published var totalChildDropDownList = [Int]()
    @Published var adultDropDownSelectedItem:Int?
    @Published var childDropDownSelectedItem:Int?
    
    @Published var isLoading = false
    @Published var isPresented = false
    
    
    
    private var refundAmt = 0
    
    
    func cancelTicket() {
        
    }
    
    var standingAdultCount = 0
    
    var standingChildCount = 0
    
    
    
    func updateCancelTicketStatus(data: HistoryData?, standingAdultCount: Int, standingChildCount: Int, refundAmt: Int) {
        self.standingAdultCount = standingAdultCount
        self.standingChildCount = standingChildCount
        self.refundAmt = refundAmt
        
        var params = [String: Any]()
        
        
        var standings = [String]()
        
        var seats = [[String: Any]]()
        
        for item in data?.seats ?? [] {
            if item.isSelected {
                var seat = [String: String]()
                seat["seatNumber"] = item.seatNumber
                seat["seatBookingID"] = item.seatBookingID
                seat["seatLayoutID"] = item.seatLayoutID
                seats.append(seat)
                
            }
        }
        
        
        
        var standingAdultCounter = 0
        
        if data != nil && data?.standing != nil {
            
            //Adult
            for (index, element) in data!.standing!.enumerated() {
                if standingAdultCounter < standingAdultCount  {
                    if element.status == 1 && element.isAdult == 1 {
                        standings.append("\(element.seatBookingID ?? "")")
                        standingAdultCounter += 1
                    }
                }
                
            }
            
            
            var standingChildCounter = 0
            //child
            for (index, element) in data!.standing!.enumerated() {
                if standingChildCounter < standingChildCount  {
                    if element.status == 1 && element.isAdult == 0 {
                        standings.append("\(element.seatBookingID ?? "")")
                        standingChildCounter += 1
                    }
                }
                
            }
            
            
        }
        
        
        var totalSeatsFare = 0
        for item in data?.seats ?? [] {
            if item.isSelected {
                totalSeatsFare += item.seatFare ?? 0
            }
        }
        
        params["bookingID"] = data?.bookingID
        params["showTimeID"] = data?.showTimeID
        
        params["showDate"] = data?.showDate
        
        params["totalCancelSeatsFare"] = "\(totalSeatsFare)"
        
        params["adminCharges"] = "50"
        
        params["totalRefundAmount"] = "\(refundAmt)"
        
        params["seats"] = seats
        
        params["standing"] = standings
        
        postData(params: params)
        
    }
    
    func postData(params: [String: Any]) {
        print("Cancel Ticket Called")
        isLoading = true
        
        let url = Constants.baseUrl + Constants.API.cancelTicket
                
                APIService.shared.makeApiTypeRequest2(url: url, param: params, methodType: .put, expecting: GlobResponseModel.self) { resultStatus, error, data  in
                    
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
                    DispatchQueue.main.async {
                        self.isPresented = false
                    }
                    
                    
//                    APIService.shared.parseModel(data: data, expecting: BookedSeats.self) { result, data in
//
//                        switch result {
//                            case .success(let respData):
//                                print("parsed")
//                            case .failure(let error):
//                                print("Something went wrong DateTimeSelectionViewModel@\(#line)")
//                        }
//                    }
                    
                    
                }

        
        //cancelTicket
    }
    
    
    
}


extension Dictionary {
    var jsonData: Data? {
        return try? JSONSerialization.data(withJSONObject: self, options: [.prettyPrinted])
    }
    
    func toJSONString() -> String? {
        if let jsonData = jsonData {
            let jsonString = String(data: jsonData, encoding: .utf8)
            return jsonString
        }
        
        return nil
    }
}
