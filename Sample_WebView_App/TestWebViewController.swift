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
    }
}

extension TestWebViewController: WKScriptMessageHandlerWithReply {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage, replyHandler: @escaping (Any?, String?) -> Void) {
        print("didReceiveWithReply name: \(message.name), body: \(message.body)")
        
        let text = "Swiftからの値だよ~~\(Bundle.main.bundleIdentifier)"
        print("replayHandler呼びます 送る文字列: \(text)")
        
//        replyHandler(["result": text], nil)
        
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

            // const text = await window.webkit.messageHandlers.dismissVC2.postMessage("close2");

            try {
                // Swiftからのレスポンスを取得
                const response = await window.webkit.messageHandlers.dismissVC2.postMessage("close2");

                // エラーが返された場合
                if (response.error) {
                    throw new Error(response.error);  // エラーをスローしてcatchに渡す
                }

                // 成功時の処理
                console.log("成功:", response.result);  // 成功結果を処理する
                window.webkit.messageHandlers.dismissVC3.postMessage(`成功でした : ${response.result}`);

            } catch (error) {
                // エラー処理
                console.error("エラーが発生しました:", error.message);  // エラー内容をログに出力
                window.webkit.messageHandlers.dismissVC3.postMessage(`エラーでした : ${error.message}`);
            }
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
