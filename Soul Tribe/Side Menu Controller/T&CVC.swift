//
//  T&CVC.swift
//  Soul Tribe
//
//  Created by Ashish Soni on 11/06/21.
//

import UIKit
import WebKit

class T_CVC: UIViewController {
    @IBOutlet weak var headerview: UIView!
    var leftDrawerTransition:DrawerTransition!
    var left = LeftMenuViewController()

    @IBOutlet weak var web_View: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true

          headerview.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
          headerview.layer.shadowOpacity = 0.5
          headerview.layer.shadowOffset = .zero
          headerview.layer.shadowRadius = 5
        
        let url = URL(string: "https://soultribenow.com/terms")
        let request = URLRequest(url: url!)
        
        web_View.load(request)
    }
    
    @IBAction func backbtnaction(_ sender:UIButton) {
        self.slideMenuController()?.toggleLeft()
    }


}
