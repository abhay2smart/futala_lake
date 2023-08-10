//
//  ProfileView.swift
//  FutalaLake
//
//  Created by Abhayjeet Singh on 23/12/22.
//

import SwiftUI
import Combine

struct ProfileView: View {
//    @State var name: String = ""
//    @State var email: String = ""
//    @State var gender: String = "Male"
    
    //@State var selectedBirthDate = Date()
    //@State var selectedBirthDateStr = ""
    @State var isPickerVisible = false
    @FocusState var isInputActive: Bool
    
    //@State var address: String = ""
    
    @StateObject var profileViewModel = ProfileViewModel()
    var body: some View {
        NavigationView {
            ZStack {
                //AppTheme.appThemeSkyBlue
                ScrollView {
                    ZStack {
                        //Color(UIColor(hexString: "#CCD6F0"))
                        VStack(alignment: .leading) {
                            HStack(alignment: .center, spacing: 10) {
                                VStack(alignment: .leading, spacing: 19) {
                                    Text("Name:")
                                        .frame(height: 40)
                                    //.background(.red)
                                    Text("Mobile:")
                                        .frame(height: 40)
                                    Text("Email:")
                                        .frame(height: 40)
                                    //.background(.red)
                                    Text("Gender:")
                                        .frame(height: 40)
                                    //.background(.red)
                                    //
                                    Text("Birthday:")
                                        .frame(height: 40)
                                    //.background(.red)
    //                                VStack {
    //                                    Text("Address:")
    //                                        .padding(.top, 5)
    //                                    Spacer()
    //                                } .frame(height: 100)
                                    
                                    //.background(.red)
                                }
                                .multilineTextAlignment(.leading)
                                .font(.system(size: 17, weight: .medium, design: .default))
                                .foregroundColor(.black)
                                //.background(.blue)
                                
                                //Spacer()
                                
                                VStack(spacing: 19) {
                                    Group {
                                        CustomTextField(placeHolder: "", text: $profileViewModel.name)
                                            .onReceive(Just(profileViewModel.name)) { newValue in
                                                let allowedCharacters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz "
                                                let filtered = newValue.filter { allowedCharacters.contains($0) }
                                                if filtered != newValue {
                                                    profileViewModel.name = filtered
                                                }
                                            }
                                        
                                        CustomTextField(placeHolder: "", text: $profileViewModel.mobile)
                                            .allowsHitTesting(false)
                                        
                                        CustomTextField(placeHolder: "", text: $profileViewModel.email)
                                        
                                        RadioButtonGroup(items: ["Male", "Female"], selectedId: profileViewModel.gender) { selected in
                                            profileViewModel.gender = selected
                                            print("Selected is: \(selected)")
                                        }
                                        .frame(height: 40)
                                        //                                    //.padding(.top, 10)
                                        
                                        ZStack(alignment: .trailing) {
                                            Rectangle()
                                                .fill(.white)
                                                .cornerRadius(8)
                                            Button {
                                                isPickerVisible.toggle()
                                            } label: {
                                                Image("calendar")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: 25, height: 25)
                                            }.padding(.trailing, 10)
                                            
                                            HStack {
                                                Text(profileViewModel.selectedBirthDateStr)
                                                    .padding(.horizontal)
                                                Spacer()
                                            }
                                            
                                            
                                            
                                            
                                        }.frame(height: 40)
                                            .background(
                                             Rectangle()
                                             .fill(.white)
                                             .cornerRadius(8)
                                              .shadow(
                                               color: Color.gray.opacity(0.7),
                                               radius: 8,
                                               x: 0, y: 0)
                                              )
                                        
    //                                    TextEditor(text: $address)
    //                                        .foregroundColor(.black)
    //                                        .frame(height: 100)
                                        
                                    }
                                }
                            }.padding(.top, 20)
                            
                            // Cal
                            
                            
                            
                            VStack (alignment: .leading){
                                Text("Address:")
                                    .multilineTextAlignment(.leading)
                                    .font(.system(size: 17, weight: .medium, design: .default))
                                    .foregroundColor(.black)
                                    .padding(.top, 20)
                                
                                
                                TextEditor(text: $profileViewModel.address)
                                    .foregroundColor(.black)
                                    .focused($isInputActive)
                                    .toolbar {
                                        ToolbarItemGroup(placement: .keyboard) {
                                            Spacer()
                                            
                                            Button("Done") {
                                                isInputActive = false
                                            }
                                        }
                                    }
                                    .frame(height: 100)
                                    .cornerRadius(10)
                                    .background(
                                     Rectangle()
                                     .fill(.white)
                                     .cornerRadius(10)
                                      .shadow(
                                       color: Color.gray.opacity(0.7),
                                       radius: 10,
                                       x: 0, y: 0)
                                      )
                                
                            }
                            
                            
                            
                            
                            
                            HStack {
                                Spacer()
                                Button {
                                    //
                                    if profileViewModel.validate() {
                                        profileViewModel.updateProfile()
                                    }
                                } label: {
                                    ZStack {
                                        Rectangle()
                                            .fill(AppTheme.appThemeOrange)
                                            .frame(height: 40)
                                        
                                        HStack {
                                            Text("Save")
                                                .multilineTextAlignment(.center)
                                                .font(.system(size: 17, weight: .medium, design: .default))
                                                .foregroundColor(.white)
                                        }
                                    }
                                    
                                    
                                    
                                }
                                .clipShape(Capsule())
                                .padding(.top, 40)
                            }
                            
                            
                            
                            Spacer()
                        }.padding(.horizontal)
                        if isPickerVisible{
                            VStack {
                                // DatePicker("", selection: $date)
                                //.datePickerStyle(GraphicalDatePickerStyle())
                                
                                DatePicker("Select Date", selection: $profileViewModel.selectedBirthDate,in: ...Date(), displayedComponents: [.date])
                                    .padding(.horizontal)
                                    .datePickerStyle(.graphical)
                                    .onChange(of: profileViewModel.selectedBirthDate, perform: { value in
                                        //self.selectedBirthDateStr = String(value)
                                        let date = value
                                        let formatter = DateFormatter()
                                        
                                        formatter.dateFormat = "dd-MM-yyyy"
                                        profileViewModel.selectedBirthDateStr = formatter.string(from: date)
                                        
                                        self.isPickerVisible = false
                                    })
                                
                            }.background(Color(UIColor.secondarySystemBackground))
                                .zIndex(2)
                            //.padding(.horizontal)
                                .padding(.top, 150)
                        }
                    }
                    .cornerRadius(10)
                    .padding()
                    
                    .toast(message: self.profileViewModel.message,
                           isShowing: $profileViewModel.isPresented,
                       duration: Toast.short)
                }
                
                
                if profileViewModel.isLoading {
                    Loader()
                }
                
                
            }
            .onAppear {
                profileViewModel.getProfileDetails()
            }
            
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text("Profile").font(.subheadline)
                    }.foregroundColor(.white)
                }
            }
            
//            .toolbar { // <2>
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    TopNavItemView()
//                }
//            }
            
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}




