//
//  PaymentSuccessAlertViewModel.swift
//  FutalaLake
//
//  Created by Abhayjeet Singh on 22/03/23.
//

import Foundation

class PaymentSuccessAlertViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var encriptedQRSeatString = ""
    @Published var encriptedQRStandingString = ""
    @Published var moveToQRView = false
    //var bookingId:String = ""
    @Published var qrModelData:QRData = QRData()
    
    @Published var trsanctionId: String = ""
    
    @Published var totalAmt: String = ""
    
    @Published var paymentDate: String = ""
    
    
    func getPaymentDetails(bookingID: String) {
        
        let url = Constants.baseUrl + Constants.API.getPaymentDetails + "?bookingID=\(bookingID)"
        
        APIService.shared.makeApiTypeRequest2(url: url, param: nil, methodType: .get, expecting: GlobResponseModel.self) { resultStatus, error, data  in
            
            DispatchQueue.main.async {
                self.isLoading = false
            }
            
            
            if !resultStatus {
                print("something went wrong:: PaymentAlertSuccess")
                return
            }
            
            guard let data = data else {
                return
            }
            
            
            
            
            
            do {
                let a = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                print("sdsdfsrr:::: \(a)")
            } catch {
                print("Error APIService@\(#line)-> \(error.localizedDescription)")
            }
            
            
            
            APIService.shared.parseModel(data: data, expecting: PaymentSuccessModel.self) { result, data in
                
                switch result {
                case .success(let respData):
                    DispatchQueue.main.async {
                        self.trsanctionId = respData.data?.first?.transactionID ?? ""
                        self.totalAmt = String(respData.data?.first?.totalAmount ?? 0)
                        self.paymentDate = CommonUtil.convertTimeTwentyFourIntoTwelve(time: respData.data?.first?.showDate ?? "") ?? ""
                    }
                    
                case .failure(let error):
                        print("Something went wrong23432 \(error.localizedDescription)")
                    }
                }
            }
            
            
            

            
        }
        
        
        
        
    
    
    
    
    
    func updatePaymentStatus(bookingId: String) {
        let url = Constants.baseUrl + Constants.API.updatePaymentStatus
        let params = ["bookingID": bookingId]
        
        
        APIService.shared.makeApiTypeRequest2(url: url, param: params, methodType: .post, expecting: GlobResponseModel.self) { resultStatus, error, data  in
            
            
            if !resultStatus {
                print("something went wrong:: PaymentAlertSuccess")
                return
            }
            
            guard let data = data else {
                return
            }
            
            
            APIService.shared.parseModel(data: data, expecting: UpdatePaymentStatusModel.self) { result, data in
                
                switch result {
                case .success(let respData):
                    DispatchQueue.main.async {
                        self.getQRData(bookingId: bookingId)
                    }
                    
                case .failure(let error):
                        print("Something went wrong23432 \(error.localizedDescription)")
                    }
                }
            }
            
            
            //UpdatePaymentStatusModel
            
        
    }
    
    func getQRData(bookingId: String) {
        isLoading = true
        //mobile/seatConfig/seatMaster
        let url = Constants.baseUrl + Constants.API.generateQR + "?bookingID=\(bookingId)"
        
        APIService.shared.makeApiTypeRequest2(url: url, param: nil, methodType: .get, expecting: GlobResponseModel.self) { resultStatus, error, data  in
            
            DispatchQueue.main.async {
                self.isLoading = false
            }
            
            //QRData
            
            
            if !resultStatus {
                print("something went wrong:: 23234")
                return
            }
            
            
            guard let data = data else {
                return
            }
            
            
            APIService.shared.parseModel(data: data, expecting: QRModel.self) { result, data in
                
                
                
                
                switch result {
                case .success(let respData):
                    DispatchQueue.main.async {
                        guard let qrData = respData.data?.first else {
                            print("Qr model data is empty")
                            return
                        }
                        print("Qr model data is empty45 \(qrData.seatData?.first?.seats?.count)")
                        self.qrModelData = qrData
                        self.encriptedQRSeatString = respData.data?.first?.seatData?.first?.encryptedSeatingQRCode ?? ""
                        self.encriptedQRStandingString = respData.data?.first?.qrStandingData?.first?.encryptedStandingQRCode ?? ""
                        self.moveToQRView = true
                    }
                    
                case .failure(let error):
                        print("Something went wrong23432234 \(error.localizedDescription)")
                    }
                }
                
                print("Success::: \(resultStatus)")
            }
            
        
    }
}
