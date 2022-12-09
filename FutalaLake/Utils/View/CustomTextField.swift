//
//  CustomTextField.swift
//  FutalaLake
//
//  Created by Abhayjeet Singh on 09/12/22.
//

import SwiftUI

struct CustomTextField: View {
    @Binding var text: String
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct CustomTextField_Previews: PreviewProvider {
    static var previews: some View {
        CustomTextField(text: .constant("Hello"))
    }
}
