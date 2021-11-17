//
//  LeftMenuViewController.swift
//  AssanUser
//
//  Created by Sensu Soft on 31/07/17.
//  Copyright © 2017 Sensussoft. All rights reserved.
//

import UIKit
let KEY_SIDEMENU_IMAGE = "SIDEMENU_IMAGE"
let KEY_SIDEMENU_ITEM = "SIDEMENU_ITEM"
let KEY_SIDEMENU_SELECTED = "KEY_SIDEMENU_SELECTED"

class LeftMenuViewController: UIViewController {
    
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
   
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var lblMiles: UILabel!
    @IBOutlet weak var milesSlider: UISlider!
    
   // @IBOutlet weak var viewRatting: HCSStarRatingView!
    @IBOutlet weak var lblRatting: UILabel!
    
    @IBOutlet weak var stepperControl: UIStepper!
    
    @IBOutlet weak var viewTopHeader: UIView!
   // @IBOutlet weak var viewTopround: UIView!

    
    var arrListMenu = [[String: AnyObject]]()
    typealias CompletionBlock = (IndexPath) -> Void
    var menuClickBlock : CompletionBlock!
    var leftDrawerTransition:DrawerTransition!
    
    var dicAchivementTotal : [String : AnyObject]!
    
    var defaults:UserDefaults!
    var userid: Int!
    var usrImg = String()
    var usrName = String()
    var langugeDefault = String()
    
    var storyboard1: UIStoryboard!
    var navController : UINavigationController!
    var window: UIWindow?
    
    
    
    
    var data = false
    var nameArray = ["Home","Who Liked Me","Block List","Membership Plans","Advertise on Soul Tribe","Settings","Invite Friends","Rate Soul Tribe","T&C","FAQ’s","Logout"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // doSetupUI()
       // viewTopHeader.roundCorners([.topLeft, .bottomRight], radius: 10)
        //viewTopround.layer.cornerRadius = 8
    }
    
    func doSetupUI() {
//        
//        tblView.register(UINib.init(nibName: "SideMenuCell", bundle: nil), forCellReuseIdentifier: "cell")
//        tblView.delegate = self
//        tblView.dataSource = self
//        tblView.tableFooterView = UIView()
    }
    
   
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
      
//        imgProfile.layer.cornerRadius = imgProfile.frame.width/2
//        imgProfile.layer.masksToBounds = true
      
//        let window = self.view.superview
//        self.view.removeFromSuperview()
//        window?.addSubview(self.view)
//
       
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
     //   doSetupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
      //  doSetupUI()
        
    }
    @IBAction func profileBtnAction(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name("profile"), object: nil)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnclose(_ sender: UIButton) {
        self.slideMenuController()?.toggleLeft()

    }
    
    func clickCellEvent(completion : @escaping CompletionBlock)  {
        menuClickBlock = completion
    }

    
}

extension LeftMenuViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SideMenuCell
        cell.lblItem.text = nameArray[indexPath.item]
        if  indexPath.row == 1{
            cell.crown_icon.isHidden = false
        }
        else
        {
            cell.crown_icon.isHidden = true
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            let navigate = storyboard?.instantiateViewController(withIdentifier: "TTabBarViewController") as! TTabBarViewController
            self.slideMenuController()?.changeMainViewController(UINavigationController(rootViewController: navigate), close: true)
        }
        else if indexPath.row == 1 {
            let navigate = storyboard?.instantiateViewController(withIdentifier: "WhoLikedMeVC") as! WhoLikedMeVC
            self.slideMenuController()?.changeMainViewController(UINavigationController(rootViewController: navigate), close: true)
        }
        else if indexPath.row == 2 {
            let navigate = storyboard?.instantiateViewController(withIdentifier: "BlockListVC") as! BlockListVC
            self.slideMenuController()?.changeMainViewController(UINavigationController(rootViewController: navigate), close: true)
        }
        else if indexPath.row == 3 {
            let navigate = storyboard?.instantiateViewController(withIdentifier: "MemberShipPlanVC") as! MemberShipPlanVC
            self.slideMenuController()?.changeMainViewController(UINavigationController(rootViewController: navigate), close: true)
        }
        else if indexPath.row == 4 {
            let navigate = storyboard?.instantiateViewController(withIdentifier: "AdvertiseOnSoulTribeVC") as! AdvertiseOnSoulTribeVC
            self.slideMenuController()?.changeMainViewController(UINavigationController(rootViewController: navigate), close: true)
        }
        else if indexPath.row == 5 {
            let navigate = storyboard?.instantiateViewController(withIdentifier: "SettingsVC") as! SettingsVC
            self.slideMenuController()?.changeMainViewController(UINavigationController(rootViewController: navigate), close: true)
        }
        else if indexPath.row == 6 {
            let navigate = storyboard?.instantiateViewController(withIdentifier: "InviteFriendVC") as! InviteFriendVC
            self.slideMenuController()?.changeMainViewController(UINavigationController(rootViewController: navigate), close: true)
        }
        else if indexPath.row == 7 {
            let navigate = storyboard?.instantiateViewController(withIdentifier: "RateSoulTribeVC") as! RateSoulTribeVC
            self.slideMenuController()?.changeMainViewController(UINavigationController(rootViewController: navigate), close: true)
        }
        else if indexPath.row == 8 {
            let navigate = storyboard?.instantiateViewController(withIdentifier: "T_CVC") as! T_CVC
            self.slideMenuController()?.changeMainViewController(UINavigationController(rootViewController: navigate), close: true)
        }
        else if indexPath.row == 9 {
            let navigate = storyboard?.instantiateViewController(withIdentifier: "FAQ_sVC") as! FAQ_sVC
            self.slideMenuController()?.changeMainViewController(UINavigationController(rootViewController: navigate), close: true)
        }
//        else if indexPath.row == 10 {
//            let navigate = storyboard?.instantiateViewController(withIdentifier: "FAQ_sVC") as! FAQ_sVC
//            self.slideMenuController()?.changeMainViewController(UINavigationController(rootViewController: navigate), close: true)
//        }
        else if indexPath.row == 10 {
            //let navigate = storyboard?.instantiateViewController(withIdentifier: "LogoutVC") as! LogoutVC
           
            let alert = UIAlertController(title: "LOGOUT", message: "Are you Want to Quit?", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                                let newViewController = storyBoard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                                let navigationController = UINavigationController(rootViewController: newViewController)
                                UIApplication.shared.windows.first?.rootViewController = navigationController
                                UIApplication.shared.windows.first?.makeKeyAndVisible()

               // self.navigationController?.popToRootViewController(animated: true)
                // Code in this block will trigger when OK button tapped.
                        print("Ok button tapped");
                        
                    }
            alert.addAction(OKAction)
                    
                    // Create Cancel button
                    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction!) in
                        print("Cancel button tapped");
                    }
            alert.addAction(cancelAction)
                    
                    // Present Dialog message
                    self.present(alert, animated: true, completion:nil)
            //self.slideMenuController()?.changeMainViewController(UINavigationController(rootViewController: navigate), close: true)
        }
        
        
        
//        for i in 0 ..< self.arrListMenu.count
//        {
//            if(i==indexPath.row)
//            {
//                self.arrListMenu[i]["is_selected"] = "true" as AnyObject
//            }
//            else
//            {
//                self.arrListMenu[i]["is_selected"] = "false" as AnyObject
//            }
//            self.tblView.reloadData()
//        }
//
//        menuClickBlock(indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50

    }
}
