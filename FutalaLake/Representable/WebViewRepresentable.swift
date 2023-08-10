//
//  WebViewRepresentable.swift
//  FutalaLake
//
//  Created by Abhayjeet Singh on 11/05/23.
//



import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    //    // 1
    //    let url: URL
    //
    //
    //    // 2
    //    func makeUIView(context: Context) -> WKWebView {
    //
    //        return WKWebView()
    //    }
    //
    //    // 3
    //    func updateUIView(_ webView: WKWebView, context: Context) {
    //
    //        let request = URLRequest(url: url)
    //        webView.load(request)
    //    }
    //
    
    @ObservedObject var viewModel: WebViewModel
    let webView = WKWebView()
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self.viewModel)
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        private var viewModel: WebViewModel
        
        init(_ viewModel: WebViewModel) {
            self.viewModel = viewModel
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            self.viewModel.isLoading = false
        }
        
        
        
        
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            print("webView:\(webView) decidePolicyForNavigationAction:\(navigationAction) decisionHandler:\(decisionHandler)")
            
            if let url = navigationAction.request.url {
                print("ABHAY88 \(url.absoluteString)")
                
                
                if (url.absoluteString.contains("success")) {
                    self.viewModel.paymentStatus = 1
                    self.viewModel.shouldGoToSuccess = true
                    self.viewModel.shouldGoToFailure = false
                } else if (url.absoluteString.contains("failure")) {
                    self.viewModel.paymentStatus = 0
                    self.viewModel.shouldGoToSuccess = false
                    self.viewModel.shouldGoToFailure = true
                }
            }
            decisionHandler(.allow)
        }
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<WebView>) { }
    
    func makeUIView(context: Context) -> UIView {
        self.webView.navigationDelegate = context.coordinator
        
        if let url = URL(string: self.viewModel.url) {
            self.webView.load(URLRequest(url: url))
        }
        
        return self.webView
    }
    
}

class WebViewModel: ObservableObject {
    @Published var url: String
    @Published var isLoading: Bool = true
    @Published var paymentStatus:Int = -1
    
    @Published var shouldGoToSuccess:Bool = false
    @Published var shouldGoToFailure:Bool = false
    
    init (url: String) {
        self.url = url
    }
}



extension WebView {
    
    //    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    //        print("finished")
    //    }
    //    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
    //        print("abhay \(error.localizedDescription)")
    //    }
    //
    //    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
    //        if navigationAction.targetFrame == nil {
    //            webView.load(navigationAction.request)
    //        }
    //        return nil
    //    }
    //
    //    func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
    //        let cred = URLCredential(trust: challenge.protectionSpace.serverTrust!)
    //        completionHandler(.useCredential, cred)
    //    }
    
    
    
}



struct WebViewHTML: UIViewRepresentable {
    @Binding var text: String
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.loadHTMLString(text, baseURL: nil)
    }
}






