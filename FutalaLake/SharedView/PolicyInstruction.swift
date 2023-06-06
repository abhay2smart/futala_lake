//
//  PolicyInstruction.swift
//  FutalaLake
//
//  Created by Abhayjeet Singh on 31/05/23.
//

import SwiftUI

struct PolicyInstruction: View {
    @Binding var okButtonPressed: Bool
    @State var title = ""
    @State var description = ""
    init(title: String, description: String, buttonAction: Binding<Bool>) {
        self._title = State(initialValue: title)
        self._description = State(initialValue: description)
        self._okButtonPressed = buttonAction
        
    }
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Color.gray.opacity(0.5)
                .ignoresSafeArea()
            ScrollView {
                VStack(spacing: 10) {
                    Text(title)
                        .font(.system(size: 17, weight: .medium, design: .default))
                        .padding(.top)
                    
                    HStack {
                        Text(description)
                            .font(.system(size: 15, weight: .medium, design: .default))
                        Spacer()
                    }
                    .padding(.horizontal)
                    Spacer()
                }
            }
            //.frame(width: 300)
            .background(
             Rectangle()
             .fill(.white)
             .cornerRadius(12)
              .shadow(
               color: Color.gray.opacity(0.3),
               radius: 8,
               x: 0, y: 0)
              )
            .padding(20)
           
            Button {
                okButtonPressed = true
            } label: {
                Text("OK")
                .frame(maxWidth: .infinity)
                .frame(width: 90, height: 30)
                .foregroundColor(.white)
                .background(AppTheme.appThemeOrange)
                .clipShape(Capsule())
                .padding(.horizontal)
                .font(.system(size: 18, weight: .regular, design: .default))
            }.padding()
                .padding(.bottom)

            
        }
    }
}

//struct PolicyInstruction_Previews: PreviewProvider {
//    static var previews: some View {
//        PolicyInstruction()
//    }
//}
