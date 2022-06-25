//
//  WebViewModel.swift
//  PrivateWeb
//
//  Created by Benoit Pasquier on 27/2/22.
//

import Combine
import WebKit

class WebViewModel: ObservableObject {
    let webView: WKWebView

    private let navigationDelegate: WebViewNavigationDelegate

    init() {
        let configuration = WKWebViewConfiguration()
        configuration.websiteDataStore = .nonPersistent()
        webView = WKWebView(frame: .zero, configuration: configuration)
        navigationDelegate = WebViewNavigationDelegate()

        webView.navigationDelegate = navigationDelegate
        setupBindings()
    }

    @Published var urlString: String = ""
    @Published var canGoBack: Bool = false
    @Published var canGoForward: Bool = false
    @Published var isLoading: Bool = false

    private func setupBindings() {
        webView.publisher(for: \.canGoBack)
            .assign(to: &$canGoBack)

        webView.publisher(for: \.canGoForward)
            .assign(to: &$canGoForward)

        webView.publisher(for: \.isLoading)
            .assign(to: &$isLoading)

    }

    func loadUrl() {
        guard let url = URL(string: urlString) else {
            return
        }

        webView.load(URLRequest(url: url))
    }

    func goForward() {
        webView.goForward()
    }

    func goBack() {
        webView.goBack()
    }
}

