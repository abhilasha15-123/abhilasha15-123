//
//  SettingsVC.swift
//  Soul Tribe
//
//  Created by Ashish Soni on 11/06/21.
//

import UIKit

class SettingsVC: UIViewController {
    @IBOutlet weak var Paswrdview: UIView!
    @IBOutlet weak var Emailview: UIView!
    @IBOutlet weak var PhoneNOview: UIView!
    @IBOutlet weak var headerview: UIView!

    var leftDrawerTransition:DrawerTransition!
    var left = LeftMenuViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true

        Paswrdview.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        Paswrdview.layer.shadowOpacity = 0.5
        Paswrdview.layer.shadowOffset = .zero
        Paswrdview.layer.shadowRadius = 5
        Paswrdview.layer.cornerRadius = 12
        
        Emailview.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        Emailview.layer.shadowOpacity = 0.5
        Emailview.layer.shadowOffset = .zero
        Emailview.layer.shadowRadius = 5
        Emailview.layer.cornerRadius = 12
       
        PhoneNOview.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        PhoneNOview.layer.shadowOpacity = 0.5
        PhoneNOview.layer.shadowOffset = .zero
        PhoneNOview.layer.shadowRadius = 5
        PhoneNOview.layer.cornerRadius = 12
      
        headerview.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        headerview.layer.shadowOpacity = 0.5
        headerview.layer.shadowOffset = .zero
        headerview.layer.shadowRadius = 5

        // Do any additional setup after loading the view.
    }
    @IBAction func backbtnaction(_ sender:UIButton) {
        self.slideMenuController()?.toggleLeft()

    }

    @IBAction func btnpasword(_ sender:UIButton) {
        let vc = self.storyboard?.instantiateViewController(identifier: "ChangePasswordViewController") as! ChangePasswordViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
