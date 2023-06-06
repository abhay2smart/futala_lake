//
//  AlertWithSingleaButton.swift
//  FutalaLake
//
//  Created by Abhayjeet Singh on 02/06/23.
//

import SwiftUI

struct AlertWithSingleButton: View {
    @Binding var isPresented: Bool
    var body: some View {
        ZStack (alignment: .center) {
            Color.gray.opacity(0.4)
                .ignoresSafeArea()
            VStack(spacing: 10) {
                Text("Alert!")
                    .font(.system(size: 16, weight: .medium, design: .default))
                    .padding(.top, 15)
                    //.padding(.bottom, 5)
                Text("Fare is not set for this show time, please try after sometime.")
                    .font(.system(size: 15, weight: .regular, design: .default))
                HStack {
                    Button {
                        isPresented = false
                    } label: {
                        Text("OK")
                        .frame(maxWidth: .infinity)
                        .frame(width: 90, height: 30)
                        .foregroundColor(.white)
                        .background(AppTheme.appThemeOrange)
                        .clipShape(Capsule())
                        .padding(.horizontal)
                        .font(.system(size: 18, weight: .regular, design: .default))
                    }

                }
                Spacer()
                
            }.padding(.horizontal)
            
            .frame(width: 330, height: 140)
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

struct AlertWithSingleaButton_Previews: PreviewProvider {
    static var previews: some View {
        AlertWithSingleButton(isPresented: .constant(false))
    }
}
