//
//  AppTheme.swift
//  FutalaLake
//
//  Created by Abhayjeet Singh on 09/12/22.
//

import UIKit
import SwiftUI

struct AppTheme {
    static let appThemeBlue = Color(UIColor.init(hexString: "#0C0C40"))
    static let appThemeOrange = Color(UIColor.init(hexString: "#F47F22"))
    static let appThemeRed = Color(UIColor.init(hexString: "#F42222"))
    static let appThemeSkyBlue = Color(UIColor.init(hexString: "#E1F0F7"))
    
    struct SeatColor {
        static let selected = Color(UIColor.init(hexString: "#32ECA0"))
        static let defaultColor = Color(UIColor.init(hexString: "#F47F22"))
        static let vip = Color(UIColor.init(hexString: "#7472D3"))
        static let classic = Color(UIColor.init(hexString: "#F4964C"))
        static let maintenance = Color(UIColor.init(hexString: "#F890ED"))
        static let booked = Color(UIColor.init(hexString: "#EAEAEA"))
    }
}

