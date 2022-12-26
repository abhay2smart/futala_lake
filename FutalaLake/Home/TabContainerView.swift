//
//  TabContainerView.swift
//  FutalaLake
//
//  Created by Abhayjeet Singh on 22/12/22.
//

import SwiftUI

struct TabContainerView: View {
    var body: some View {
        TabView {
            UpcomingEventsView()
                .tabItem {
                    Text("Booking")
                    Image("booking")
                }
            
            TransanctionView()
                .tabItem {
                    Text("Transanction History")
                    Image("trasanctions")
                }
            
            SettingView()
            .tabItem {
                Text("Setting")
                Image("settings")
            }
            
            
            ProfileView()
            .tabItem {
                Text("Profile")
                Image("user")
            }
        }
        
        .toolbar { 
            ToolbarItem(placement: .principal) {
                TopNavItemView()
            }
            
        }
        .accentColor(Color.white) // text color
        
        .onAppear {
                    let appearance = UITabBarAppearance()
                    appearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterial)
            appearance.backgroundColor = UIColor(AppTheme.appThemeBlue) //UIColor(Color.orange.opacity(1))
                    
                    // Use this appearance when scrolling behind the TabView:
                    UITabBar.appearance().standardAppearance = appearance
                    // Use this appearance when scrolled all the way up:
                    UITabBar.appearance().scrollEdgeAppearance = appearance
                }
        
        //.navigationBar(backgroundColor: .red, titleColor: .white)
    }
        
        
}

struct TabContainerView_Previews: PreviewProvider {
    static var previews: some View {
        TabContainerView()
    }
}
