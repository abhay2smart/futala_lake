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
    
    func makePayment(params: [String: Any]) {
        var param = params
        param["paymentTypeID"] = "1"
        isLoading = true
        let url = Constants.baseUrl + Constants.API.checkOut
        
        APIService.shared.makeApiTypeRequest2(url: url, param: param, methodType: .post, expecting: ResponseModel.self) { resultStatus, data in
            
            DispatchQueue.main.async {
                self.isLoading = false
            }
            
            guard let data = data else {
                return
            }
            
            if !resultStatus {
                
                APIService.shared.parseModel(data: data, expecting: ResponseModel.self) { result, data in
                    
                    switch result {
                    case .success(let respData):
                        DispatchQueue.main.async {
                            print("PaymentViewModel: error \(respData.error)")
                        }
                        
                    case .failure(let error):
                            print("Something went wrong23432 \(error.localizedDescription)")
                        }
                    }
                
                    return
                }
                
                
            
            
            if resultStatus {
                
                APIService.shared.parseModel(data: data, expecting: PaymentModelData.self) { result, data in
                    
                    switch result {
                    case .success(let respData):
                        DispatchQueue.main.async {
                            print("respData.bookingID \(respData.bookingID)")
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
