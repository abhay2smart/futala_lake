//
//  BookedTicketHistoryView.swift
//  FutalaLake
//
//  Created by Abhayjeet Singh on 28/12/22.
//

import SwiftUI

struct BookedTicketHistoryView: View {
    //VIP TOGGLE
    @State private var visOnA1: Bool = true
    @State private var visOnA2: Bool = true
    @State private var visOnA3: Bool = true
    @State private var visOnA4: Bool = true
    @State private var visOnA5: Bool = true
    @State private var visOnA6: Bool = true
    @State private var visOnA7: Bool = true
    @State private var visOnA8: Bool = true
    
    //CLASSIC TOGGLE
    @State private var cisOnC1: Bool = true
    @State private var cisOnC2: Bool = true
    @State private var cisOnC3: Bool = true
    @State private var cisOnC4: Bool = true
    @State private var cisOnC5: Bool = true
    @State private var cisOnC6: Bool = true
    @State private var cisOnC7: Bool = true
    @State private var cisOnC8: Bool = true
    
    @State private var selection = "1"
    let colors = ["1  ", "2  ", "3  ", "4  ", "4  "]
    
    var body: some View {
        ZStack {
            AppTheme.appThemeSkyBlue
            ScrollView {
                
                Text("Booked Ticket History")
                    .font(.system(size: 18, weight: .medium, design: .default))
                    .foregroundColor(.black)
                    .padding(.horizontal)
                
                    .frame(width: UIScreen.main.bounds.width, height: 50)
                
                    .background(
                            Rectangle()
                                .fill(AppTheme.appThemeSkyBlue)
                                //.cornerRadius(12)
                                .shadow(
                                    color: Color.gray.opacity(0.7),
                                    radius: 8,
                                    x: 0,
                                    y: 0
                                )
                        )
                    
                
                
                VStack(alignment: .leading, spacing: 5) {
                    Text("Select Seats")
                        .font(.system(size: 20, weight: .medium, design: .default))
                        .foregroundColor(.black)
                        .padding(.horizontal)
                    HStack {
                        VStack(alignment: .leading, spacing: 0)  {
                            Text("VIP")
                                .font(.system(size: 15, weight: .medium, design: .default))
                                .foregroundColor(AppTheme.appThemeOrange)
                                .padding(.horizontal)
                                .padding(.top, 10)
                            
                            //VIP
                            
                            VStack(spacing: -20) {
                                HStack(spacing: -25) {
                                    Toggle("A1", isOn: $visOnA1)
                                           .padding()
                                           .toggleStyle(CheckboxStyle())
                                    
                                    Toggle("A2", isOn: $visOnA2)
                                           .padding()
                                           .toggleStyle(CheckboxStyle())
                                    
                                    Toggle("A3", isOn: $visOnA3)
                                           .padding()
                                           .toggleStyle(CheckboxStyle())
                                    
                                    Toggle("A4", isOn: $visOnA4)
                                           .padding()
                                           .toggleStyle(CheckboxStyle())
                                    
                                }
                                
                                
                                HStack(spacing: -25) {
                                    Toggle("A5", isOn: $visOnA5)
                                           .padding()
                                           .toggleStyle(CheckboxStyle())
                                    
                                    Toggle("A6", isOn: $visOnA6)
                                           .padding()
                                           .toggleStyle(CheckboxStyle())
                                    
                                    Toggle("A7", isOn: $visOnA7)
                                           .padding()
                                           .toggleStyle(CheckboxStyle())
                                    
                                    Toggle("A8", isOn: $visOnA8)
                                           .padding()
                                           .toggleStyle(CheckboxStyle())
                                }
                            }
                            
                        }.frame(maxWidth: .infinity)
                        
                        VStack(alignment: .leading, spacing: 0)  {
                            // Classic
                            Text("CLASSIC")
                                .font(.system(size: 15, weight: .medium, design: .default))
                                .foregroundColor(AppTheme.appThemeOrange)
                                .padding(.horizontal)
                                .padding(.top, 10)
                            VStack(spacing: -20) {
                                HStack(spacing: -25) {
                                    Toggle("C1", isOn: $cisOnC1)
                                           .padding()
                                           .toggleStyle(CheckboxStyle())
                                    
                                    Toggle("C2", isOn: $cisOnC2)
                                           .padding()
                                           .toggleStyle(CheckboxStyle())
                                    
                                    Toggle("C3", isOn: $cisOnC3)
                                           .padding()
                                           .toggleStyle(CheckboxStyle())
                                    
                                    Toggle("C4", isOn: $cisOnC4)
                                           .padding()
                                           .toggleStyle(CheckboxStyle())
                                    
                                }
                                
                                
                                HStack(spacing: -25) {
                                    Toggle("C5", isOn: $cisOnC5)
                                           .padding()
                                           .toggleStyle(CheckboxStyle())
                                    
                                    Toggle("C6", isOn: $cisOnC6)
                                           .padding()
                                           .toggleStyle(CheckboxStyle())
                                    
                                    Toggle("C7", isOn: $cisOnC7)
                                           .padding()
                                           .toggleStyle(CheckboxStyle())
                                    
                                    Toggle("C8", isOn: $cisOnC8)
                                           .padding()
                                           .toggleStyle(CheckboxStyle())
                                    
                                }
                            }
                            
                        }.frame(maxWidth: .infinity)
                    }
                    .padding(.top, 10)
                    
                    .background(
                            Rectangle()
                                .fill(.white)
                                .cornerRadius(12)
                                .shadow(
                                    color: Color.gray.opacity(0.7),
                                    radius: 8,
                                    x: 0,
                                    y: 0
                                )
                        )
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                }.padding(.top, 10)
                
                
                VStack(alignment: .leading, spacing: 5) {
                    Text("Standing")
                        .multilineTextAlignment(.leading)
                        .font(.system(size: 20, weight: .medium, design: .default))
                        .foregroundColor(.black)
                        .padding(.horizontal)
                    
                    HStack {
                        Text("Number Of Tickets")
                            .multilineTextAlignment(.leading)
                            .font(.system(size: 16, weight: .medium, design: .default))
                            .foregroundColor(AppTheme.appThemeOrange)
                            .padding()
                        
                        Spacer()
                        
                        ZStack {
                            VStack {
                                
                            }.frame(width: 80, height: 30)
                                .background(
                                 Rectangle()
                                 .fill(.white)
                                 .cornerRadius(4)
                                  .shadow(
                                   color: Color.gray.opacity(0.7),
                                   radius: 8,
                                   x: 0, y: 0)
                                  )
                                .padding(10)
                                .padding(.trailing)
                            
                            Picker("", selection: $selection) {
                                ForEach(colors, id: \.self) {
                                    Text($0)
                                }
                            }
                            .pickerStyle(.menu)
                        }
                        
                    }.frame(maxWidth: .infinity)
                        .background(
                                Rectangle()
                                    .fill(.white)
                                    .cornerRadius(12)
                                    .shadow(
                                        color: Color.gray.opacity(0.7),
                                        radius: 8,
                                        x: 0,
                                        y: 0
                                    )
                            )
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                }.padding(.top, 8)
                
            }
            
            
            VStack {
                Spacer()
                Button {
                    //
                } label: {
                    Text("Cancel")
                        .modifier(CustomButtonModifiers())
                            .padding(.bottom, 60)
                }
            }
            
            
        }
        
    }
}

struct BookedTicketHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        BookedTicketHistoryView()
    }
}



struct CheckboxStyle: ToggleStyle {

    func makeBody(configuration: Self.Configuration) -> some View {

        return HStack {
            //Image(systemName: configuration.isOn ? "checkmark.square" : "square")
            Image(systemName: "square")
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundColor(configuration.isOn ? .blue : .gray)
                .font(.system(size: 20, weight: .regular, design: .default))
                .background(configuration.isOn ? AppTheme.appThemeBlue : AppTheme.appThemeOrange)
            
            configuration.label
                .multilineTextAlignment(.center)
            .padding(.leading, -27)
            .font(.system(size: 10, weight: .regular, design: .default))
            .foregroundColor(.white)
                
            
        }
        .onTapGesture { configuration.isOn.toggle() }

    }
}
