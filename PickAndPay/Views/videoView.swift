//
//  videoView.swift
//  PickAndPay
//
//  Created by James Suresh on 2022-07-06.
//

import SwiftUI
import WebKit
struct videoView: UIViewRepresentable {
    //let videoID : String
    
    func makeUIView(context: Context) -> WKWebView{
        return WKWebView()
    }
    func updateUIView(_ uiView: WKWebView, context: Context) {
        let youtubeURL = URL(string: "https://www.youtube.com/embed/kV__iZuxDGE")
        uiView.scrollView.isScrollEnabled = false
        uiView.load(URLRequest(url: youtubeURL!))
                             
    }
}



