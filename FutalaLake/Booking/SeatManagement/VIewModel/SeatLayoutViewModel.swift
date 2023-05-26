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
    
    @Published var masterSeatData:SeatData?
    
    
    
    //group
    
    @Published var isGroupPresented = false
    
    @Published var minGroupValue:String = ""
    
    
    @Published var groupSeats:String = "20"
    @Published var groupStanding:String = "0"
    @Published var maxGroupValue:String = "60"
    
    @Published var standings:String = "0"
    
    @Published var total:String = "0"
    
    
    private var showDate: String = ""
    private var showTimeID: String = ""
    private var showDayID: String = ""
    var showStartTime: String = ""
    var showEndTime: String = ""
    
    var standingAdultCount = "0"
    var standingChildCount = "0"
    
    
    
    func updateParameters(showDate: String, showTimeID: String, showDayID: String, seatMasterData: SeatData?) {
        self.showDate   = showDate
        self.showTimeID = showTimeID
        self.showDayID  = showDayID
        self.masterSeatData = seatMasterData
        
        print("hyyytrrfffcc \(masterSeatData?.seats?.count ?? 0)")
    }
    
    
    func prepareData(masterSeatData: SeatData) {
        
        if let totalseat =  masterSeatData.seats {
            self.gatesWithSections = self.PrepareDataSectionWise(totalSeats: totalseat)
            print("Let's go====")
            for item in self.gatesWithSections {
                print("gate \(item.gateNo)")
                for section in item.sections {
                    print("Section: \(section.sectionName)")
                }
            }
            
            
            for seat in totalseat {
                if let seatFare = self.bookedSeats.first?.seatFare {
                    self.setFare(seat: seat, fares: seatFare)
                }

                if let arr = self.bookedSeats.first?.bookSeats {
                    if let itemExist = self.isItemExist(arr: arr, item: seat) {
                        seat.setIsBooked()
                    }
                }
            }

            self.totalSeats = totalseat
            
            self.gateWithSections = self.appllyFilterByGateForSectionList(gateNo: "GATE NO. 1")
            
            DispatchQueue.main.async {
                self.isLoading = false
            }
            
            
            
        }
        
        
    }
    
    
    // NOT IN USE
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
                                            if let seatFare = self.bookedSeats.first?.seatFare {
                                                self.setFare(seat: seat, fares: seatFare)
                                            }
            
                                            if let arr = self.bookedSeats.first?.bookSeats {
                                                if let itemExist = self.isItemExist(arr: arr, item: seat) {
                                                    seat.setIsBooked()
                                                }
                                            }
                                        }
            
                                        self.totalSeats = totalseat
                                        
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
    
    
    func unselectAllSeletedSeats() {
        for item in self.gatesWithSections {
            for section in item.sections {
                for seat in section.seats ?? [] {
                    seat.isSelected = false
                    seat.setVars()
                }
            }
        }
        
    }
    
    private func setFare(seat: Seats, fares: [SeatFare]) {
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
                
                let rowCount = getRowCountForTheSection(sectionName: sectionStr)
                
                
                let section = Section()
                section.seats = sectionForTheGate
                section.sectionName = sectionStr
                section.rowCount = rowCount
                sections.append(section)
                
            }
            
            let gateWithSection = GateWithSections(gateNo: gate, sections: sections)
            gateWithSections.append(gateWithSection)
            
        }
        
        return gateWithSections
        
        
        
    }
    
    private func getRowCountForTheSection(sectionName: String)->Int {
        var  masterConfigViewModel = MasterConfigViewModel()
        if let masterConfigData = masterConfigViewModel.getPreservedMasterData() {
            let masterConfigDataMobile = masterConfigData.filter {
                $0.type == "MOBILE_LAYOUT_SECTION"
            }
            
            for item in masterConfigDataMobile.first?.options ?? [] {
                if item.value?.lowercased() == sectionName.lowercased() {
                    print("Section333 \(sectionName): \(item.code ?? 0)")
                    return item.code ?? 0
                }
            }
            //MOBILE_LAYOUT_SECTION
        }
        
        return 0
    }
    
    
    
    
    
    
    
    func submitAction() {
        var seatArr = [[String: Any]]()
        
        
        var standing = [String: Any]()
        standing["quantityAdult"] = standingAdultCount
        standing["quantityChild"] = standingChildCount
        
        if groupStanding != "0" && groupStanding != "" {
            standing["quantityAdult"] = groupStanding
        }
        
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
        
        if standingAdultCount == "0" &&  standingChildCount == "0" {
            param["standing"] = []
        } else {
            param["standing"] = [standing]
        }
        
//        let a = CommonUtil.getJsonStringFromDic(dic: param) ?? ""
//        print("heeeee")
//        print(a)
//        print("heeeee")
        
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
    
    
    func validate(ticketTypeButtonState: TicketTypeButtonState)->Bool {
        
        let trimmedStandingAdultCount = standingAdultCount.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedStandingChildCount = standingChildCount.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if ticketTypeButtonState == .seating {
            var isValidForSeat = false
            for seat in totalSeats {
                if seat.isSelected  {
                    isValidForSeat = true
                    break
                }
            }
            
            if !isValidForSeat && ((trimmedStandingAdultCount == "0" || trimmedStandingAdultCount == "") && (trimmedStandingChildCount == "0" || trimmedStandingChildCount == "")) {
                
                self.errorMessage = "Please select atleast one seat"
                self.showAlert = true
                return isValidForSeat
            }
            
            return true
        }
        
        
        if ticketTypeButtonState == .standing {
            
            if (trimmedStandingAdultCount == "0" || trimmedStandingAdultCount == "") && (trimmedStandingChildCount == "0" || trimmedStandingChildCount == "") {
                self.errorMessage = "Please enter atleast one standing"
                self.showAlert = true
                return false
            }
        }
        
        if ticketTypeButtonState == .group {
            if Global.GroupTiketing.TOTAL_GROUP_SELECTED_COUNT < (Int(self.groupSeats) ?? 0)  {
                let remainingSeats = (Int(self.groupSeats) ?? 0) - Global.GroupTiketing.TOTAL_GROUP_SELECTED_COUNT
                self.errorMessage = "Please select \(remainingSeats) remaining seats"
                self.showAlert = true
                return false
            }
        }
        
        
        return true
        
        
        
    }
    
    func getReservedSeatData() {
        isLoading = true
        
        let params = "?showDate=\(showDate)&showTimeID=\(self.showTimeID)&showDayID=\(self.showDayID)"
        let url = Constants.baseUrl + Constants.API.seatBooking + params
        print("aparsm=====\(url)")
        
        APIService.shared.makeApiTypeRequest2(url: url, param: nil, methodType: .get, expecting: GlobResponseModel.self) { resultStatus, error, data  in
            
            DispatchQueue.main.async {
                //self.isLoading = false
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
                                    if let bookedSeatData = respData.data {
                                        //self.groupTicketValidationParam = bookedSeatData.first?.groupTicket
                                        self.minGroupValue = bookedSeatData.first?.groupTicket?.minGroupValue ?? ""
                                        self.maxGroupValue = bookedSeatData.first?.groupTicket?.maxGroupValue ?? ""
                                        self.bookedSeats = bookedSeatData
                                        //self.isLoading = true
                                        if let masterSeatData = self.masterSeatData  {
                                            self.prepareData(masterSeatData: masterSeatData)
                                        }
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
