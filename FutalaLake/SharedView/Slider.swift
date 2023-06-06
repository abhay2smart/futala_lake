//
//  Slider.swift
//  FutalaLake
//
//  Created by Abhayjeet Singh on 02/06/23.
//

import SwiftUI

struct Slider: View {
    let timer = Timer.publish(every: 2, on: .main, in: .common).autoconnect()
    @State private var selection = 0
    @State var images = ["upcoming_event1", "offers", "upcoming_event1", "offers"]
    
    var body: some View {
        ZStack {
            TabView (selection: $selection) {
                ForEach(0..<4) { i in
                    Image(images[i])
                    
                    .resizable()
                    .scaledToFill()
                    .cornerRadius(10)
                    
                    
                }
            }
            .tabViewStyle(PageTabViewStyle())
            .onReceive(timer) { perform in
                selection = selection < 4 ? selection + 1 : 0
            }
            
        }
    }
}

struct Slider_Previews: PreviewProvider {
    static var previews: some View {
        Slider()
            .previewLayout(.fixed(width: 400, height: 300))
    }
}
