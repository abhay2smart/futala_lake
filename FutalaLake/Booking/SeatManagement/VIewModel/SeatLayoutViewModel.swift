//
//  SeatLayoutViewModel.swift
//  FutalaLake
//
//  Created by Abhayjeet Singh on 10/03/23.
//

import Foundation
import SwiftUI
class SeatLayoutViewModel: ObservableObject {
    @Published var showAlert = false
    @Published var errorMessage = ""
    @Published var isLoading = false
    //@Published var totalFilteredSeats:[Seats] = [Seats]()
    @Published var totalSeats:[Seats] = [Seats]()
    @Published var bookedSeats:[BookedSeatData] = [BookedSeatData]()
    
    @Published var gatesWithSections = [GateWithSections]()
    @Published var gateWithSections:GateWithSections?
    
    @Published var bookedDataDic = [String: Any]()
    
    @Published var submitResponseData = SubmitBookSeatModelData(from: nil)
    
    @Published var shouldMoveToCheckoutView = false
    
    private var showDate: String = ""
    private var showTimeID: String = ""
    private var showDayID: String = ""
    var showStartTime: String = ""
    var showEndTime: String = ""
    
    var standingAdultCount = "0"
    var standingChildCount = "0"
    
    
    
    func updateParameters(showDate: String, showTimeID: String, showDayID: String) {
        self.showDate   = showDate
        self.showTimeID = showTimeID
        self.showDayID  = showDayID
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
                                    if let totalseat = respData.data?.first?.seats {
                                        self.gatesWithSections = self.PrepareDataSectionWise(totalSeats: totalseat)
                                        print("Let's go====")
                                        for item in self.gatesWithSections {
                                            print("gate \(item.gateNo)")
                                            for section in item.sections {
                                                print("Section: \(section.sectionName)")
                                            }
                                        }
                                        
                                        print("Let's end====")
            
                                        for seat in totalseat {
                                            // set seat fare in seatlayout object
//                                            if seat.seatType?.lowercased() == "classic" {
//                                                seat.fare = classicFare
//                                            } else {
//                                                seat.fare = vipFare
//                                            }
                                            if let seatFare = self.bookedSeats.first?.seatFare {
                                                self.setFare(seat: seat, fares: seatFare)
                                            }
            
                                            if let arr = self.bookedSeats.first?.bookSeats {
                                                if let itemExist = self.isItemExist(arr: arr, item: seat) {
                                                    //print("Hellofare \(itemExist.fare)")
                                                    seat.setIsBooked()
                                                }
                                            }
                                        }
            
                                        self.totalSeats = totalseat
                                        //self.totalFilteredSeats = totalseat
            
                                        //self.appllyFilterByGate(gameNo: "GATE NO. 1")
                                        
                                        self.gateWithSections = self.appllyFilterByGateForSectionList(gateNo: "GATE NO. 1")
            
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
    
    private func setFare(seat: Seats, fares: [SeatFare]) {
        //seat.fare = bookedSeat.fare ?? 0.0
        
        for fare in fares {
            if seat.seatTypeID == fare.seatTypeID {
                seat.fare = fare.fare ?? 0
            }
        }
        
        
        
    }
    
    
    
    private func isItemExistInSectionList(item: String, list: [String])->Bool {
        for section in list {
            if section.lowercased() == item.lowercased() {
                return true
            }
        }
        return false
    }
    
    func PrepareDataSectionWise(totalSeats: [Seats])->[GateWithSections] {
        var gateWithSections = [GateWithSections]()
        
        let gates = Constants.GATES
        
        for gate in gates {
            let seatsInAGate = totalSeats.filter {
                $0.gateNumber == gate
            }
            
            
            var sectionList = [String]()
            
            for seat in seatsInAGate {
                if isItemExistInSectionList(item: seat.section ?? "", list: sectionList) ==  false {
                    sectionList.append(seat.section ?? "")
                }
                
            }
            
            //sectionList = Array(Set(sectionList))
            
            
            var sections = [Section]()
            
            
            for sectionStr in sectionList {
                let sectionForTheGate = seatsInAGate.filter {
                    $0.section == sectionStr
                }
                let section = Section()
                section.seats = sectionForTheGate
                section.sectionName = sectionStr
                section.width = 780
                sections.append(section)
                
            }
            
            let gateWithSection = GateWithSections(gateNo: gate, sections: sections)
            gateWithSections.append(gateWithSection)
            
        }
        
        return gateWithSections
        
        
        
    }
    
    
    
    
    
    
    
    func submitAction() {
        var seatArr = [[String: Any]]()
        
        
        var standing = [String: Any]()
        standing["quantityAdult"] = standingAdultCount
        standing["quantityChild"] = standingChildCount
        let fare = self.bookedSeats.first?.standingFare?.fare ?? 0
        standing["fare"] = "\(fare)"
        
        
        
        
        for seat in totalSeats {
            if seat.isSelected {
                var seatDic = [String: Any]()
                seatDic["isAdult"] = seat.isAdult
                seatDic["seatTypeID"] = String(seat.seatTypeID ?? 0)
                seatDic["seatType"] = String(seat.seatType ?? "")
                seatDic["seatNumber"] = String(seat.seatNumber ?? "")
                seatDic["seatLayoutID"] = String(seat.seatLayoutID ?? "")
                seatDic["fare"] = "\(seat.fare)"
                seatDic["gateNumberID"] = seat.gateNumberID ?? 0
                seatArr.append(seatDic)
            }
            
        }
        
        var param = [String: Any]()
        param["showDate"] = showDate
        param["showDayID"] = showDayID
        param["showTimeID"] = showTimeID
        param["showStartTime"] = self.showStartTime
        param["showEndTime"] = self.showEndTime
        param["ticketType"] = ""
        param["seats"] = seatArr
        
        param["standing"] = [standing]
        self.postData(params: param)
        
    }
    
    private func postData(params: [String: Any]) {
        isLoading = true
        
        let url = Constants.baseUrl + Constants.API.saveRedisSeat
        
        APIService.shared.makeApiTypeRequest(url: url, param: params, methodType: .post, expecting: SubmitBookSeatModel.self) { result, data in
            
            DispatchQueue.main.async {
                self.isLoading = false
            }
            
            
            switch result {
            case .success(let respData):
                
                DispatchQueue.main.async { [self] in
                    if respData.status ?? false {
                        if let respData = respData.data {
                            if let data = respData.first {
                                self.submitResponseData = data
                                self.bookedDataDic = params
                                self.shouldMoveToCheckoutView = true
                            }
                        }
                    } else {
                        self.errorMessage = respData.error ?? ""
                        self.showAlert = true
                        print("Status false \(self.errorMessage)")
                    }
                }
                
            case .failure(let error):
                print("Something went@\(#line) \(error.localizedDescription)")
            }
            
            
        }
    }
    
    private func isItemExist(arr:[BookSeats], item: Seats)->BookSeats? {
        var bookSeatItem:BookSeats? = nil
        for bookedSeat in arr {
            if bookedSeat.seatNumber == item.seatNumber {
                bookSeatItem = bookedSeat
                break
            }
        }
        return bookSeatItem
    }
    
//    func appllyFilterByGate(gameNo: String) {
//        self.totalFilteredSeats = self.totalSeats.filter {
//            $0.gateNumber == gameNo
//        }
//
//        self.totalFilteredSeats.reverse()
//        self.totalFilteredSeats.reverse()
//    }
    
    func appllyFilterByGateForSectionList(gateNo: String)->GateWithSections? {
        for item in gatesWithSections {
            if item.gateNo == gateNo {
                self.gateWithSections = item
                return item
            }
        }
        return nil
    }
    
    
    func validate(isSeating: Bool)->Bool {
        if isSeating == false {
            if (standingAdultCount.isEmpty || standingAdultCount == "0") && (standingChildCount.isEmpty || standingChildCount == "0") {
                self.errorMessage = "Please enter atleast one standing"
                self.showAlert = true
                return false
            } else {
                return true
            }
        }
        
        var isValid = false
        for seat in totalSeats {
            if seat.isSelected  {
                isValid = true
                break
            }
        }
        if !isValid {
            self.errorMessage = "Please select atleast one seat"
            self.showAlert = true
        }
        return isValid
    }
    
    func getReservedSeatData() {
        isLoading = true
        //mobile/seatConfig/seatMaster
        //let params = "?showDate=2023-03-14&showTimeID=00dc715e-0776-4436-96f0-4ac11f0ff6cb&showDayID=17241fff-b7f3-40a4-9e46-27a5fb6c42d0"
        let params = "?showDate=\(showDate)&showTimeID=\(self.showTimeID)&showDayID=\(self.showDayID)"
        
        
        let url = Constants.baseUrl + Constants.API.seatBooking + params
        
        print("aparsm=====\(params)")
        
        APIService.shared.makeApiTypeRequest2(url: url, param: nil, methodType: .get, expecting: GlobResponseModel.self) { resultStatus, error, data  in
            
            DispatchQueue.main.async {
                self.isLoading = false
            }
            
            if !resultStatus {
                print("something went wrong:: SeatLayoutViewModel \(#line)")
                return
            }
            
            if resultStatus {
                
                
                guard let data = data else {
                    return
                }
                
                
                APIService.shared.parseModel(data: data, expecting: BookedSeats.self) { result, data in
                    
                    switch result {
                        case .success(let respData):
                            DispatchQueue.main.async {
                                if respData.status ?? false {
                                    print("Booked Seat data recieved \(respData.data?.count)")
                                    if let bookedSeatData = respData.data {
                                        self.bookedSeats = bookedSeatData
                                        self.getSeatMasterData()
                                    }
                                }
                            }
            
                        case .failure(let error):
                            print("Something went wrong SeatLayoutModel@\(#line)")
                        }
                    
                }
                
                
                
            }
            
        }
        
//        APIService.shared.makeApiTypeRequest(url: url, param: nil, methodType: .get, expecting: BookedSeats.self) { result, data in
//
//            DispatchQueue.main.async {
//                self.isLoading = false
//            }
//
//
//            switch result {
//            case .success(let respData):
//                DispatchQueue.main.async {
//                    if respData.status ?? false {
//                        print("Booked Seat data recieved \(respData.data?.count)")
//                        if let bookedSeatData = respData.data {
//                            self.bookedSeats = bookedSeatData
//                            self.getSeatMasterData()
//                        }
//                    }
//                }
//
//            case .failure(let error):
//                print("Something went wrong")
//            }
//
//
//        }
    }
    
    
}
