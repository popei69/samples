//
//  WebView.swift
//  PrivateWeb
//
//  Created by Benoit Pasquier on 27/2/22.
//

import UIKit
import WebKit
import SwiftUI

struct WebView: UIViewRepresentable {
    typealias UIViewType = WKWebView

    let webView: WKWebView

    func makeUIView(context: Context) -> WKWebView {
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) { }
}
