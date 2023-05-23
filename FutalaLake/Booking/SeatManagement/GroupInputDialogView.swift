//
//  GroupInputDialogView.swift
//  FutalaLake
//
//  Created by Abhayjeet Singh on 19/04/23.
//

import SwiftUI

struct GroupInputDialogView: View {
    @Binding var groupStanding: String
    @State var total: Int = 0
    
    private var grandTotal: Binding<String> { Binding (
        get: {
            String((Int(groupSeats) ?? 0) + (Int(groupStanding) ?? 0))
        },
        set: {
            if ($0 == "0") {
            print("Hello")
        } }
        )
    }
    
    
    @FocusState var isInputActive: Bool
    
    @Binding var isGroupDialogPresented: Bool
    
    @Binding var groupSeats: String
    
    @Binding var ticketTypeButtonState: TicketTypeButtonState
    
    
    
    var minGroupVal: String = ""
    var maxGroupVal:String = ""
    
    @State var message = ""
    
    @State var showToast = false
    
    init(standing: Binding<String>, isGroupDialogPresented: Binding<Bool>, groupSeats: Binding<String>, groupStanding: Binding<String>, minVal: String, maxVal: String, ticketTypeButtonState: Binding<TicketTypeButtonState>) {
        
        self._groupStanding = groupStanding
        self._isGroupDialogPresented = isGroupDialogPresented
        self._groupSeats = groupSeats
        
        
        self.minGroupVal = minVal
        self.maxGroupVal = maxVal
        self._ticketTypeButtonState = ticketTypeButtonState
        
    }
    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.4)
                .ignoresSafeArea()
            VStack(spacing: 20) {
                VStack(alignment: .leading) {
                    Text("Total group seats")
                        .font(.system(size: 14, weight: .semibold))
                    CustomTextField(placeHolder: "", text: $groupSeats)
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
                .padding(.top, 40)
                
                
                VStack(alignment: .leading) {
                    Text("Total Standing")
                        .font(.system(size: 14, weight: .semibold))
                    CustomTextField(placeHolder: "", text: $groupStanding)
                        .keyboardType(.numberPad)
                        .focused($isInputActive)
                    
                }
                .padding(.horizontal)
                
                
                
                VStack(alignment: .leading) {
                    Text("Total")
                        .font(.system(size: 14, weight: .semibold))
                    CustomTextField(placeHolder: "", text: grandTotal)
                        .allowsHitTesting(false)
                    
                }
                .padding(.horizontal)
                
                
                
                HStack {
                    Button {
                        ticketTypeButtonState = .seating
                        isGroupDialogPresented = false
                        groupStanding = "0"
                        Global.GroupTiketing.TOTAL_GROUP_SELECTED_COUNT = 0
                    } label: {
                        Text("Cancel")
                    }.frame(width: 150, height: 40)
                        .background(AppTheme.appThemeOrange)
                        .foregroundColor(.white)
                        .cornerRadius(5)
                        .padding(.top, 5)
                    
                    
                    Button {
                        showToast = true
                        if isValidated() {
                            isGroupDialogPresented = false
                        }
                    } label: {
                        Text("OK")
                    }.frame(width: 150, height: 40)
                        .background(AppTheme.appThemeOrange)
                        .foregroundColor(.white)
                        .cornerRadius(5)
                        .padding(.top, 5)
                }
                
                

                Spacer()
            }.frame(height: 360)
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
                .toast(message: message,
                       isShowing: $showToast,
                       duration: Toast.short)
        }
        
        
        
    }
    
    func isValidated()->Bool {
        let groupSeats = Int(groupSeats) ?? 0
        let minGroupVal = Int(minGroupVal) ?? 0
        let maxGroupVal = Int(maxGroupVal) ?? 0
        if groupSeats < minGroupVal {
            message = "Please enter the value atleast \(minGroupVal)"
            showToast = true
            return false
        }
        
        if groupSeats > maxGroupVal {
            message = "Please enter the value below \(maxGroupVal)"
            showToast = true
            return false
        }
        
        
        
//        if groupSeats > maxGroupVal {
//            showToast = true
//            message = "Please enter the value less than \(maxGroupVal)"
//            return false
//        }
        
        return true
        
    }
}

//struct GroupInputDialogView_Previews: PreviewProvider {
//    static var previews: some View {
//        GroupInputDialogView(isGroupDialogPresented: .constant(false))
//    }
//}
