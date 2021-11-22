//
//  HomeTabVC.swift
//  Soul Tribe
//
//  Created by Ashish Soni on 07/06/21.
//

import UIKit
import Koloda
import SDWebImage

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
  @IBOutlet weak var topOptionMenuView: UIView!
  @IBOutlet weak var HomeVibeBtn: UIButton!
  @IBOutlet weak var confirmBlockView: UIView!
  
    var hobbiesArray = [String]()
    var getproductImages = [NSDictionary]()
  var picturesArray = [String]()
  var receiverName = String()
  var receiverAddress = String()
  var ageInt = Int()
  var CategorySelect = String()
  var profileDict = [NSDictionary]()
  var leftDrawerTransition:DrawerTransition!
  var left = LeftMenuViewController()
  var swipeUserID = Int()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.navigationController?.navigationBar.isHidden = true
        topOptionMenuView.isHidden = true
        topOptionMenuView.layer.cornerRadius = 8
        cardView.countOfVisibleCards = 1
        cardView.delegate = self
        cardView.dataSource = self
        self.navigationController?.isNavigationBarHidden = true
        popupview.isHidden = false
        innerpopupvc.isHidden = false
        innerpopupvc.layer.cornerRadius = 8
        confirmBlockView.layer.cornerRadius = 8
        btnsoullove.layer.cornerRadius = 8
        btntribe.layer.cornerRadius = 8
        self.confirmBlockView.isHidden = true
        //innerpopupvc.frame = CGRect(x: 0, y: 0, width: view.frame.width * 1.2, height: view.frame.height * 1.2
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cardView.reloadData()
    }
    @IBAction func HometopMenuAction(_ sender: Any) {
        self.topOptionMenuView.isHidden = !self.topOptionMenuView.isHidden
    }
    @IBAction func HometopMenuSoulTribeAction(_ sender: Any) {
        self.topOptionMenuView.isHidden = true
        popupview.isHidden = true
        self.CategorySelect = "Soul Love"
        self.HomeVibeBtn.setTitle("Soul Love", for: .normal)
        self.getData(vibeType: self.CategorySelect)
    }
    @IBAction func HometopMenuTribeAction(_ sender: Any) {
        self.topOptionMenuView.isHidden = true
        popupview.isHidden = true
        innerpopupvc.isHidden = true
        self.CategorySelect = "Tribe"
        self.HomeVibeBtn.setTitle("Tribe", for: .normal)
        self.getData(vibeType: self.CategorySelect)
    }
    @IBAction func btnnotification(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(identifier: "NotificationsVC") as! NotificationsVC
        navigationController?.pushViewController(vc, animated: true)
       // NotificationsVC
    }
    @IBAction func ConfirmBlock_Cancel(_ sender: Any) {
        self.confirmBlockView.isHidden = true
    }
    @IBAction func ConfirmBlock_Accept(_ sender: Any) {
        self.confirmBlockView.isHidden = true
        let tempVw = KolView()
        tempVw.menuoptionView.isHidden = true
        self.view.endEditing(true)
        let parameterDictionary = NSMutableDictionary()
     
       parameterDictionary.setValue("tribe123", forKey: "api_key")
       parameterDictionary.setValue("14", forKey: "user_id")
       parameterDictionary.setValue("Tribe", forKey: "vibe")
        parameterDictionary.setValue(self.swipeUserID, forKey: "block_user_id")
       print(parameterDictionary)
        let methodName = "user_block"

        DataManager.getAPIResponse(parameterDictionary , methodName: methodName, methodType: "POST"){(responseData,error)-> Void in
            let status  = DataManager.getVal(responseData?["status"]) as? String ?? ""
            let message  = DataManager.getVal(responseData?["message"]) as? String ?? ""

            if status == "1" {
                self.cardView.reloadData()
                self.getData(vibeType: self.CategorySelect)
                print("rr")
            }
            else {
//                 self.view.makeToast(message)
            }
        }
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
        self.CategorySelect = "Soul Love"
        self.HomeVibeBtn.setTitle("Soul Love", for: .normal)
        self.getData(vibeType: self.CategorySelect)
//        self.slideMenuController()?.toggleLeft()
    }
    
    @IBAction func btntribe(_ sender: Any) {
        popupview.isHidden = true
        innerpopupvc.isHidden = true
        self.CategorySelect = "Tribe"
        self.HomeVibeBtn.setTitle("Tribe", for: .normal)
        self.getData(vibeType: self.CategorySelect)
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
    
    func getData(vibeType: String){
         self.view.endEditing(true)

         let parameterDictionary = NSMutableDictionary()
      
        parameterDictionary.setValue("tribe123", forKey: "api_key")
        parameterDictionary.setValue("14", forKey: "user_id")
        parameterDictionary.setValue(vibeType, forKey: "vibe")
        parameterDictionary.setValue("", forKey: "latitude")
        parameterDictionary.setValue("", forKey: "longitude")
        print(parameterDictionary)
         let methodName = "get_users_list"

         DataManager.getAPIResponse(parameterDictionary , methodName: methodName, methodType: "POST"){(responseData,error)-> Void in
             let status  = DataManager.getVal(responseData?["status"]) as? String ?? ""
             let message  = DataManager.getVal(responseData?["message"]) as? String ?? ""

             if status == "1" {
                 self.cardView.reloadData()
                 self.profileDict = DataManager.getVal(responseData?["data"]) as! [NSDictionary]
                 print(self.profileDict.count)
                 self.cardView.reloadData()
             }
             else {
//                 self.view.makeToast(message)
             }
         }
     }
    func RightSwipeAPI(SwipeUserId: Int, type: String){
         self.view.endEditing(true)

         let parameterDictionary = NSMutableDictionary()
      
        parameterDictionary.setValue("tribe123", forKey: "api_key")
        parameterDictionary.setValue("14", forKey: "user_id")
        parameterDictionary.setValue("Tribe", forKey: "vibe")
        parameterDictionary.setValue(SwipeUserId, forKey: "swipe_user_id")
        parameterDictionary.setValue(type, forKey: "type")
        print(parameterDictionary)
         let methodName = "user_swipe"

         DataManager.getAPIResponse(parameterDictionary , methodName: methodName, methodType: "POST"){(responseData,error)-> Void in
             let status  = DataManager.getVal(responseData?["status"]) as? String ?? ""
             let message  = DataManager.getVal(responseData?["message"]) as? String ?? ""

             if status == "1" {
                 self.cardView.reloadData()
                 print("rr")
             }
             else {
//                 self.view.makeToast(message)
             }
         }
     }
    @objc func ShowMenuOptionView(){
        let tempVw = KolView()
        if tempVw.menuoptionView.isHidden {
            tempVw.menuoptionView.isHidden = false
        }else{
            tempVw.menuoptionView.isHidden = true
        }
        
    }
    @objc func menuOptionReportBtnAction(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ReportPopUpVC") as! ReportPopUpVC
        vc.GetSwipeUserID = self.swipeUserID
        vc.getUserName = self.receiverName
        vc.GetAddress = self.receiverAddress
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc func menuOptionBlockUserBtnAction(){
        self.confirmBlockView.isHidden = false
    }
    @objc func menuOptionViewProfileBtnAction(){
        let tempVw = KolView()
        tempVw.menuoptionView.isHidden = true
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProfileController") as! ProfileController
        vc.swipeUserID = self.swipeUserID
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc func BtnLeftSwipeAction(){
        self.cardView.swipe(.left)
        self.RightSwipeAPI(SwipeUserId: self.swipeUserID, type: "reject")
    }
    @objc func BtnRightSwipeAction(){
        self.cardView.swipe(.right)
        self.RightSwipeAPI(SwipeUserId: self.swipeUserID, type: "like")
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
        
        self.picturesArray.removeAll()
        self.hobbiesArray.removeAll()
        let tempVw = KolView()
        tempVw.picturesArray.removeAll()
        tempVw.hobbiesArray.removeAll()
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
        self.receiverAddress = dict.value(forKey: "address") as! String
        self.receiverName = dict.value(forKey: "name") as! String
        let profileImg = dict.value(forKey: "profile_image") as? String
        let firstImpresssion = dict.value(forKey: "first_impression") as? String
        let hobbiesStr = dict.value(forKey: "hobbies") as? String
//        let result = hobbiesStr!.filter { !$0.isWhitespace }
        self.hobbiesArray = hobbiesStr!.components(separatedBy: ", ")
        
        if self.hobbiesArray.count == 1 {
            self.hobbiesArray = hobbiesStr!.components(separatedBy: ",")
        }else{
            self.hobbiesArray = hobbiesStr!.components(separatedBy: ", ")
        }
        
        tempVw.userImg.sd_setImage(with: URL(string: Config().baseImageUrl + profileImg!), completed: nil)
        self.ageInt = dict.value(forKey: "age") as! Int
        tempVw.ageLbl.text = String(self.ageInt)
        tempVw.userName.text = self.receiverName
        tempVw.cityBtn.setTitle(" \(self.receiverAddress)", for: .normal)
        tempVw.firstImpressionLbl.text = firstImpresssion
        self.getproductImages = dict.value(forKey: "getProductImages") as! [NSDictionary]
        print(self.getproductImages)
        for i in 0..<self.getproductImages.count{
            let dict1 = getproductImages[i]
            let images = dict1.value(forKey: "images") as? String
            self.picturesArray.append(images!)
        }
        print(self.picturesArray)
        tempVw.picturesArray = self.picturesArray
        tempVw.hobbiesArray = self.hobbiesArray
     //   ["Fitness","Music","Shopping","Aliens","Art","Sport","Fitness","Music","Shopping","Aliens"]
        
        tempVw.menuOptionReportBtn.addTarget(self, action: #selector(menuOptionReportBtnAction), for: .touchUpInside)
        tempVw.menuOptionBlockUserBtn.addTarget(self, action: #selector(menuOptionBlockUserBtnAction), for: .touchUpInside)
        tempVw.menuOptionViewProfileBtn.addTarget(self, action: #selector(menuOptionViewProfileBtnAction), for: .touchUpInside)
//        tempVw.ClickonOptionViewBtn.addTarget(self, action: #selector(ShowMenuOptionView), for: .touchUpInside)
        tempVw.bottomViewProfileBtn.addTarget(self, action: #selector(menuOptionViewProfileBtnAction), for: .touchUpInside)
        tempVw.BtnLeftSwipe.addTarget(self, action: #selector(BtnLeftSwipeAction), for: .touchUpInside)
        tempVw.BtnRightSwipe.addTarget(self, action: #selector(BtnRightSwipeAction), for: .touchUpInside)
        
        tempVw.imageCollectionView.reloadData()
        tempVw.hobbiesCollectionView.reloadData()
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
        }else if direction == .right || direction == .topRight || direction == .bottomRight {
            return true
        }
        else{
            return false
        }
    }
    func koloda(_ koloda: KolodaView, didSwipeCardAt index: Int, in direction: SwipeResultDirection){

        if direction == .left || direction == .topLeft || direction == .bottomLeft{
            
            let dict = self.profileDict[index]
            self.swipeUserID = dict.value(forKey: "id") as! Int
            self.RightSwipeAPI(SwipeUserId: self.swipeUserID, type: "reject")
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
            
            let dict = self.profileDict[index]
            self.swipeUserID = dict.value(forKey: "id") as! Int
            self.RightSwipeAPI(SwipeUserId: self.swipeUserID, type: "like")
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


