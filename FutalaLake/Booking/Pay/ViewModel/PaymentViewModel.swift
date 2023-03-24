//
//  PaymentViewModel.swift
//  FutalaLake
//
//  Created by Abhayjeet Singh on 17/03/23.
//

import Foundation

class PaymentViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    
    @Published var shouldMoveToQRScreen: Bool = false
    
    @Published var bookingID: String = ""
    
    func makePayment(params: [String: Any]) {
        var param = params
        param["paymentTypeID"] = "1"
        isLoading = true
        let url = Constants.baseUrl + Constants.API.checkOut
        
        APIService.shared.makeApiTypeRequest2(url: url, param: param, methodType: .post, expecting: GlobResponseModel.self) { resultStatus, error, data  in
            
            DispatchQueue.main.async {
                self.isLoading = false
            }
            
            if !resultStatus {
                print("something went wrong:: PaymnetViewModel")
                return             
            }
            
            if resultStatus {
                guard let data = data else {
                    return
                }
                
                do {
                    let a = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                    print("APIService->String JSON DATAww:: \(a)")
                } catch {
                    print("Error APIService@\(#line)-> \(error.localizedDescription)")
                }
                
                APIService.shared.parseModel(data: data, expecting: PaymentModel.self) { result, data in
                    
                    
                    switch result {
                    case .success(let respData):
                        DispatchQueue.main.async {
                            
                            if let bookingId = respData.data?.first?.bookingID {
                                self.bookingID = bookingId
                                self.shouldMoveToQRScreen = true
                            }
                            
                        }
                        
                    case .failure(let error):
                            print("Something went wrong23432 \(error.localizedDescription)")
                        }
                    }
                    
                    print("Success::: \(resultStatus)")
                }
            }
        
    }
    
    
}
