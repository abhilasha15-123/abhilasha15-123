//
//  HomeTabVC.swift
//  Soul Tribe
//
//  Created by Ashish Soni on 07/06/21.
//

import UIKit
import Koloda

class HomeTabVC: UIViewController, SlideMenuControllerDelegate{
@IBOutlet weak var btnnext: UIButton!
@IBOutlet weak var fitnessview: UIView!
@IBOutlet weak var artsview: UIView!
@IBOutlet weak var musicsview: UIView!
@IBOutlet weak var shopingsview: UIView!
@IBOutlet weak var alienview: UIView!
@IBOutlet weak var sportsview: UIView!
@IBOutlet weak var mainview: UIView!
@IBOutlet weak var popupview: UIView!
@IBOutlet weak var innerpopupvc: UIView!
@IBOutlet weak var btnsoullove: UIButton!
@IBOutlet weak var btntribe: UIButton!
@IBOutlet weak var cardView: CustomKolodaView!
@IBOutlet weak var topView: UIView!
    
    var profileDict = [NSDictionary]()
    var hobbiesArray = [String:Any]()
    var leftDrawerTransition:DrawerTransition!
    var left = LeftMenuViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        cardView.countOfVisibleCards = 1
        cardView.delegate = self
        cardView.dataSource = self
        self.navigationController?.isNavigationBarHidden = true
        popupview.isHidden = false
        innerpopupvc.isHidden = false
        innerpopupvc.layer.cornerRadius = 8
        btnsoullove.layer.cornerRadius = 8
        btntribe.layer.cornerRadius = 8
        //innerpopupvc.frame = CGRect(x: 0, y: 0, width: view.frame.width * 1.2, height: view.frame.height * 1.2)
        getData()
    }
    
    @IBAction func btnnotification(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(identifier: "NotificationsVC") as! NotificationsVC
        navigationController?.pushViewController(vc, animated: true)
       // NotificationsVC
    }
    
    @IBAction func btnexploreuser(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(identifier: "ReportPopUpVC") as! ReportPopUpVC
        navigationController?.pushViewController(vc, animated: true)
      
    }
    
    @IBAction func sideMenuBtnAction(_ sender: Any) {
        self.slideMenuController()?.toggleLeft()
    }
    
    @IBAction func btnsoullove(_ sender: Any) {
        popupview.isHidden = true
        innerpopupvc.isHidden = true

    }
    
    @IBAction func btntribe(_ sender: Any) {
        popupview.isHidden = true
        innerpopupvc.isHidden = true

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
    
    @IBAction func btngotonxt(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(identifier: "ProfileController") as! ProfileController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func getData(){
         self.view.endEditing(true)

         let parameterDictionary = NSMutableDictionary()
      
        parameterDictionary.setValue("tribe123", forKey: "api_key")
        parameterDictionary.setValue("14", forKey: "user_id")
        parameterDictionary.setValue("Tribe", forKey: "vibe")
        parameterDictionary.setValue("", forKey: "latitude")
        parameterDictionary.setValue("", forKey: "longitude")
        print(parameterDictionary)
         let methodName = "get_users_list"

         DataManager.getAPIResponse(parameterDictionary , methodName: methodName, methodType: "POST"){(responseData,error)-> Void in
             let status  = DataManager.getVal(responseData?["status"]) as? String ?? ""
             let message  = DataManager.getVal(responseData?["message"]) as? String ?? ""

             if status == "1" {
                 self.profileDict = DataManager.getVal(responseData?["data"]) as! [NSDictionary]
                 print(self.profileDict.count)
                 self.cardView.reloadData()
             }
             else {
//                 self.view.makeToast(message)
             }
         }
     }
}
@available(iOS 13.0, *)
extension HomeTabVC: KolodaViewDataSource {
    
    func kolodaSpeedThatCardShouldDrag(_ koloda: KolodaView) -> DragSpeed {
        return .fast
    }
    func kolodaNumberOfCards(_ koloda: KolodaView) -> Int {
        return self.profileDict.count
    }
    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        
        let tempVw = KolView()
//        tempVw.dropShadow()
//        self.cardView.dropShadow()
        tempVw.layer.cornerRadius = 20
        self.cardView.layer.cornerRadius = 20
        koloda.layer.cornerRadius = 20
        self.topView.layer.cornerRadius = 20
//        tempVw.contentView.layer.cornerRadius = 20
//        tempVw.mainView.layer.cornerRadius = 20
//        tempVw.scrollView.layer.cornerRadius = 20
//        tempVw.ageLbl.layer.cornerRadius = 10
//        tempVw.matchLbl.layer.cornerRadius = 10
//        tempVw.superLikeBtnTop.isHidden = true
       
        
//        if profileDataArray.count == 1 {
//            if index == 1 {
//                cardView.countOfVisibleCards = 0
//            }else{
//                cardView.countOfVisibleCards = 1
//            }
//        }else{
//            if index ==  addcount-1 {
//                cardView.countOfVisibleCards = 0
//                ind = index+1
//            }else{
//                cardView.countOfVisibleCards = 1
//            }
//        }

//        if ind == profileDataArray.count {
//            cardView.isHidden = true
////                self.SwipeView.isHidden = true
//            self.NoDataLbl.isHidden = false
//            self.NoDataImage.isHidden = false
//        }else{
//            cardView.isHidden = false
////                self.SwipeView.isHidden = true
//            self.NoDataLbl.isHidden = true
//            self.NoDataImage.isHidden = true
//        }
        
        let dict = self.profileDict[index]
        print(dict)
        let address = dict.value(forKey: "address") as? String
        let name = dict.value(forKey: "name") as? String
        let profileImg = dict.value(forKey: "profile_image") as? String
        let firstImpresssion = dict.value(forKey: "profile_image") as? String
        
        
//        self.hobbiesArray = [
//            ["": ,"": ""],
//            ["key": orientationStr,"image": "orientation"],
////            ["key": DataManager.getVal(dict["city"]) as? String ?? "","image": "location"],
//
//                        ["key": ethnicity,"image": "ethnicity"],
//            ]
        
        
        return tempVw
    }
    
    func koloda(_ koloda: KolodaView, viewForCardOverlayAt index: Int) -> OverlayView? {
        return Bundle.main.loadNibNamed("CustomOverlayView", owner: self, options: nil)?[0] as? OverlayView
    }
}

