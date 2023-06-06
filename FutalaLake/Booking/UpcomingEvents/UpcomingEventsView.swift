//
//  UpcomingEventsView.swift
//  FutalaLake
//
//  Created by Abhayjeet Singh on 09/12/22.
//

import SwiftUI

struct UpcomingEventsView: View {
    @State var isView1Active: Bool = false
    @EnvironmentObject var session: SessionManager
    
    @StateObject var historyViewModel = HistoryViewModel() // ObservedObject is not working :(
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .center) {
                //AppTheme.appThemeSkyBlue
                VStack {
                    ScrollView {
                        
                        VStack(spacing: 0) {
                            
                            Slider()
                                .frame(width: UIScreen.main.bounds.width - 20,  height: 200)
                                .padding(.top)
                            
//                            Image("offers")
//                                .resizable()
//                                .frame(width: UIScreen.main.bounds.width - 20)
//                                .padding(.top)
//
//                            UpcomingEventCellView()
//                                .padding([.horizontal, .top])
                            
                            
                            
                            if historyViewModel.historyData.count > 0 {
                                
                                VStack(spacing: 0) {
                                    HStack {
                                        Text("Recent Booking")
                                        Spacer()
                                    }
                                    
                                    .font(.system(size: 18, weight: .medium, design: .default))
                                    //.padding(.horizontal, 15)
                                    .padding(.top, 20)
                                    .padding(.bottom, 10)
                                    
                                    UpcomcommingbookingStatusCell(data: historyViewModel.firstHistoryData)
                                        //.padding(.horizontal, 10)
                                        .padding(.bottom, 30)
                                }.padding(.horizontal, 13)
                                
                            }
                            Spacer()
                            
                        }
                        
                        
                    }
                    
                    Spacer()
                    
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
                        }.padding()
                        
                            .navigationTitle("Booking")
                            .onReceive(self.session.$moveToDashboard) { moveToDashboard in
                                if moveToDashboard {
                                    print("Move to dashboard: \(moveToDashboard)")
                                    self.isView1Active = false
                                    //self.session.moveToDashboard = false
                                }
                            }
                    }.frame(height: 20)
                    .padding(.bottom, 20)
                    
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
