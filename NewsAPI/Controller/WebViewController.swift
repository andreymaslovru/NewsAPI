//
//  WebViewController.swift
//  NewsAPI
//
//  Created by Андрей Маслов on 14.10.2021.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKUIDelegate {

    @IBOutlet weak var WKWebView: WKWebView!
    
    var url = ""
    
    override func loadView() {
        let webConfig = WKWebViewConfiguration()
        WKWebView = WebKit.WKWebView(frame: .zero, configuration: webConfig)
        WKWebView.uiDelegate = self
        view = WKWebView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let getURL = url
        guard let myUrl = URL(string: getURL) else { return }
        let request = URLRequest(url: myUrl)
        WKWebView.load(request)
    }
    

}
