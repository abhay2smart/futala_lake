//
//  TopNavItemView.swift
//  FutalaLake
//
//  Created by Abhayjeet Singh on 23/12/22.
//

import SwiftUI

struct TopNavItemView: View {
    var body: some View {
        HStack {
            VStack {
                Text("Futala Lake Fountain Show")
                //Text("Fountain Show")
            }
            
            Spacer()
            HStack {
                Text("+918173954048")
                Image(systemName: "person")
            }
        }.foregroundColor(.white)
            .multilineTextAlignment(.leading)
                                .font(.system(size: 20, weight: .medium, design: .default))
                                .foregroundColor(.white)
    }
}

struct TopNavItemView_Previews: PreviewProvider {
    static var previews: some View {
        TopNavItemView()
    }
}
