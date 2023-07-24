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
    @Published var isPresented = true
    
    @Published var historyDetailData = HistoryDetailsModel()
    
    @Published var ticketData = [TicketData]()
    
    @Published var msg = ""
    
    @Published var isTostPresented = false
    
    
    @Published var isSeating = true
    
    var standingParams = StandingParams()
    
    
    
    
    
    private var refundAmt = 0
    
    
    
    func cancelTicket() {
        
        // standing
        var standings = [String]()
        
        if historyDetailData.data?.first?.standing != nil {
            
            //Adult
            var standingAdultCounter = 0
            for (_, element) in historyDetailData.data!.first!.standing!.enumerated() {
                if standingAdultCounter < standingParams.adultCount  {
                    if element.status == 1 && element.isAdult == 1 {
                        standings.append("\(element.seatBookingID )")
                        standingAdultCounter += 1
                    }
                }
                
            }
            
            var standingChildCounter = 0
            //child
            
            for (_, element) in historyDetailData.data!.first!.standing!.enumerated() {
                
                if standingChildCounter < standingParams.childCount  {
                    print("sdsfsf \(element.status) \(element.isAdult)")
                    if element.status == 1 && element.isAdult == 0 {
                        standings.append("\(element.seatBookingID )")
                        standingChildCounter += 1
                    }
                }
                
            }
            
        }
        
        
        //seating
        
        var seats = [[String: Any]]()
        
        
        
        for ticket in ticketData {
            for item in ticket.seatNo ?? []{
                var seat = [String: String]()
                if item.isSelected {
                    seat["seatNumber"] = item.seatNumber
                    seat["seatBookingID"] = item.seatBookingID
                    seat["seatLayoutID"] = item.seatLayoutID
                    seats.append(seat)
                }
                
            }
        }
        
        
        var totalSeatsFare = 0
        
        for item in historyDetailData.data?.first?.ticketData ?? [] {
            for item2 in item.seatNo ?? [] {
                if item2.isSelected {
                    totalSeatsFare += item2.seatFare ?? 0
                }
            }
        }
        
        var params = [String: Any]()
        
        
        params["bookingID"] = historyDetailData.data?.first?.bookingID
        params["showTimeID"] = historyDetailData.data?.first?.showTimeID
        
        params["showDate"] = historyDetailData.data?.first?.showDate
        
        params["totalCancelSeatsFare"] = "\(totalSeatsFare)"
        
        params["adminCharges"] = Constants.adminCharges
        
        params["totalRefundAmount"] = "\(refundAmt)"
        
        params["seats"] = seats
        
        params["standing"] = standings
        
        
        postData(params: params)
        
    }
    
    
    func isCancellationValidated(total: Int, adminCharges: Int)->Bool {
        let refundAmt = total - adminCharges
        if refundAmt > 0 {
            return true
        }
        msg = "Can't proceed because refund amount is \(refundAmt)"
        isTostPresented = true
        return false
    }
    
    func updateCancelTicketStatus(data: HistoryData?, ticketData: [TicketData], standingAdultCount: Int, standingChildCount: Int, refundAmt: Int) {
        self.refundAmt = refundAmt
        
        var params = [String: Any]()
        
        
        var standings = [String]()
        
        var seats = [[String: Any]]()
        
        
        for item in ticketData {
            for seatItem in item.seatNo ?? [] {
                if seatItem.isSelected {
                    var seat = [String: String]()
                    seat["seatNumber"] = seatItem.seatNumber
                    seat["seatBookingID"] = seatItem.seatBookingID
                    seat["seatLayoutID"] = seatItem.seatLayoutID
                    seats.append(seat)
                    
                }
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
            for (_, element) in data!.standing!.enumerated() {
                if standingChildCounter < standingChildCount  {
                    if element.status == 1 && element.isAdult == 0 {
                        standings.append("\(element.seatBookingID ?? "")")
                        standingChildCounter += 1
                    }
                }
                
            }
            
            
        }
        
        
        var totalSeatsFare = 0
        
        for item in ticketData {
            for seatItem in item.seatNo ?? [] {
                if seatItem.isSelected {
                    totalSeatsFare += seatItem.seatFare ?? 0
                    
                }
            }
        }
        
        
        params["bookingID"] = data?.bookingID
        params["showTimeID"] = data?.showTimeID
        
        params["showDate"] = data?.showDate
        
        params["totalCancelSeatsFare"] = "\(totalSeatsFare)"
        
        params["adminCharges"] = Constants.adminCharges
        
        params["totalRefundAmount"] = "\(refundAmt)"
        
        params["seats"] = seats
        
        params["standing"] = standings
        
        postData(params: params)
        
    }
    
    func postData(params: [String: Any]) {
        print("Cancel Ticket Called \(params)")
        isLoading = true
        
        
        let url = Constants.baseUrl + Constants.API.cancelTicket
                
                APIService.shared.makeApiTypeRequest2(url: url, param: params, methodType: .put, expecting: GlobResponseModel.self) { resultStatus, error, data  in
                    
                    DispatchQueue.main.async {
                        self.isLoading = false
                    }
                    
                    guard let data = data else {
                        return
                    }
                    
                    if !resultStatus {
                        self.msg = "something went wrong"
                        self.isTostPresented = true
                        return
                    }
                    
                    print("Cancellation params55 \(params)")
                    
                    let parsedObj = processGloabalModel(data: data)
                    
                    if parsedObj.status == false {
                        DispatchQueue.main.async {
                            self.msg = parsedObj.error
                            self.isTostPresented = true
                            return
                            
                        }
                    } else {
                        DispatchQueue.main.async {
                            self.msg = "Ticket cancelled successfully"
                            self.isTostPresented = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                                self.isPresented = false
                            })
                            
                        }
                    }
                    
                }
        
    }
    
    // get all tickets
    
    func getHistoryDetails(bookingId: String) {
        self.ticketData = [TicketData]()
        self.historyDetailData = HistoryDetailsModel()
        isLoading = true
        let url = Constants.baseUrl + Constants.API.userHistoryDetails + "?bookingID=" + "\(bookingId)"
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
            
            
            let parsedObj = processGloabalModel(data: data)
            
            if parsedObj.status == false {
                DispatchQueue.main.async {
                    print("sdfsfsdfdsf \(parsedObj.error) \(bookingId)")
                    return
                }
                
                return
                
            }
            
            
            APIService.shared.parseModel(data: data, expecting: HistoryDetailsModel.self) { result, data in
                guard let data = data else {
                    return
                }
                
                do {
                     let a = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                     print("HistoryDetails45:: \(a)")
                  } catch {
                    print("Error APIService@\(#line)-> \(error.localizedDescription)")
                }

                
                
                switch result {
                case .success(let respData):
                    DispatchQueue.main.async {
                        if respData.status ?? false {
                            self.historyDetailData = respData
                            
                            DispatchQueue.main.async {
                                
                                if let ticketData = respData.data?.first?.ticketData {
                                    self.ticketData = ticketData
                                    for item in ticketData {
                                        for seat in item.seatNo ?? []{
                                            print("Hola233 \(seat.seatNumber ?? "")  \(seat.status ?? 0)")
                                        }
                                    }
                                }
                                
                                if (respData.data?.first?.ticketData?.count ?? 0) == 0 {
                                    self.isSeating = false
                                }
                            }
                        }
                            
                    }
                    
                case .failure(let error):
                    if error as! CustomAPIError == CustomAPIError.tokenExpired {
                        DispatchQueue.main.async {
                            print("Something went wrong")
                        }
                    }
                }
            }
            
            
        }
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
