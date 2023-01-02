//
//  GateSectionView.swift
//  FutalaLake
//
//  Created by Abhayjeet Singh on 02/01/23.
//

import SwiftUI

struct GateSectionView: View {
    var wingTitle: String
    var color: Color
    @State private var buttonStatusArr: [Bool] = [
        false, false, false, false, false, false, false, false, false, false,
        false, false, false, false, false, false, false, false, false, false,
        false, false, false, false, false, false, false, false, false, false,
        false, false, false, false, false, false, false, false, false, false,
        false, false, false, false, false, false, false, false, false, false,
        false, false, false, false, false, false, false, false, false, false,
        false, false, false, false, false, false, false, false, false, false,
        false, false, false, false, false, false, false, false, false, false,
        false, false, false, false, false, false, false, false, false, false,
        false, false, false, false, false, false, false, false, false, false
    ]
    
    private var data: [String] = ["A", "B", "D"]
    private var cellColors:[Color] = [.red, .blue, .yellow, .pink]
    private let adaptiveColumns = [
    
        GridItem(.adaptive(minimum: 30))
    ]
    init(color: Color, wingTitle: String) {
        self.color = color
        self.wingTitle = wingTitle
    }
    var body: some View {
        VStack(spacing: 5) {
            HStack {
                //Spacer()
                Text("\(wingTitle)")
                    .multilineTextAlignment(.center)
                                        .font(.system(size: 20, weight: .medium, design: .default))
                                        .foregroundColor(AppTheme.appThemeOrange)
                                        .padding(.top, 20)
                                        .padding(.horizontal, 20)
                Spacer()
            }
            
            LazyVGrid(columns: adaptiveColumns) {
                
                ForEach(Array(buttonStatusArr.enumerated()), id: \.offset) { index, element in
                    Button {
                        buttonStatusArr[index].toggle()
                    } label: {
                        Text("\(index + 1)")
                            .font(.system(size: 10, weight: .regular, design: .default))
                            .foregroundColor(.black)
                    }//.padding(5)
                        .frame(width: 25, height: 25)
                        .background(buttonStatusArr[index] ? AppTheme.appThemeOrange: AppTheme.appThemeSkyBlue)
                        .cornerRadius(3)
                }
            }.padding(10)
            Spacer()
            
        }
        
        .cornerRadius(12)
        .frame(width: 780)
        
        
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

struct GateSectionView_Previews: PreviewProvider {
    static var previews: some View {
        GateSectionView(color: .red, wingTitle: "WING")
    }
}
