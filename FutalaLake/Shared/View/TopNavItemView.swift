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
            Text("Futala Lake")
                .foregroundColor(.white)
            Spacer()
            HStack {
                Text("+918173954048").font(.headline)
                    .foregroundColor(.white)
                Image(systemName: "person")
                    .foregroundColor(.white)
            }
        }
    }
}

struct TopNavItemView_Previews: PreviewProvider {
    static var previews: some View {
        TopNavItemView()
    }
}
