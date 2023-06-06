//
//  AlertViewWithTwoButtons.swift
//  FutalaLake
//
//  Created by Abhayjeet Singh on 31/05/23.
//

import SwiftUI

struct AlertViewWithTwoButtons: View {
    @Binding var yesButtonPressed: Bool
    @Binding var noButtonPressed: Bool
    @State private var title: String
    @State private var description: String
    init(title: String = "Alert!", description: String, yesButtonPressed: Binding<Bool>, noButtonPressed: Binding<Bool>) {
        self.title = title
        self.description = description
        self._yesButtonPressed = yesButtonPressed
        self._noButtonPressed = noButtonPressed
    }
    var body: some View {
        ZStack(alignment: .center) {
            Color.gray.opacity(0.4)
                .ignoresSafeArea()
            VStack {
                VStack {
                    Text("Alert!")
                    .font(.system(size: 16, weight: .medium, design: .default))
                    .padding(.bottom, 5)
                    
                    HStack {
                        Text(description)
                            .font(.system(size: 15, weight: .regular, design: .default))
                        Spacer()
                    }
                }.padding()
                
                HStack(spacing: 0) {
                    
                    Spacer()
                    Button {
                        yesButtonPressed = true
                    } label: {
                        Text("Yes")
                            .frame(maxWidth: .infinity)
                            .frame(width: 90, height: 30)
                            .foregroundColor(.white)
                            .background(AppTheme.appThemeOrange)
                            .clipShape(Capsule())
                            .padding(.horizontal)
                            .font(.system(size: 18, weight: .regular, design: .default))
                    }
                    
                    Button {
                        noButtonPressed = true
                    } label: {
                        Text("No")
                            .frame(maxWidth: .infinity)
                            .frame(width: 90, height: 30)
                            .foregroundColor(.white)
                            .background(AppTheme.appThemeOrange)
                            .clipShape(Capsule())
                            .padding(.horizontal)
                            .font(.system(size: 18, weight: .regular, design: .default))
                    }
                    
                    Spacer()

                }
                
                
                
                
                
                Spacer()
            }
            .frame(width: 300, height: 150)
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

struct AlertViewWithTwoButtons_Previews: PreviewProvider {
    static var previews: some View {
        AlertViewWithTwoButtons(description: "", yesButtonPressed: .constant(false), noButtonPressed: .constant(false))
    }
}
