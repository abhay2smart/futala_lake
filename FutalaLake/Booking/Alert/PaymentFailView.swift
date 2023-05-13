//
//  PaymentFailView.swift
//  FutalaLake
//
//  Created by Abhayjeet Singh on 12/05/23.
//

import SwiftUI

struct PaymentFailView: View {
    var body: some View {
        ZStack {
            Text("Payment Failed!!")
                .foregroundColor(.red)
        }
        .navigationTitle("Payment Failed")
        
        
    }
}

struct PaymentFailView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentFailView()
    }
}
