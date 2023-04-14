//
//  GateSectionView.swift
//  FutalaLake
//
//  Created by Abhayjeet Singh on 02/01/23.
//

import SwiftUI

struct GateSectionView: View {
    var data:[Seats]
    
    private let adaptiveColumns = [
        GridItem(.adaptive(minimum: 40))
    ]
    
    @Binding var maturityStatus:String
    
    init(data: [Seats], maturityStatus: Binding<String>) {
        self.data = data
        self._maturityStatus = maturityStatus
    }
    
//    init(data: [Seats]) {
//        self.data = data
//    }
    
    var body: some View {
        VStack(spacing: 0) {
            LazyVGrid(columns: adaptiveColumns) {
                ForEach(Array(data.enumerated()), id: \.offset) { index, element in
                    Button {
                        //data[index].toggleIsSelectedStatus()
                        //data.reverse()
                        element.toggleIsSelectedStatus(maturityStatus: maturityStatus)
                        //data.reverse()
                    } label: {
                        Text(element.seatNumber ?? "")
                            .font(.system(size: 10, weight: .bold, design: .default))
                            .frame(width: 40, height: 40)
                            .foregroundColor(.black)
                    }
                    .background(element.color)
                    //.background(AppTheme.appThemeOrange)
                    .cornerRadius(3)
                    .allowsHitTesting(element.isSelectable)
                    
                    //Text("Helo")
                }
            }.padding(10)
            Spacer()
            
        }
        
        .cornerRadius(12)
        .frame(width: 820)
        
        
        
        .background(
            Rectangle()
            .fill(.white)
            .cornerRadius(5)
             .shadow(
              color: Color.gray.opacity(0.7),
              radius: 8,
              x: 0, y: 0)
             )
        
        

            
    }
}

//struct GateSectionView_Previews: PreviewProvider {
//    static var previews: some View {
//        GateSectionView(data: Seats(from: Decoder()) )
//    }
//}
