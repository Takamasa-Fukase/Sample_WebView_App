//
//  TestWebViewController.swift
//  Sample_WebView_App
//
//  Created by ウルトラ深瀬 on 3/12/24.
//

import UIKit
import WebKit

class TestWebViewController: UIViewController {
    private var webView: WKWebView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let contentController = WKUserContentController()
        contentController.add(self, name: "dismissVC")
        
        let webConfiguration = WKWebViewConfiguration()
        webConfiguration.userContentController = contentController
        
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView?.uiDelegate = self
        webView?.navigationDelegate = self
        view = webView
        
        guard let url = URL(string: "https://takamasa-fukase.github.io/Sample_WebView_App/test_web_view.html") else { return }
        let request = URLRequest(url: url)
        webView?.load(request)
    }
}

extension TestWebViewController: WKUIDelegate {
    
}

extension TestWebViewController: WKNavigationDelegate {
    
}

extension TestWebViewController: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print("didReceive message: \(message)")
        if message.name == "dismissVC",
           message.body as? String == "close" {
            print("closeだった")
            dismiss(animated: true)
            
        } else {
            print("closeじゃない")
        }
    }
}
