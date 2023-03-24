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
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .center) {
                AppTheme.appThemeSkyBlue
                ScrollView {
                    VStack(alignment: .leading, spacing: 5) {
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
                            
//                            NavigationLink {
//                                DateTimeSelectionView()
//                            } label: {
//                                UpcomingEventCellView()
//                            }.navigationTitle("Booking")
                            
                        }
                        
                        
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
            }
            
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text("Booking").font(.subheadline)
                    }.foregroundColor(.white)
                }
            }
            
            .toolbar { // <2>
                ToolbarItem(placement: .navigationBarTrailing) {
                    TopNavItemView()
                }
            }
            
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct UpcomingEventsView_Previews: PreviewProvider {
    static var previews: some View {
        UpcomingEventsView()
    }
}
