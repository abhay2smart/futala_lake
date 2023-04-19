//
//  BookedActionsView.swift
//  FutalaLake
//
//  Created by Abhayjeet Singh on 18/04/23.
//

import SwiftUI

struct BookedActionsView: View {
    @EnvironmentObject var session: SessionManager
    var body: some View {
        HStack {
            Spacer()
            
            Button {
                //
            } label: {
                VStack(spacing: 5) {
                    ZStack {
                        Rectangle()
                            .fill(AppTheme.appThemeOrange)
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                        Image("sms")
                            .resizable()
                            .frame(width: 25, height: 25)
                        
                    }
                    
                    
                }
                
            }
            
            Spacer()
            
            Button {
                //
            } label: {
                VStack(spacing: 5) {
                    ZStack {
                        Rectangle()
                            .fill(.green)
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                        Image("whatsapp")
                            .resizable()
                            .frame(width: 25, height: 25)
                        
                    }
                    
                    
                }
                
            }
            
            Spacer()
//
            Button {
                //
                self.session.moveToDashboard = true
            } label: {
                VStack(spacing: 5) {
                    ZStack {
                        Rectangle()
                            .fill(AppTheme.appThemeOrange)
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                        Text("Booking")
                            .multilineTextAlignment(.center)
                            .font(.system(size: 10, weight: .medium, design: .default))
                            .foregroundColor(.white)

                    }

                    
                }



            }
//
            Spacer()
            
        }
    }
}

struct BookedActionsView_Previews: PreviewProvider {
    static var previews: some View {
        BookedActionsView()
    }
}
