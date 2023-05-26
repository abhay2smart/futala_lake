//
//  WhatsApp.swift
//  FutalaLake
//
//  Created by Abhayjeet Singh on 24/05/23.
//

import UIKit

class WhatsApp {
    private let url = ""
    static func sendMessage(msg: String) {
        let urlWhats = "whatsapp://send?text=\(msg)"
        if  let urlString = urlWhats.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            if let whatsappURL = NSURL(string: urlString) {
                if  UIApplication.shared.canOpenURL(whatsappURL as URL ) {
                    UIApplication.shared.open(whatsappURL as URL)
                }
            }
        }
    }
}
