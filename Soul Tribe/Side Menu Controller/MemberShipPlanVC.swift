//
//  MemberShipPlanVC.swift
//  Soul Tribe
//
//  Created by Ashish Soni on 11/06/21.
//

import UIKit

class MemberShipPlanVC: UIViewController {
    @IBOutlet weak var mainview: UIView!
    @IBOutlet weak var innerview: UIView!
    @IBOutlet weak var headerview: UIView!

    var leftDrawerTransition:DrawerTransition!
    var left = LeftMenuViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainview.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        mainview.layer.shadowOpacity = 0.8
        mainview.layer.shadowOffset = .zero
        mainview.layer.shadowRadius = 6
        mainview.layer.cornerRadius = 10
        innerview.layer.cornerRadius = 10
        
        
        headerview.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        headerview.layer.shadowOpacity = 0.5
        headerview.layer.shadowOffset = .zero
        headerview.layer.shadowRadius = 5

        self.navigationController?.isNavigationBarHidden = true

        // Do any additional setup after loading the view.
    }
    @IBAction func backbtnaction(_ sender:UIButton) {
        self.slideMenuController()?.toggleLeft()



    }

    

}
