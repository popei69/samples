//
//  ViewController.swift
//  WebkitSample
//
//  Created by Benoit PASQUIER on 20/11/2017.
//  Copyright © 2017 Benoit PASQUIER. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    
    var webView: WKWebView!
    
    private func setupWebView() {
        
        let contentController = WKUserContentController()
        let userScript = WKUserScript(
            source: "mobileHeader()",
            injectionTime: .atDocumentEnd,
            forMainFrameOnly: true
        )
        contentController.addUserScript(userScript)
        contentController.add(self, name: "loginAction")
        
        let config = WKWebViewConfiguration()
        config.userContentController = contentController
        self.webView = WKWebView(frame: self.view.bounds, configuration: config)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.setupWebView()
        self.view.addSubview(self.webView)
        
        if let url = URL(string: "http://localhost:8888/web/webkitSample/index.html") { 
            let request = URLRequest(url: url)
            self.webView.load(request)
        }
    }
}

extension ViewController: WKScriptMessageHandler {
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == "loginAction" {
            print("JavaScript is sending a message \(message.body)")
        }
    }
}
