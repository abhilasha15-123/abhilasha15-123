//
//  SixIntroVC.swift
//  Soul Tribe
//
//  Created by MAC-28 on 31/07/21.
//

import UIKit

class SixIntroVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        Config().AppUserDefaults.setValue("1", forKey: "WalkthroughCompleted")
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btngotonext(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                        let newViewController = storyBoard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                        let navigationController = UINavigationController(rootViewController: newViewController)
                        UIApplication.shared.windows.first?.rootViewController = navigationController
                        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
    }
    
  


