//
//  ConfirmGroupAlert.swift
//  FutalaLake
//
//  Created by Abhayjeet Singh on 14/07/23.
//

import SwiftUI

struct ConfirmGroupAlertDialog: View {
    @Binding var yesButtonPressed: Bool
    @Binding var noButtonPressed: Bool
    var body: some View {
        ZStack {
            Color.white.opacity(0.5).ignoresSafeArea()
            VStack {
                
                    
                
                VStack {
                    Text("Alert")
                        .frame(height: 20)
                        .padding(.top, 10)
                        .padding(.bottom, 0)
                        .font(.system(size: 15, weight: .medium, design: .default))
                        
                        
                    
                    
                    Text("Are you sure, you want to book group ticket?")
                        .lineLimit(2)
                        .font(.system(size: 15, weight: .regular, design: .default))
                        //.background(.red)
                    
                    //Spacer()
                    
                    
                }.padding(.bottom, 0)
                
                
                HStack(spacing: 50) {
                    
                    Button {
                        noButtonPressed.toggle()
                    } label: {
                        Text("No")
                    }
                    
                    Button {
                        yesButtonPressed.toggle()
                    } label: {
                        Text("Yes")
                    }

                }
                .padding(.top, 10)
                .padding(.bottom, 15)
                //.background(.green)
                
                //Spacer()
                
            }.frame(width: 280)
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

struct ConfirmGroupAlertDialog_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmGroupAlertDialog(yesButtonPressed: .constant(false), noButtonPressed: .constant(false))
    }
}
