//
//  UpcomingEventsView.swift
//  FutalaLake
//
//  Created by Abhayjeet Singh on 09/12/22.
//

import SwiftUI

struct UpcomingEventsView: View {
    
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
                            NavigationLink {
                                DateTimeSelectionView()
                            } label: {
                                UpcomingEventCellView()
                            }.navigationTitle("Booking")
                            
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
