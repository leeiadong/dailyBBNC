//
//  ArticleDetailView.swift
//  dailyBBNC
//
//  Created by sean on 2021/5/8.
//

import SwiftUI
import WebKit

struct ArticleDetailView: View {
    let url: String
    
    var body: some View {
        SwiftUIWKWebView(url: URL(string: url)!)
    }
}

struct SwiftUIWKWebView: UIViewRepresentable {
  
  var url: URL
  
  func makeUIView(context: Context) -> WKWebView {
    let request = URLRequest(url: url)
    let webview = WKWebView()
    webview.load(request)
    return webview
  }
  
  func updateUIView(_ uiView: WKWebView, context: Context) {
    //
  }
}

//struct ArticleDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        ArticleDetailView(url: "https://www.toutiao.com/a6893019103385092619?wid=1620489169223")
//    }
//}
