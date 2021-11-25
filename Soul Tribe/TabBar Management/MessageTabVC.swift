//
//  MessageTabVC.swift
//  Soul Tribe
//
//  Created by Ashish Soni on 07/06/21.
//

import UIKit

class MessageTabVC: UIViewController,SlideMenuControllerDelegate{

    @IBOutlet weak var optionView1: UIView!
    @IBOutlet weak var optionView1CornerRadius: UIView!
    @IBOutlet weak var alphaView_SoulBtn: UIButton!
    @IBOutlet weak var alphaView_TribeBtn: UIButton!
    
    @IBOutlet weak var messageBtn: UIButton!
    @IBOutlet weak var messageLbl: UILabel!
    @IBOutlet weak var metchBtn: UIButton!
    @IBOutlet weak var matchLbl: UILabel!
    @IBOutlet weak var view_main: UIView!
    
    @IBOutlet weak var HomeVibeBtn: UIButton!
    var CategorySelect = String()
    var leftDrawerTransition:DrawerTransition!
    var left = LeftMenuViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
    
        optionView1CornerRadius.layer.cornerRadius = 6
        messageLbl.isHidden = false
        messageLbl.backgroundColor = UIColor(red: 13/255, green: 58/255, blue: 169/255, alpha: 1.0)
        matchLbl.backgroundColor = UIColor.clear
        matchLbl.isHidden = true
        messageBtn.setTitleColor(UIColor(red: 13/255, green: 58/255, blue: 169/255, alpha: 1.0), for: .normal)
        metchBtn.setTitleColor(UIColor(red: 34/255, green: 51/255, blue: 69/255, alpha: 1.0), for: .normal)

        let controller1 = storyboard?.instantiateViewController(identifier: "MessageListVC") as! MessageListVC
        controller1.comeVIbeType = SELECT_VIBE
        controller1.view.frame = CGRect(x: 0, y: 0, width: self.view_main.frame.size.width, height: self.view_main.frame.size.height)
        controller1.willMove(toParent: self)
        self.view_main.addSubview(controller1.view)
        self.addChild(controller1)
        controller1.didMove(toParent: self)
        
