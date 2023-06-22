//
//  GIFView.swift
//  FutalaLake
//
//  Created by Abhayjeet Singh on 16/06/23.
//

import WebKit
import SwiftUI

struct GIFView: UIViewRepresentable {
    let gifName: String
    let gifExtension: String

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        guard let gifPath = Bundle.main.path(forResource: gifName, ofType: gifExtension) else {
            return
        }
        let url = URL(fileURLWithPath: gifPath)
        let request = URLRequest(url: url)
        uiView.load(request)
    }
}
