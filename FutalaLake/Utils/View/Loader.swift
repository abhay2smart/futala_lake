//
//  Loader.swift
//  FutalaLake
//
//  Created by Abhayjeet Singh on 02/03/23.
//

import SwiftUI

struct Loader: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 0)
        .fill(.white)
        .frame(width: 120, height: 120, alignment: .center)
        .cornerRadius(15)
        
        ProgressView {
            Text("Loading...")
                .font(.title2)
        }
        .frame(width: 120, height: 120, alignment: .center)
        .background(RoundedRectangle(cornerRadius: 15).stroke(.gray))
    }
}

struct Loader_Previews: PreviewProvider {
    static var previews: some View {
        Loader()
    }
}
