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

    var interestImage = ["Fitness","Music","Shopping","Aliens","Art","Sport"]
    var interestTxt = ["Fitness","Music","Shopping","Aliens","Art","Sport"]
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    var leftDrawerTransition:DrawerTransition!
    var left = LeftMenuViewController()
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
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btngotonext(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(identifier: "IntentionListVC") as! IntentionListVC
        navigationController?.pushViewController(vc, animated: true)

    }
    @IBAction func btnsidemenu(_ sender: Any) {
        self.slideMenuController()?.toggleLeft()


    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == interestCollectionView {
            return interestTxt.count
        }else{
            return 4
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
            cell.interestImage.image = UIImage(named: interestImage[indexPath.item])
            cell.interstedLbl.text = interestTxt[indexPath.item]
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! GalleryCell
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
