//
//  WebVwViewController.swift
//  Soul Tribe
//
//  Created by mac-14 on 16/11/21.
//

import UIKit
import WebKit

class WebVwViewController: UIViewController {

    
    @IBAction func btn_backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

    
    @IBOutlet weak var vw_disp: UIView!
    
    var urlStr = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        
        let webView = WKWebView(frame: CGRect(x: 0, y: 0, width: vw_disp.frame.size.width, height: vw_disp.frame.size.height))
        webView.navigationDelegate = self
        webView.uiDelegate = self
        
        self.vw_disp.addSubview(webView)
        
        let url = URL(string: urlStr)
       
        if url != nil {
//            basicFunctions.presentLoader()
            webView.load(URLRequest(url: url!))
        }
    }
}


extension WebVwViewController : WKNavigationDelegate, WKUIDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
//        basicFunctions.stopLoading()
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
//        basicFunctions.stopLoading()
    }
}
