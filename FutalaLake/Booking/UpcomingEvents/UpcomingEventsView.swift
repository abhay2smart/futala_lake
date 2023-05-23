//
//  UpcomingEventsView.swift
//  FutalaLake
//
//  Created by Abhayjeet Singh on 09/12/22.
//

import SwiftUI

struct UpcomingEventsView: View {
    @EnvironmentObject var session: SessionManager
    @State var isView1Active: Bool = false
    
    @ObservedObject var historyViewModel = HistoryViewModel()
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .center) {
                AppTheme.appThemeSkyBlue
                ScrollView {
                    
                    VStack(spacing: 10){
                        HStack {
                            Spacer()
                            Text("Futala Fountain Show")
                                .font(.system(size: 18, weight: .medium, design: .default))
                                .padding(10)
                                
                            Spacer()
                        }.background(AppTheme.appThemeOrange)
                        
                        VStack(spacing: 4) {
                            Text("Duniya ka Sabse bada")
                                .font(.system(size: 14, weight: .regular, design: .default))
                            Text("Musical Fountain")
                                .font(.system(size: 16, weight: .medium, design: .default))
                                
                        }.padding(.bottom, 10)
                        
                        HStack {
                            Spacer()
                            
                            
                            NavigationLink(destination: DateTimeSelectionView(), isActive: $isView1Active) {
                                Text("BOOK TICKET")
                                .frame(width: 140)
                                .frame(height: 34)
                                .foregroundColor(.white)
                                .background(AppTheme.appThemeOrange)
                                .clipShape(Capsule())
                                .padding(.horizontal)
                                .font(.system(size: 15, weight: .regular, design: .default))
                            }
                            .navigationTitle("Booking")
                            .onReceive(self.session.$moveToDashboard) { moveToDashboard in
                                if moveToDashboard {
                                    print("Move to dashboard: \(moveToDashboard)")
                                    self.isView1Active = false
                                    //self.session.moveToDashboard = false
                                }
                            }
                            
                            
                            
                            
                            
                            

                        }.padding(.bottom, 10)
                        
                        Image("wave")
                            .resizable()
                            .aspectRatio( contentMode: .fit)
                            .frame(width: UIScreen.main.bounds.width - 40)
                            .padding(.bottom, 10)
                        
                        
                    }
                    .border(.gray)
                    .padding(10)
                        
                    
                    
                    
                    
                    VStack(alignment: .leading, spacing: 5) {
                        
                        /*
                        Text("Upcoming Events")
                            .font(.system(size: 18, weight: .medium, design: .default))
                            .padding(.horizontal, 15)
                            .padding(.top, 20)
                        
                        ForEach(1..<2) { index in
                            
                            NavigationLink(destination: DateTimeSelectionView(), isActive: $isView1Active) {
                                UpcomingEventCellView()
                            }
                            .navigationTitle("Booking")
                            .onReceive(self.session.$moveToDashboard) { moveToDashboard in
                                if moveToDashboard {
                                    print("Move to dashboard: \(moveToDashboard)")
                                    self.isView1Active = false
                                    //self.session.moveToDashboard = false
                                }
                            }
                            
                            
                        }
                         */
                        
                        
                        
                        Text("Upcoming Booking")
                            .font(.system(size: 18, weight: .medium, design: .default))
                            .padding(.horizontal, 15)
                            .padding(.top, 20)
                            .padding(.bottom, 10)
                        
                        UpcomcommingbookingStatusCell()
                            .padding(.horizontal, 10)
                            .padding(.bottom, 30)
                        
                    }
                    
                }
                if historyViewModel.isLoading {
                    Loader()
                }
            }.onAppear {
                historyViewModel.fetchHistory()
            }
            
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text("Booking").font(.subheadline)
                    }.foregroundColor(.white)
                }
            }
            
//            .toolbar { // <2>
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    TopNavItemView()
//                }
//            }
            
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct UpcomingEventsView_Previews: PreviewProvider {
    static var previews: some View {
        UpcomingEventsView()
    }
}
