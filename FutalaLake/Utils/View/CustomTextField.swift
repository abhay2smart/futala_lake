//
//  CustomTextField.swift
//  FutalaLake
//
//  Created by Abhayjeet Singh on 09/12/22.
//

import SwiftUI

struct CustomTextField: View {
    @Binding var text: String
    private var placeHolder = ""
    init(placeHolder: String, text: Binding<String>) {
        self.placeHolder = placeHolder
        self._text = text
    }
    var body: some View {
        TextField(placeHolder, text: $text)
            .frame(height: 40)
                .textFieldStyle(PlainTextFieldStyle())
                .padding([.horizontal], 15)
                .background(
                 Rectangle()
                 .fill(.white)
                 .cornerRadius(8)
                  .shadow(
                   color: Color.gray.opacity(0.7),
                   radius: 8,
                   x: 0, y: 0)
                  )

    }
}

struct CustomTextField_Previews: PreviewProvider {
    static var previews: some View {
        CustomTextField(placeHolder: "Hello", text: .constant("Hello"))
    }
}
