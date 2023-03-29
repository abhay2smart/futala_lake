//
//  CustomModifiers.swift
//  FutalaLake
//
//  Created by Abhayjeet Singh on 09/12/22.
//

import SwiftUI

struct CustomButtonModifiers: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity)
            .frame(height: 45)
            .foregroundColor(.white)
            .background(AppTheme.appThemeOrange)
            .clipShape(Capsule())
            .padding(.horizontal)
            .font(.system(size: 23, weight: .regular, design: .default))
    }
}


struct CancelButtonModifiers: ViewModifier {
    func body(content: Content) -> some View {
        content
        HStack {
            HStack{
                Image("cross")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .padding(.horizontal, 10)
                    .padding(.leading, 5)
                Color.white.frame(width: 5 / UIScreen.main.scale)
                    .frame(width: 1, height: 30)
                    .padding(.leading, -5)
                Text("CANCEL")
                    .foregroundColor(.white)
                    .padding(.trailing)
                    .padding(.leading, -4)
                //
            }.frame(height: 35)
        }
    }
}
