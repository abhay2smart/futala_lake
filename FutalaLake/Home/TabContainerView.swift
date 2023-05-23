//
//  TabContainerView.swift
//  FutalaLake
//
//  Created by Abhayjeet Singh on 22/12/22.
//

import SwiftUI

struct TabContainerView: View {
    @ObservedObject var masterConfigViewModel = MasterConfigViewModel()
    var body: some View {
        ZStack {
            TabView {
                UpcomingEventsView()
                //PayNowView()
                    .tabItem {
                        Text("Booking")
                        Image("booking")
                    }
                
                ProfileView()
                    .tabItem {
                        Text("Profile")
                        Image("user")
                    }
                
                TransanctionView()
                    .tabItem {
                        Text("History")
                        Image("trasanctions")
                    }
                
                SettingView()
                    .tabItem {
                        Text("Setting")
                        Image("settings")
                    }
                
                
                
            }
        }
        
        .onAppear {
            masterConfigViewModel.fetchMasterConfigData()
        }
        
        .navigationBarColor(backgroundColor: AppTheme.appThemeBlue, titleColor: .white)
        .navigationBarTitleDisplayMode(.inline)
        
        .onAppear {
            // bottom navbar config
            let appearance = UITabBarAppearance()
            appearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterial)
            appearance.backgroundColor = UIColor(AppTheme.appThemeBlue) //UIColor(Color.orange.opacity(1))
            
            // Use this appearance when scrolling behind the TabView:
            UITabBar.appearance().standardAppearance = appearance
            // Use this appearance when scrolled all the way up:
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct TabContainerView_Previews: PreviewProvider {
    static var previews: some View {
        TabContainerView()
    }
}

// for top navbar
struct NavigationBarModifier: ViewModifier {
    
    var backgroundColor: UIColor?
    var titleColor: UIColor?
    
    
    init(backgroundColor: Color, titleColor: UIColor?) {
        self.backgroundColor = UIColor(backgroundColor)
        
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithTransparentBackground()
        coloredAppearance.backgroundColor = UIColor(backgroundColor)
        coloredAppearance.titleTextAttributes = [.foregroundColor: titleColor ?? .white]
        coloredAppearance.largeTitleTextAttributes = [.foregroundColor: titleColor ?? .white]
        coloredAppearance.shadowColor = .clear
        
        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().compactAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
        UINavigationBar.appearance().tintColor = titleColor
    }
    
    func body(content: Content) -> some View {
        ZStack{
            content
            VStack {
                GeometryReader { geometry in
                    Color(self.backgroundColor ?? .clear)
                        .frame(height: geometry.safeAreaInsets.top)
                        .edgesIgnoringSafeArea(.top)
                    Spacer()
                }
            }
        }
    }
}


// for top navbar
extension View {
    
    func navigationBarColor(backgroundColor: Color, titleColor: UIColor?) -> some View {
        self.modifier(NavigationBarModifier(backgroundColor: backgroundColor, titleColor: titleColor))
    }
    
}
