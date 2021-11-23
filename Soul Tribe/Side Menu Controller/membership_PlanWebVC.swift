//
//  FAQ'sVC.swift
//  Soul Tribe
//
//  Created by Ashish Soni on 11/06/21.
//

import UIKit
import WebKit

class membership_PlanWebVC: UIViewController {
//    @IBOutlet weak var searchview: UIView!
    @IBOutlet weak var headerview: UIView!

    @IBOutlet weak var web_VIew: WKWebView!
    var leftDrawerTransition:DrawerTransition!
    var left = LeftMenuViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true

        // Do any additional setup after loading the view.
//        searchview.layer.cornerRadius = 6
//        searchview.layer.borderWidth = 1
//        searchview.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        headerview.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        headerview.layer.shadowOpacity = 0.5
        headerview.layer.shadowOffset = .zero
        headerview.layer.shadowRadius = 5
        //@IBOutlet weak var searchview: UIView!
        
        let url = URL(string: "https://soultribenow.com/dashboard")
        let request = URLRequest(url: url!)
        
        web_VIew.load(request)

    }
    
    @IBAction func backbtnaction(_ sender:UIButton) {
        self.slideMenuController()?.toggleLeft()

    }
}
