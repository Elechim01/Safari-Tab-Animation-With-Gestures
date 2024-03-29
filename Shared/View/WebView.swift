//
//  WebView.swift
//  Safari Tab Animation With Gestures (iOS)
//
//  Created by Michele Manniello on 26/09/21.
//

import SwiftUI
import WebKit

struct WebView : UIViewRepresentable{
    
    var tab : Tab
//    returing Webpage Title...
    var onComplete : (String) -> ()
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    func makeUIView(context: Context) -> WKWebView {
         
        let webView = WKWebView()
        let url = URL(string: tab.tabURL)!
        webView.load(URLRequest(url: url))
        webView.navigationDelegate = context.coordinator
        return webView
        
    }
    func updateUIView(_ uiView: WKWebView, context: Context) {
//        Scaling View to fit the size...
//        removing padding and spacing...
        let actualWidth =  (getRect().width - 60)
        let cardWidth = actualWidth / 2
        
        let scale = cardWidth / actualWidth
        
        uiView.transform = CGAffineTransform(scaleX: scale, y: scale)
    }
    
    class Coordinator: NSObject,WKNavigationDelegate {
        
        var parent : WebView
        
        init(parent: WebView){
            self.parent = parent
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            let title = webView.title ?? ""
            parent.onComplete(title.components(separatedBy: " ").first ?? "")
        }
    }
}

struct WebView_Previews: PreviewProvider {
    static var previews: some View{
        ContentView()
    }
}
