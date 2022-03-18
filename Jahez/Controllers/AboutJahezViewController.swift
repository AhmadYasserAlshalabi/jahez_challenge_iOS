//
//  AboutJahezViewController.swift
//  Jahez
//
//  Created by iOS Developer on 08/03/2022.
//

import UIKit
import WebKit

class AboutJahezViewController: UIViewController {
    
    var webView_: WKWebView? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let configuration = WKWebViewConfiguration()
        self.webView_ = WKWebView(frame: self.view.frame, configuration: configuration)
        
        self.webView_?.frame = self.view.frame
        self.view.addSubview(webView_ ?? WKWebView())
        
        let url: URL = URL(string: "https://www.linkedin.com/in/ahmad-yasser-alshalabi-29404859/")!
        webView_?.load(URLRequest(url: url))

    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
}
