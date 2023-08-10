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
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var showAlert = false
    
    var checkOutData:CheckOutModelData?
    
    var backButton: some View {
            Button(action: {
                // Show the confirmation alert when the back button is tapped
                showAlert = true
            }) {
                HStack {
                    Image(systemName: "chevron.backward")
                    Text("Checkout")
                }
                
            }
        }
    
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
                
            }
            .navigationTitle("Payment")
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: backButton)
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Alert"),
                    message: Text("Are you sure you want to cancel the Payment?"),
                    primaryButton: .default(Text("Yes")) {
                        // Perform the action to go back here
                        self.presentationMode.wrappedValue.dismiss()
                    },
                    secondaryButton: .cancel(Text("No"))
                )
            }
            
            NavigationLink(isActive: $webViewModel.shouldGoToFailure) {
                if let checkOutData = checkOutData {
                    PaymentFailView(data: checkOutData, bookingId: checkOutData.bookingID ?? "")
                }
                
                
            } label: {
                
            }.navigationTitle("Payment Failed")
            
            
            
            
        }.allowsHitTesting(!webViewModel.isLoading)
        
        
        
    }
}

struct PaymentWebView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentWebView(data: nil)
    }
}
