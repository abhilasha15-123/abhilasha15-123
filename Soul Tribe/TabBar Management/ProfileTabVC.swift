//
//  ProfileTabVC.swift
//  Soul Tribe
//
//  Created by Ashish Soni on 07/06/21.
//

import UIKit

class ProfileTabVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,SlideMenuControllerDelegate{
    

    @IBOutlet weak var galleryCollectionVIew: UICollectionView!
    @IBOutlet weak var interestCollectionView: UICollectionView!
    @IBOutlet weak var imgprofile: UIImageView!
     @IBOutlet weak var Name_Age: UILabel!
    @IBOutlet weak var first_impression: UILabel!
    @IBOutlet weak var nick_name: UILabel!
    @IBOutlet weak var gender: UILabel!
    @IBOutlet weak var vibe: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var religious: UILabel!
    @IBOutlet weak var sexuality: UILabel!
    
    var interestImage = ["Fitness","Music","Shopping","Aliens","Art","Sport"]
    var interestTxt = ["Fitness","Music","Shopping","Aliens","Art","Sport"]
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    var leftDrawerTransition:DrawerTransition!
    var left = LeftMenuViewController()
    var imgBase_url = ""
    var nameAge = ""
    var hobbiesStr = ""
    var hobbiesArray = [String]()
    var product_imagesArray = [[String:Any]]()
//    var gallery_image_url = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        imgprofile.layer.shadowColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//        imgprofile.layer.shadowOpacity = 0.8
//        imgprofile.layer.shadowOffset = .zero
//        imgprofile.layer.shadowRadius = 8
//        imgprofile.layer.cornerRadius = 65
//        imgprofile.layer.borderWidth = 2.5
//        imgprofile.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)

//        imgprofile.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//        imgprofile.layer.borderWidth = 2.5
//        imgprofile.layer.shadowRadius = 0.6
//
        
        let LiberaryLayOut = UICollectionViewFlowLayout()
        LiberaryLayOut.itemSize = CGSize(width: screenWidth/2.8, height: 30)
        LiberaryLayOut.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        LiberaryLayOut.minimumInteritemSpacing = 0
        LiberaryLayOut.minimumLineSpacing = 10
        LiberaryLayOut.scrollDirection = .vertical
        interestCollectionView.collectionViewLayout = LiberaryLayOut
        
        
//        let LiberaryLayOut1 = UICollectionViewFlowLayout()
//        LiberaryLayOut1.itemSize = CGSize(width: screenWidth, height: 120)
//        LiberaryLayOut1.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
////        LiberaryLayOut1.minimumInteritemSpacing = 0
//        LiberaryLayOut1.minimumLineSpacing = 0
//        LiberaryLayOut1.scrollDirection = .vertical
//        galleryCollectionVIew.collectionViewLayout = LiberaryLayOut1

        setupLeftDrawer(self)
//        get_profileAPI()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        get_profileAPI()
    }
    
    
    func get_profileAPI()  {
        
        let parameterDictionary = NSMutableDictionary()
     
       parameterDictionary.setValue("tribe123", forKey: "api_key")
       parameterDictionary.setValue("14", forKey: "user_id")
      
       print(parameterDictionary)
        let methodName = "get_profile"
        

        DataManager.getAPIResponse(parameterDictionary , methodName: methodName, methodType: "POST"){ [self](responseData,error)-> Void in
            let status  = DataManager.getVal(responseData?["status"]) as? String ?? ""
            let message  = DataManager.getVal(responseData?["message"]) as? String ?? ""
            let data = DataManager.getVal(responseData?["data"]) as? NSDictionary
            
            let profile_image  = DataManager.getVal(data?["profile_image"]) as? String ?? ""
            self.imgBase_url = Config().baseImageUrl + profile_image
             
            let name = DataManager.getVal(data?["name"]) as? String ?? ""
            let age = DataManager.getVal(data?["age"]) as? String ?? ""
            
            self.nameAge = name + " | " + age
            
            if status == "1" {

                self.imgprofile.sd_setImage(with: URL(string: self.imgBase_url), placeholderImage: #imageLiteral(resourceName: "Group 26614"), options: .refreshCached) { (image, error, cachesType, url) in
                        }
                self.vibe.text = DataManager.getVal(data?["vibe"]) as? String ?? ""
                self.first_impression.text = DataManager.getVal(data?["first_impression"]) as? String ?? ""
                
                self.Name_Age.text = self.nameAge
                self.nick_name.text = DataManager.getVal(data?["nick_name"]) as? String ?? ""
                self.gender.text = DataManager.getVal(data?["gender"]) as? String ?? ""
                self.address.text = DataManager.getVal(data?["address"]) as? String ?? ""
                self.religious.text = DataManager.getVal(data?["religious"]) as? String ?? ""
                self.sexuality.text = DataManager.getVal(data?["soul_love_my_sexuality"]) as? String ?? ""
                
                self.hobbiesStr = DataManager.getVal(data?["hobbies"]) as? String ?? ""
                self.hobbiesArray = self.hobbiesStr.components(separatedBy: ", ")
    
                let product_images = DataManager.getVal(data?["get_product_images"]) as? NSArray ?? []

                self.product_imagesArray = product_images as! [[String : Any]]
//                let gallery_image  = DataManager.getVal(product_images?["images"]) as? String ?? ""
                
                self.galleryCollectionVIew.reloadData()
                self.interestCollectionView.reloadData()
                
            } else {
//                 self.view.makeToast(message)
            }
        }
    }
    
    
    
    @IBAction func btngotonext(_ sender: Any) {
//        let vc = self.storyboard?.instantiateViewController(identifier: "IntentionListVC") as! IntentionListVC
//        navigationController?.pushViewController(vc, animated: true)

    }
    @IBAction func btnsidemenu(_ sender: Any) {
        self.slideMenuController()?.toggleLeft()


    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == interestCollectionView {
            return hobbiesArray.count
        }else{
            return product_imagesArray.count
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == interestCollectionView{
            
            return CGSize(width: collectionView.frame.width/3.4, height: collectionView.frame.height/2.6);

       }
        else
        {
            return CGSize(width: collectionView.frame.width/1.6, height: collectionView.frame.height/2.1);
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == interestCollectionView {
            return 10
        }
        else{
            return 10
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == interestCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! InterestCell
            cell.interestViee.layer.cornerRadius = 5
            cell.interestViee.layer.borderWidth = 0.5
            cell.interestViee.layer.borderColor = UIColor.lightGray.cgColor
            cell.interestImage.image = UIImage(named: hobbiesArray[indexPath.item])
            cell.interstedLbl.text = hobbiesArray[indexPath.item]
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! GalleryCell
            
            let dict = self.product_imagesArray[indexPath.row] as? [String:Any] ?? [:]
            
            let profile_image  = DataManager.getVal(dict["images"]) as? String ?? ""
            self.imgBase_url = Config().baseImageUrl + profile_image
            
            
            cell.img.sd_setImage(with: URL(string: self.imgBase_url), placeholderImage: #imageLiteral(resourceName: "Group 26614"), options: .refreshCached) { (image, error, cachesType, url) in
            }
            
            print(DataManager.getVal(dict["images"]) as? String ?? "")
           
            return cell
        }
    }
    
    
    
    @IBAction func sidemenuBtnAction(_ sender: Any) {
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
