//
//  ContentView.swift
//  FutalaLake
//
//  Created by Abhayjeet Singh on 29/11/22.
//

import SwiftUI

struct ContentView: View {
    @State var isActive:Bool = false
    @State var isBasicScreenPassed = false
    var body: some View {
        ZStack {
            if isActive {
                if isBasicScreenPassed {
                    TabContainerView()
                } else {
                    NavigationView {
                        LoginView(isLogggedIn: $isBasicScreenPassed)
                    }
                }
            } else {
                LaunchView()
            }
        }.onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
        
        
        
        
        
//        return NavigationView {
//            ZStack {
//                if self.isActive {
//                    LoginView()
//                    //TabContainerView()
//                } else {
//                    LaunchView()
//                }
//            }
//            .navigationBarTitleDisplayMode(.inline)
//
//            .navigationBar(backgroundColor: AppTheme.appThemeBlue, titleColor: .white)
//
//
//            .onAppear {
//                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                    withAnimation {
//                        self.isActive = true
//                    }
//                }
//            }
//
//        }.accentColor(.white) // back button color
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


extension View {
    
    /// Sets background color and title color for UINavigationBar.
    @available(iOS 14, *)
    func navigationBar(backgroundColor: Color, titleColor: Color) -> some View {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = UIColor(backgroundColor)

        let uiTitleColor = UIColor(titleColor)
        appearance.largeTitleTextAttributes = [.foregroundColor: uiTitleColor]
        appearance.titleTextAttributes = [.foregroundColor: uiTitleColor]

        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        
        return self
    }
}


struct NavigationConfigurator: UIViewControllerRepresentable {
    var configure: (UINavigationController) -> Void = { _ in }

    func makeUIViewController(context: UIViewControllerRepresentableContext<NavigationConfigurator>) -> UIViewController {
        UIViewController()
    }
    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<NavigationConfigurator>) {
        if let nc = uiViewController.navigationController {
            self.configure(nc)
        }
    }

}
