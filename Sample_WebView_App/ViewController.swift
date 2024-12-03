//
//  ViewController.swift
//  Sample_WebView_App
//
//  Created by ウルトラ深瀬 on 3/12/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func showTestWebViewButtonTapped(_ sender: Any) {
        present(TestWebViewController(), animated: true)
    }
    
    @IBAction func showWebViewButtonTapped(_ sender: Any) {
        
    }
}

