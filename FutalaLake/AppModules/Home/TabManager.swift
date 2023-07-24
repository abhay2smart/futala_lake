//
//  TabManager.swift
//  FutalaLake
//
//  Created by Abhayjeet Singh on 08/07/23.
//

import Foundation

enum TabSelection {
    case booking
    case profile
    case history
    case settings
}

class TabSelectionManager: ObservableObject {
    @Published var selectedTab: TabSelection = .booking
}