        setupLeftDrawer(self)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnnotification(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(identifier: "NotificationsVC") as! NotificationsVC
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func sideMenuBtnAction(_ sender: Any) {
        self.slideMenuController()?.toggleLeft()

       //setSideMenu()
    }
    @IBAction func HometopMenuAction(_ sender: Any) {
        if self.CategorySelect == "Soul Love" {
            self.alphaView_SoulBtn.setTitleColor(UIColor.systemBlue, for: .normal)
        }else{
            self.alphaView_SoulBtn.setTitleColor(UIColor.black, for: .normal)
        }
        if self.CategorySelect == "Tribe" {
            self.alphaView_TribeBtn.setTitleColor(UIColor.systemBlue, for: .normal)
        }else{
            self.alphaView_TribeBtn.setTitleColor(UIColor.black, for: .normal)
        }
        self.optionView1.frame = self.view.frame
        self.optionView1.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        self.view.addSubview(self.optionView1)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "hide"), object: nil)
//        self.topOptionMenuView.isHidden = !self.topOptionMenuView.isHidden
    }
    
    @IBAction func HometopMenuSoulTribeAction(_ sender: Any) {
//        self.alphaView_SoulBtn.setTitleColor(UIColor.systemBlue, for: .normal)
        self.optionView1.removeFromSuperview()
//        self.topOptionMenuView.isHidden = true
//        popupview.isHidden = true
        self.CategorySelect = "Soul Love"
        self.HomeVibeBtn.setTitle("Soul Love", for: .normal)
//        self.getData(vibeType: self.CategorySelect)
    }
    @IBAction func HometopMenuTribeAction(_ sender: Any) {
//        self.alphaView_TribeBtn.setTitleColor(UIColor.systemBlue, for: .normal)
        self.optionView1.removeFromSuperview()
//        self.topOptionMenuView.isHidden = true
//        popupview.isHidden = true
//        innerpopupvc.isHidden = true
        self.CategorySelect = "Tribe"
        self.HomeVibeBtn.setTitle("Tribe", for: .normal)
//        self.getData(vibeType: self.CategorySelect)
    }
    
    @IBAction func cancel1(_ sender: Any) {
        self.optionView1.removeFromSuperview()
    }
    
    func setSideMenu() {
        self.leftDrawerTransition.presentDrawerViewController(animated: true)
    }
    
    
    //MARK: - Left drawer
    func setupLeftDrawer(_ controller: UIViewController) {
        
        self.leftDrawerTransition = DrawerTransition(target: controller, drawer: left)
        self.leftDrawerTransition.setPresentCompletion { print("left present...") }
        self.leftDrawerTransition.setDismissCompletion { print("left dismiss...") }
        self.leftDrawerTransition.edgeType = .left
        left.clickCellEvent { (indexpath) in
            
            //            if(indexpath.row == -1)
            //            {
            //                // NotificationCenter.default.post(name: Notification.Name("notifyMilesChange"), object: nil)
            //            }
            if(indexpath.row == 0){
               // let VC = self.storyboard?.instantiateViewController(withIdentifier: "TabBar") as! UITabBarController
               // self.navigationController?.pushViewController(VC, animated: true)
            }else if(indexpath.row == 1){
               // let vc = self.storyboard?.instantiateViewController(withIdentifier: "TermsConditionViewController") as! TermsConditionViewController
               // self.navigationController?.pushViewController(vc, animated: true)
            }else if(indexpath.row == 2) {
               // let vc = self.storyboard?.instantiateViewController(withIdentifier: "PrivacyPoliceVC") as! PrivacyPoliceVC
               // self.navigationController?.pushViewController(vc, animated: true)
            }
            else if indexpath.row == 3{
                //let vc = self.storyboard?.instantiateViewController(withIdentifier: "ContactUsViewController") as! ContactUsViewController
               // self.navigationController?.pushViewController(vc, animated: true)
            }else if indexpath.row == 4{
               // let vc = self.storyboard?.instantiateViewController(withIdentifier: "AboutUsViewController") as! AboutUsViewController
              //  self.navigationController?.pushViewController(vc, animated: true)
            }else if indexpath.row == 5{
                //let vc = self.storyboard?.instantiateViewController(withIdentifier: "FAQViewController") as! FAQViewController
                //self.navigationController?.pushViewController(vc, animated: true)
            }else{
                
//                let nextview = LogoutPopUp.intitiateFromNib()
//                let model = BackModel()
//
//                nextview.buttonYesHandler = {
//                    let deafults = UserDefaults.standard
//                    deafults.removeObject(forKey: "UserIDAutologin")
//                    deafults.set("0", forKey: "Logoutstatus")
//                    deafults.synchronize()
//
//                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
//                    self.navigationController?.pushViewController(vc, animated: true)
//                    model.closewithAnimation()
//                }
//
//                nextview.buttonNoHandler = {
//                    model.closewithAnimation()
//                }
               // model.showLogout(view: nextview)
            }
            self.leftDrawerTransition.dismissDrawerViewController()
        }
    }
    
    @IBAction func flagBtnAction(_ sender: Any) {
        
    }
    @IBAction func filterBtnAction(_ sender: Any) {
        
    }
    @IBAction func messageBtnAction(_ sender: Any) {
        messageLbl.isHidden = false
        messageLbl.backgroundColor = UIColor(red: 13/255, green: 58/255, blue: 169/255, alpha: 1.0)
        matchLbl.backgroundColor = UIColor.clear
        matchLbl.isHidden = true
        messageBtn.setTitleColor(UIColor(red: 13/255, green: 58/255, blue: 169/255, alpha: 1.0), for: .normal)
        metchBtn.setTitleColor(UIColor(red: 34/255, green: 51/255, blue: 69/255, alpha: 1.0), for: .normal)
        
        let controller1 = storyboard?.instantiateViewController(identifier: "MessageListVC") as! MessageListVC
        controller1.comeVIbeType = self.CategorySelect
        controller1.view.frame = CGRect(x: 0, y: 0, width: self.view_main.frame.size.width, height: self.view_main.frame.size.height)
        controller1.willMove(toParent: self)
        self.view_main.addSubview(controller1.view)
        self.addChild(controller1)
        controller1.didMove(toParent: self)
        
    }
    @IBAction func matchBtnAction(_ sender: Any) {
        
        matchLbl.isHidden = false
        matchLbl.backgroundColor = UIColor(red: 13/255, green: 58/255, blue: 169/255, alpha: 1.0)
        messageLbl.backgroundColor = UIColor.clear
        messageLbl.isHidden = true
        metchBtn.setTitleColor(UIColor(red: 13/255, green: 58/255, blue: 169/255, alpha: 1.0), for: .normal)
        messageBtn.setTitleColor(UIColor(red: 34/255, green: 51/255, blue: 69/255, alpha: 1.0), for: .normal)
        
        let controller1 = storyboard?.instantiateViewController(identifier: "MessageListVC") as! MessageListVC
        controller1.comeVIbeType = self.CategorySelect
        controller1.view.frame = CGRect(x: 0, y: 0, width: self.view_main.frame.size.width, height: self.view_main.frame.size.height)
        controller1.willMove(toParent: self)
        self.view_main.addSubview(controller1.view)
        self.addChild(controller1)
        controller1.didMove(toParent: self)
        
    }
   
  

}
