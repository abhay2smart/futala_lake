//
//  PaymentWebView.swift
//  FutalaLake
//
//  Created by Abhayjeet Singh on 11/05/23.
//

import SwiftUI

struct PaymentWebView: View {
    @ObservedObject var webViewModel = WebViewModel(url: "")
    @ObservedObject var paymentWebViewViewModel = PaymentWebViewViewModel()
    
    var checkOutData:CheckOutModelData?
    
    init(data: CheckOutModelData?) {
        self.checkOutData = data
        webViewModel.url = data?.payurl ?? ""
        
        if webViewModel.shouldGoToSuccess {
            paymentWebViewViewModel.shouldGoToSuccess = true
        }
        
        
    }
    
    var body: some View {
        ZStack {
            WebView(viewModel: webViewModel)
            if webViewModel.isLoading {
                Loader()
            }
            
            NavigationLink(isActive: $webViewModel.shouldGoToSuccess) {
                if let checkOutData = checkOutData {
                    PaymentSuccessAlertView(data: checkOutData, bookingId: checkOutData.bookingID ?? "")
                }
                
            } label: {
                
            }.navigationTitle("Payment")
            
            NavigationLink(isActive: $webViewModel.shouldGoToFailure) {
                if let checkOutData = checkOutData {
                    PaymentFailView(data: checkOutData, bookingId: checkOutData.bookingID ?? "")
                }
                
                
            } label: {
                
            }.navigationTitle("Payment Failed")
            
            
            
        }
        
        
        
    }
}

struct PaymentWebView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentWebView(data: nil)
    }
}
