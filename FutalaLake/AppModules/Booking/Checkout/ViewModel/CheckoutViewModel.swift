//
//  CheckoutViewModel.swift
//  FutalaLake
//
//  Created by Abhayjeet Singh on 11/05/23.
//

import Foundation
class CheckoutViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    
    @Published var message = ""
    
    @Published var shouldShowToast = false
    
    
    @Published var shouldMoveToPaymentWebViewScreen: Bool = false
    
    @Published var checkOutModelData:CheckOutModelData?
    
    func makeCheckout(params: [String: Any]) {
        var param = params
        param["paymentTypeID"] = "1"
        isLoading = true
        let url = Constants.baseUrl + Constants.API.checkOut
        
        print("Hekkko ")
        print(param)
        
        APIService.shared.makeApiTypeRequest2(url: url, param: param, methodType: .post, expecting: GlobResponseModel.self) { resultStatus, error, data  in
            
            DispatchQueue.main.async {
                self.isLoading = false
            }
            
            if !resultStatus {
                self.shouldShowToast = true
                self.message = "Something went wrong!!"
                print("something went wrong:: PaymnetViewModel")
                
                return
            }
            
            if resultStatus {
                guard let data = data else {
                    return
                }
                
                do {
                    let a = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                    print("APIServicewerwe->String JSON DATAww:: \(a)")
                } catch {
                    print("Error APIService@\(#line)-> \(error.localizedDescription)")
                }
                
                APIService.shared.parseModel(data: data, expecting: CheckOutModel.self) { result, data in
                    
                    
                    switch result {
                    case .success(let respData):
                        DispatchQueue.main.async {
                            if let safeData = respData.data?.first {
                                print("Server Validation pass")
                                self.checkOutModelData = safeData
                                self.shouldMoveToPaymentWebViewScreen = true
                            } else {
                                self.shouldShowToast = true
                                self.message = "Something went wrong!!"
                                print("Server Validation Failed")
                            }
                            
                        }
                        
                    case .failure(let error):
                        self.shouldShowToast = true
                        self.message = "Something went wrong!!"
                        }
                    }
                    
                    print("Success::: \(resultStatus)")
                }
            }
        
    }
    
    
}
