//
//  ProfileView.swift
//  FutalaLake
//
//  Created by Abhayjeet Singh on 23/12/22.
//

import SwiftUI

struct ProfileView: View {
    @State var name: String = ""
    @State var email: String = ""
    @State var gender: String = "Male"
    
    @State var selectedBirthDate = Date()
    @State var selectedBirthDateStr = ""
    @State var isPickerVisible = false
    
    @State var address: String = ""
    var body: some View {
        NavigationView {
            ZStack {
                AppTheme.appThemeSkyBlue
                ZStack {
                    Color(UIColor(hexString: "#CCD6F0"))
                    VStack(alignment: .leading) {
                        HStack(alignment: .center, spacing: 10) {
                            VStack(alignment: .leading, spacing: 19) {
                                Text("Name:")
                                    .frame(height: 40)
                                //.background(.red)
                                Text("Email Id:")
                                    .frame(height: 40)
                                //.background(.red)
                                Text("Gender:")
                                    .frame(height: 40)
                                //.background(.red)
                                //
                                Text("Birthday:")
                                    .frame(height: 40)
                                //.background(.red)
                                VStack {
                                    Text("Address:")
                                        .padding(.top, 5)
                                    Spacer()
                                } .frame(height: 100)
                                
                                //.background(.red)
                            }
                            .multilineTextAlignment(.leading)
                            .font(.system(size: 17, weight: .medium, design: .default))
                            .foregroundColor(.black)
                            //.background(.blue)
                            
                            //Spacer()
                            
                            VStack(spacing: 19) {
                                Group {
                                    CustomTextField(placeHolder: "", text: $name)
                                    CustomTextField(placeHolder: "", text: $email)
                                    
                                    RadioButtonGroup(items: ["Male", "Female"], selectedId: gender) { selected in
                                        gender = selected
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
                                            Text(selectedBirthDateStr)
                                                .padding(.horizontal)
                                            Spacer()
                                        }
                                        
                                        
                                        
                                        
                                    }.frame(height: 40)
                                    
                                    TextEditor(text: $address)
                                        .foregroundColor(.black)
                                        .frame(height: 100)
                                    
                                }
                            }
                        }.padding(.top, 20)
                        
                        // Cal
                        
                        
                        HStack {
                            Spacer()
                            Button {
                                //
                            } label: {
                                ZStack {
                                    Rectangle()
                                        .fill(AppTheme.appThemeOrange)
                                        .frame(height: 40)
                                    
                                    HStack {
                                        Image("save")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 25, height: 25)
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
                            
                            DatePicker("Select Date", selection: $selectedBirthDate,in: Date()..., displayedComponents: [.date])
                                .padding(.horizontal)
                                .datePickerStyle(.graphical)
                                .onChange(of: selectedBirthDate, perform: { value in
                                    //self.selectedBirthDateStr = String(value)
                                    let date = value
                                    let formatter = DateFormatter()
                                    
                                    formatter.dateFormat = "dd/MM/yyyy"
                                    self.selectedBirthDateStr = formatter.string(from: date)
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
                
                
                
            }
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}




