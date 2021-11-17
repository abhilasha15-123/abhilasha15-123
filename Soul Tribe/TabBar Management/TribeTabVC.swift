//
//  TribeTabVC.swift
//  Soul Tribe
//
//  Created by Ashish Soni on 07/06/21.
//

import UIKit

class TribeTabVC: UIViewController,SlideMenuControllerDelegate {

    @IBOutlet weak var createMeetUpView: UIView!
    @IBOutlet weak var exploreMeetUpView: UIView!
    @IBOutlet weak var meetUpAInvitationView: UIView!
    @IBOutlet weak var AccetedMeetUpView: UIView!
    var leftDrawerTransition:DrawerTransition!
    var left = LeftMenuViewController()
    override func viewDidLoad() {
        super.viewDidLoad()

        createMeetUpView.layer.shadowColor = UIColor.lightGray.cgColor
        createMeetUpView.layer.shadowOpacity = 0.3
        createMeetUpView.layer.shadowOffset = .zero
        createMeetUpView.layer.shadowRadius = 5
        createMeetUpView.layer.cornerRadius = 8
        
        exploreMeetUpView.layer.shadowColor = UIColor.lightGray.cgColor
        exploreMeetUpView.layer.shadowOpacity = 0.3
        exploreMeetUpView.layer.shadowOffset = .zero
        exploreMeetUpView.layer.shadowRadius = 5
        exploreMeetUpView.layer.cornerRadius = 8
        
        meetUpAInvitationView.layer.shadowColor = UIColor.lightGray.cgColor
        meetUpAInvitationView.layer.shadowOpacity = 0.3
        meetUpAInvitationView.layer.shadowOffset = .zero
        meetUpAInvitationView.layer.shadowRadius = 5
        meetUpAInvitationView.layer.cornerRadius = 8
        
        AccetedMeetUpView.layer.shadowColor = UIColor.lightGray.cgColor
        AccetedMeetUpView.layer.shadowOpacity = 0.3
        AccetedMeetUpView.layer.shadowOffset = .zero
        AccetedMeetUpView.layer.shadowRadius = 5
        AccetedMeetUpView.layer.cornerRadius = 8
        
        setupLeftDrawer(self)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btncreateMeetUp(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(identifier: "CreateMeetUpVC") as! CreateMeetUpVC
        navigationController?.pushViewController(vc, animated: true)

    }
    @IBAction func btnexploreMeetUp(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(identifier: "ExploreMeetUpVC") as! ExploreMeetUpVC
        navigationController?.pushViewController(vc, animated: true)

    }
    @IBAction func btnmeetUpInvitation(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(identifier: "MeetUpInvitaionVC") as! MeetUpInvitaionVC
        navigationController?.pushViewController(vc, animated: true)

    }
    @IBAction func btnAccetedMeetUp(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(identifier: "AcceptedMeetUpVC") as! AcceptedMeetUpVC
        navigationController?.pushViewController(vc, animated: true)

        
    }
    
    
    
    @IBAction func sideMenuBtnAction(_ sender: Any) {
        self.slideMenuController()?.toggleLeft()

       // setSideMenu()
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
    

}
