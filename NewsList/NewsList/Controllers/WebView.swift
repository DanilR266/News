//
//  WebView.swift
//  NewsList
//
//  Created by Данила on 04.02.2023.
//

import Foundation
import WebKit


class WebViewController: UIViewController, WKNavigationDelegate {
    
    var webView: WKWebView!
    let str: String
    
    init(string: String) {
        self.str = string
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
        let url = URL(string: str)!
        var urlRequest = URLRequest(url: url)
        urlRequest.cachePolicy = .returnCacheDataElseLoad
        webView.load(urlRequest)
        webView.allowsBackForwardNavigationGestures = true
    }
    
    
}
