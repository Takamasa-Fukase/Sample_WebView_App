//
//  ViewController.swift
//  Sample_WebView_App
//
//  Created by ウルトラ深瀬 on 3/12/24.
//

import UIKit
import Sample_WebView_SDK

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func showTestWebViewButtonTapped(_ sender: Any) {
        let vc = TestWebViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    @IBAction func showWebViewButtonTapped(_ sender: Any) {
        let sdk = WebViewSDK()
        sdk.openWebView(withPresenting: self)
    }
}

