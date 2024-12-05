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
//        contentController.add(self, name: "dismissVC2")
        contentController.addScriptMessageHandler(self, contentWorld: .page, name: "dismissVC2")
        contentController.add(self, name: "dismissVC3")

        let webConfiguration = WKWebViewConfiguration()
        webConfiguration.userContentController = contentController
        
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        view = webView
        
//        guard let url = URL(string: "https://takamasa-fukase.github.io/Sample_WebView_App/test_web_view.html") else { return }
//        let request = URLRequest(url: url)
//        webView?.load(request)
        
        webView?.loadHTMLString(htmlText, baseURL: nil)
    }
}

extension TestWebViewController: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print("didReceive name: \(message.name), body: \(message.body)")
//        if message.name == "dismissVC",
//           message.body as? String == "close" {
//            print("closeだった")
//            dismiss(animated: true)
//            
//        } else {
//            print("closeじゃない")
//        }
    }
}

extension TestWebViewController: WKScriptMessageHandlerWithReply {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage, replyHandler: @escaping (Any?, String?) -> Void) {
        print("didReceiveWithReply name: \(message.name), body: \(message.body)")
//        if message.name == "dismissVC",
//           message.body as? String == "close" {
//            print("closeだった")
//            dismiss(animated: true)
//            
//        } else {
//            print("closeじゃない")
//        }
        
        let text = "Swiftからの値だよ~~\(Bundle.main.bundleIdentifier)"
        print("replayHandler呼びます 送る文字列: \(text)")
        
        replyHandler(text, nil)
//        replyHandler(nil, "エラーだよー")
    }
}



let htmlText = """

<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>WebViewとSwiftの連携</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            background-color: #87CEEB;
        }
        .container {
            text-align: center;
            padding: 20px;
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        h1 {
            font-size: 24px;
            margin-bottom: 20px;
        }
        button {
            font-size: 20px;
            padding: 10px 20px;
            background-color: #007BFF;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        button:hover {
            background-color: #0056b3;
        }
    </style>
    <script>
        // function notifyApp() {
        //     window.webkit.messageHandlers.dismissVC.postMessage("close");
        //     const text = window.webkit.messageHandlers.dismissVC2.postMessage("close2");
        //     window.webkit.messageHandlers.dismissVC3.postMessage(`close3 textの中身: ${text}`);
        // }
        const notifyApp = async () => {
            window.webkit.messageHandlers.dismissVC.postMessage("close");
            const text = await window.webkit.messageHandlers.dismissVC2.postMessage("close2");
            window.webkit.messageHandlers.dismissVC3.postMessage(`close3 textの中身: ${text}`);
        }
    </script>
</head>
<body>
    <div class="container">
        <h1>WebViewからSwiftに通知するデモ</h1>
        <button onclick="notifyApp()">閉じる べいべ</button>
    </div>
</body>
</html>

"""
