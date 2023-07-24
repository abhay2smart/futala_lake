//
//  CustomAlert.swift
//  FutalaLake
//
//  Created by Abhayjeet Singh on 20/07/23.
//

import SwiftUI

struct CustomAlert: View {
    @Binding var isPresented: Bool
    var body: some View {
        ZStack {
            Color.gray.opacity(0.4).ignoresSafeArea()
            VStack {
                Text("Alert")
                    .font(.system(size: 15, weight: .semibold, design: .default))
                    .padding(.top, 20)
                    .padding(.bottom, 5)
                
                
                
                Text("You can't book this seat")
                    .font(.system(size: 15, weight: .regular, design: .default))
                
                Spacer()
                
                Button {
                    isPresented = false
                } label: {
                    Text("OK")
                }.padding(.bottom, 20)
                

            }.frame(width: 250, height: 120)
                .background(
                 Rectangle()
                 .fill(.white)
                 .cornerRadius(12)
                  .shadow(
                   color: Color.gray.opacity(0.7),
                   radius: 8,
                   x: 0, y: 0)
                  )

        }
    }
}

struct CustomAlert_Previews: PreviewProvider {
    static var previews: some View {
        CustomAlert(isPresented: .constant(false))
    }
}
