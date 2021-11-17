//
//  NotificationSettingVC.swift
//  Soul Tribe
//
//  Created by Ashish Soni on 21/06/21.
//

import UIKit

class NotificationSettingVC: UIViewController {
    @IBOutlet weak var headerview: UIView!
    @IBOutlet weak var btnswitch: UISwitch!
    @IBOutlet weak var btnswitch2: UISwitch!

    var leftDrawerTransition:DrawerTransition!
    var left = LeftMenuViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        headerview.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        headerview.layer.shadowOpacity = 0.5
        headerview.layer.shadowOffset = .zero
        headerview.layer.shadowRadius = 5
        
//        btnswitch.transform = CGAffineTransform(scaleX: 0., y: 0.60)
//        btnswitch2.transform = CGAffineTransform(scaleX: 0.85, y: 0.60)
        // Do any additional setup after loading the view.
    }
    @IBAction func backbtnaction(_ sender:UIButton) {
        navigationController?.popViewController(animated: true)


    }
    
//    @IBAction func backbtnaction(_ sender:UIButton) {
//        let vc = self.storyboard?.instantiateViewController(identifier: "AddIntentionsVC") as! AddIntentionsVC
//        navigationController?.pushViewController(vc, animated: true)
//        
//    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