@available(iOS 13.0, *)
extension HomeTabVC: KolodaViewDelegate {
    
    func kolodaDidRunOutOfCards(_ koloda: KolodaView) {
//        cardView.resetCurrentCardIndex()
    }
    
    func koloda(_ koloda: KolodaView, didSelectCardAt index: Int) {
//        UIApplication.shared.openURL(URL(string: "https://yalantis.com/")!)
    }
    
    func kolodaShouldApplyAppearAnimation(_ koloda: KolodaView) -> Bool {
        return true
    }
    
    func kolodaShouldMoveBackgroundCard(_ koloda: KolodaView) -> Bool {
        return false
    }
    
    func kolodaShouldTransparentizeNextCard(_ koloda: KolodaView) -> Bool {
        return true
    }
    
//    func koloda(kolodaBackgroundCardAnimation koloda: KolodaView) -> POPPropertyAnimation? {
//        let animation = POPSpringAnimation(propertyNamed: kPOPViewFrame)
//        animation?.springBounciness = frameAnimationSpringBounciness
//        animation?.springSpeed = frameAnimationSpringSpeed
//        return animation
//    }
    func koloda(_ koloda: KolodaView, allowedDirectionsForIndex index: Int) -> [SwipeResultDirection]{
        return [.left,.topLeft,.bottomLeft,.right,.topRight,.bottomRight,.up]
    }
    func koloda(_ koloda: KolodaView, shouldSwipeCardAt index: Int, in direction: SwipeResultDirection) -> Bool{
        if direction == .left || direction == .topLeft || direction == .bottomLeft{
            return true
        }else if direction == .up {
            return true
        }
        else{
            return true
        }
    }
    func koloda(_ koloda: KolodaView, didSwipeCardAt index: Int, in direction: SwipeResultDirection){

        if direction == .left || direction == .topLeft || direction == .bottomLeft{
//            self.recieverId = DataManager.getVal(self.swipeUserId[0]) as? String ?? ""
//            self.recieverName = DataManager.getVal(self.swipeUserName[0]) as? String ?? ""
//            self.recieverImage = DataManager.getVal(self.swipeUserImage[0]) as? String ?? ""
//            print(recieverId)
//            print(recieverName)
//
//            self.swipeUserId.remove(at: 0)
//            self.swipeUserName.remove(at: 0)
//            self.swipeUserImage.remove(at: 0)
//            print(self.swipeUserId)
//            print(self.swipeUserName)
//            print(self.swipeUserImage)
//            self.swipeCountAPI(recieverId: self.user_id, type: "", isLike: false)
        }else if direction == .right || direction == .topRight || direction == .bottomRight{
            
//            self.recieverId = DataManager.getVal(self.swipeUserId[0]) as? String ?? ""
//            self.recieverName = DataManager.getVal(self.swipeUserName[0]) as? String ?? ""
//            print(self.swipeUserName)
//            print(self.swipeUserId)
//            print(recieverId)
//            print(recieverName)
//            self.recieverImage = DataManager.getVal(self.swipeUserImage[0]) as? String ?? ""
//            self.swipeUserId.remove(at: 0)
//            self.swipeUserName.remove(at: 0)
//            self.swipeUserImage.remove(at: 0)
//            print(self.swipeUserId)
//            print(self.swipeUserName)
//            print(self.swipeUserImage)
//            print(self.recieverId)
//            print(self.user_id)
//            let Rid = Int(self.recieverId) ?? 0
//            let Uid = Int(self.user_id) ?? 0
//            if Rid < Uid {
//                self.room_id = recieverId + "-" + user_id
//                print(self.room_id)
//            }else{
//                self.room_id = user_id + "-" + recieverId
//                print(self.room_id)
//            }
//            self.swipeCountAPI(recieverId: self.user_id, type: self.Liketype, isLike: true)
//            SocketIoManagerNotification.sharedInstance.sendLikeNoti(Sender_Id: self.user_id, Sender_Name: self.user_name, Sender_Image: self.user_image, Reciever_Id: self.recieverId, Reciver_Name: self.recieverName, Reciver_Image: self.recieverImage, Type: self.Liketype, Room_id: room_id)
        }else if direction == .up {
//            self.recieverId = DataManager.getVal(self.swipeUserId[0]) as? String ?? ""
//            self.recieverName = DataManager.getVal(self.swipeUserName[0]) as? String ?? ""
//            print(self.swipeUserName)
//            print(self.swipeUserId)
//            print(recieverId)
//            print(recieverName)
//            self.recieverImage = DataManager.getVal(self.swipeUserImage[0]) as? String ?? ""
//            self.swipeUserId.remove(at: 0)
//            self.swipeUserName.remove(at: 0)
//            self.swipeUserImage.remove(at: 0)
//            print(self.swipeUserId)
//            print(self.swipeUserName)
//            print(self.swipeUserImage)
//            print(self.recieverId)
//            print(self.user_id)
//            let Rid = Int(self.recieverId) ?? 0
//            let Uid = Int(self.user_id) ?? 0
//            if Rid < Uid {
//                self.room_id = recieverId + "-" + user_id
//                print(self.room_id)
//            }else{
//                self.room_id = user_id + "-" + recieverId
//                print(self.room_id)
//            }
//            self.swipeCountAPI(recieverId: self.recieverId, type: self.Liketype, isLike: true)
//            SocketIoManagerNotification.sharedInstance.sendLikeNoti(Sender_Id: self.user_id, Sender_Name: self.user_name, Sender_Image: self.user_image, Reciever_Id: self.recieverId, Reciver_Name: self.recieverName, Reciver_Image: self.recieverImage, Type: self.Liketype, Room_id: room_id)
        }
        else{
            print("No action perform")
        }
    }
}

