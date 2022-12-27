//
//  LaunchView.swift
//  FutalaLake
//
//  Created by Abhayjeet Singh on 08/12/22.
//

import SwiftUI

struct LaunchView: View {
    var body: some View {
        ZStack {
//            Color.cyan
//                .ignoresSafeArea()
            
            
            Image("launch_background")
                                .resizable()
                                .edgesIgnoringSafeArea(.all)
//            VStack(spacing: 4) {
//                Text("Welcome to")
//                    .font(.system(size: 22, weight: .medium, design: .default))
//
//                Text("Futala Fountain Show")
//                    .font(.system(size: 30, weight: .heavy, design: .default))
                    //.foregroundColor(.red)
            //}
        }
//        .background(
//                Image(systemName: "house")
//                    .resizable()
//                )
        
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
    }
}
