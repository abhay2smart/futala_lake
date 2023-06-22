//
//  StandingInputDialog.swift
//  FutalaLake
//
//  Created by Abhayjeet Singh on 10/03/23.
//

import SwiftUI

struct StandingInputDialog: View {
    @Binding var noOfAdults: String
    @Binding var noOfChildren: String
    @Binding var total: String
    @Binding var isPressented: Bool
    @FocusState var isInputActive: Bool
    
    @State private var message = ""
    @State private var shouldShowToast = false
    
    
        
    init(noOfAdults: Binding<String>, noOfChildren : Binding<String>, total : Binding<String>, isPresented: Binding<Bool>) {
        self._isPressented = isPresented
        self._noOfAdults = noOfAdults
        self._noOfChildren = noOfChildren
        self._total = total
    }
    var body: some View {
        ZStack {
            Color.gray.opacity(0.4)
                .ignoresSafeArea()
            VStack(spacing: 20) {
                VStack(alignment: .leading) {
                    Text("No. of Adults")
                        .font(.system(size: 14, weight: .semibold))
                    CustomTextField(placeHolder: "", text: $noOfAdults).onChange(of: noOfAdults) { newValue in
                        let totalIntVal = (Int(noOfAdults) ?? 0) + (Int(noOfChildren) ?? 0)
                        total = "\(totalIntVal)"
                    }
                    .keyboardType(.numberPad)
                    .focused($isInputActive)
                    .toolbar {
                        ToolbarItemGroup(placement: .keyboard) {
                            Spacer()
                            
                            Button("Done") {
                                isInputActive = false
                            }
                        }
                    }
                    
                }
                .padding(.horizontal)
                .padding(.top)
                
                
                VStack(alignment: .leading) {
                    Text("No. of Children")
                        .font(.system(size: 14, weight: .semibold))
                    CustomTextField(placeHolder: "", text: $noOfChildren)
                        .onChange(of: noOfChildren) { newValue in
                            let totalIntVal = (Int(noOfAdults) ?? 0) + (Int(noOfChildren) ?? 0)
                            total = "\(totalIntVal)"
                        }
                        .keyboardType(.numberPad)
                        .focused($isInputActive)
                    
                }
                .padding(.horizontal)
                
                VStack(alignment: .leading) {
                    Text("Total")
                        .font(.system(size: 14, weight: .semibold))
                    CustomTextField(placeHolder: "", text: $total)
                        .allowsHitTesting(false)
                }
                .padding(.horizontal)
                
                HStack {
                    Button {
                        self.noOfAdults = ""
                        self.noOfChildren = ""
                        self.total = "0"
                       
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
                            self.isPressented = false
                        })
                        
                        
                    } label: {
                        Text("Cancel")
                            .frame(width: 150, height: 40)
                                .background(AppTheme.appThemeOrange)
                                .foregroundColor(.white)
                                .cornerRadius(5)
                                .padding(.top, 5)
                    }
                    
                    Button {
                        isInputActive = false
                        isPressented = !validate()
                    } label: {
                        Text("OK")
                            .frame(width: 150, height: 40)
                                .background(AppTheme.appThemeOrange)
                                .foregroundColor(.white)
                                .cornerRadius(5)
                                .padding(.top, 5)
                    }
                }
                
                

                Spacer()
            }.frame(height: 350)
                .background(
                    Rectangle()
                    .fill(.white )
                    .cornerRadius(5)
                     .shadow(
                      color: Color.gray.opacity(0.7),
                      radius: 8,
                      x: 0, y: 0)
                     )
                .padding()
            
                .toast(message: self.message, isShowing: $shouldShowToast, duration: Toast.short)
        }
        
    }
}

struct StandingInputDialog_Previews: PreviewProvider {
    static var previews: some View {
        StandingInputDialog(noOfAdults: .constant("0"), noOfChildren: .constant("0"), total: .constant("0"), isPresented: .constant(true))
    }
}

extension StandingInputDialog {
    private func validate()-> Bool {
        let trimmedStandingAdultCount = noOfAdults.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedStandingChildCount = noOfChildren.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if (trimmedStandingAdultCount == "0" || trimmedStandingAdultCount == "") && (trimmedStandingChildCount == "0" || trimmedStandingChildCount == "") {
            self.message = "Please enter atleast one standing"
            self.shouldShowToast = true
            return false
        }
        
        return true
        
    }
}

enum StandingDialogButtonState: String {
    case yes = "yes"
    case no = "no"
}
