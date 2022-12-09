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
            .frame(height: 50)
            .foregroundColor(.white)
            .background(AppTheme.appThemeOrange)
            .clipShape(Capsule())
            .padding(.horizontal)
            .font(.system(size: 25, weight: .regular, design: .default))
    }
}
