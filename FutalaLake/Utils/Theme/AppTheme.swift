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
    //static let appThemeOrange = Color(UIColor.init(hexString: "#F47F22"))
    static let appThemeOrange = Color(UIColor.init(hexString: "#FFFD8E23"))
    static let appThemeRed = Color(UIColor.init(hexString: "#F42222"))
    static let appThemeSkyBlue = Color(UIColor.init(hexString: "#E1F0F7"))
    
    struct SeatColor {
        
        static let selected = Color(UIColor.init(hexString: "#FF1EA83C"))
        static let defaultColor = Color(UIColor.init(hexString: "#E1EFF6"))
        static let vip = Color(UIColor.init(hexString: "#7472D3"))
        static let classic = Color(UIColor.init(hexString: "#F4964C"))
        //static let maintenance = Color(UIColor.init(hexString: "#F890ED"))
        static let maintenance = Color(UIColor.init(hexString: "#FF3333"))
        static let booked = Color(UIColor.init(hexString: "#EAEAEA"))
        
        
        
        
        static var colorList = [
            //ColorCode(key: "blue", color: Color(UIColor.init(hexString: "#908EDC"))),
            ColorCode(key: "blue", color: Color(UIColor.init(hexString: "#FF003CCE"))),
            //ColorCode(key: "orange", color: Color(UIColor.init(hexString: "#F6AB70"))),
            ColorCode(key: "orange", color: Color(UIColor.init(hexString: "#FFFD8E23"))),
            ColorCode(key: "Spring Field", color: Color(UIColor.init(hexString: "#4C7265"))),
            ColorCode(key: "Ultra Moss", color: Color(UIColor.init(hexString: "#D4F54D"))),
            ColorCode(key: "glided", color: Color(UIColor.init(hexString: "#F6E54E"))),
            ColorCode(key: "stormfang", color: Color(UIColor.init(hexString: "#7EABC1"))),
            ColorCode(key: "velvet", color: Color(UIColor.init(hexString: "#710B48"))),
            ColorCode(key: "Sailing Safari", color: Color(UIColor.init(hexString: "#3B5465"))),
            ColorCode(key: "Pea Case", color: Color(UIColor.init(hexString: "#749F3D"))),
            ColorCode(key: "Selected", color: SeatColor.selected),
            ColorCode(key: "booked", color: SeatColor.booked),
            ColorCode(key: "maintenance", color: SeatColor.maintenance)
        ]
        
        static func isColorMatched(colorName: String)->Color {
            for color in AppTheme.SeatColor.colorList {
                if color.key.lowercased() == colorName.lowercased() {
                    return color.color
                }
            }
            return .black
        }
        
//        static let blue = ColorCode(key: "blue", color: Color(UIColor.init(hexString: "#908EDC")))
//        static let orange = ColorCode(key: "orange", color: Color(UIColor.init(hexString: "#F6AB70")))
//        static let springfield = ColorCode(key: "spring_field", color: Color(UIColor.init(hexString: "#4C7265")))
//        static let ultramoss = ColorCode(key: "ultra_moss", color: Color(UIColor.init(hexString: "#D4F54D")))
//        static let glided = ColorCode(key: "glided", color: Color(UIColor.init(hexString: "#F6E54E")))
//        static let stormfang = ColorCode(key: "stormfang", color: Color(UIColor.init(hexString: "#7EABC1")))
//        static let velvet = ColorCode(key: "velvet", color: Color(UIColor.init(hexString: "#710B48")))
//        static let sailingSafari = ColorCode(key: "sailing_safari", color: Color(UIColor.init(hexString: "#3B5465")))
//        static let peaCase = ColorCode(key: "pea_case", color: Color(UIColor.init(hexString: "#749F3D")))
//        static let copenhagenBlue = ColorCode(key: "copenhagen_blue", color: Color(UIColor.init(hexString: "#226190")))
        
    }
    
    struct ColorCode {
        let key:String
        let color: Color
    }
}




    
    
    
    
