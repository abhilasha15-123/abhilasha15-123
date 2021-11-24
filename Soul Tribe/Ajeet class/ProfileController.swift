//
//  ViewController.swift
//  DemoNew
//
//  Created by mac-9 on 01/07/21.
//

import UIKit
import SDWebImage

class interestcollcell: UICollectionViewCell{
    @IBOutlet weak var  cellview: UIView!
    @IBOutlet weak var interestImage: UIImageView!
    @IBOutlet weak var interstedLbl: UILabel!
}
class discriptiontblcell: UITableViewCell{
    @IBOutlet weak var  imguser: UIImageView!
    @IBOutlet weak var  ansLbl: UILabel!
    @IBOutlet weak var  qsnLbl: UILabel!
}
class discriptiontblcell1: UITableViewCell{
    @IBOutlet weak var  ansLbl: UILabel!
    @IBOutlet weak var  qsnLbl: UILabel!
}
class ProfileController: UIViewController {
    
    @IBOutlet weak var vibeStatusSoulLogoWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var vibeStatusTribeLogoWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var vibeStatusDividerWidthConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var vibeStatusTribeWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var vibeStatusSoulWidthConstraint: NSLayoutConstraint!

    @IBOutlet weak var intrestCollectionView: UICollectionView!
    
    @IBOutlet weak var matchView: UIView!
    @IBOutlet weak var matchCornerRadius: UIView!
    
    @IBOutlet weak var blockPopUpView: UIView!
    @IBOutlet weak var blockCornerRadius: UIView!
    @IBOutlet weak var blockBtn_Continue: UIButton!
    
    @IBOutlet weak var asnAnsTable: UITableView!
    @IBOutlet weak var asnAnsTable1: UITableView!
    @IBOutlet weak var asnAnsTable1HeightContraint: NSLayoutConstraint!
    @IBOutlet weak var asnAnsTableHeightContraint: NSLayoutConstraint!
    
    @IBOutlet weak var SoulLoveAsn1: UILabel!
    @IBOutlet weak var SoulLoveAsn2: UILabel!
    @IBOutlet weak var SoulLoveAsn3: UILabel!
    @IBOutlet weak var SoulLoveAsn4: UILabel!
    @IBOutlet weak var TribeAsn1: UILabel!
    @IBOutlet weak var SoulLoveQsnAnsView: UIView!
    @IBOutlet weak var TribeQsnAnsView: UIView!
    @IBOutlet weak var TribeQsnAnsViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var SoulLoveQsnAnsViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var optionMenuView: UIView!
    @IBOutlet weak var vibeStatusTribeLbl: UILabel!
    @IBOutlet weak var vibeStatusSoulLbl: UILabel!
    @IBOutlet weak var firstImpressionLbl: UILabel!
    @IBOutlet weak var distanceLbl: UILabel!
    @IBOutlet weak var userAge: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var viewcorner: UIView!
    @IBOutlet weak var borderview: UIView!
    @IBOutlet weak var imgprofile: UIImageView!
    @IBOutlet weak var btnback: UIButton!
    
    @IBOutlet weak var AKALbl: UILabel!
    @IBOutlet weak var SexualityLbl: UILabel!
    @IBOutlet weak var GenderLbl: UILabel!
    @IBOutlet weak var RelationShipStatusLbl: UILabel!
    @IBOutlet weak var ReligiousViewsLbl: UILabel!
    @IBOutlet weak var CurrentLocationLbl: UILabel!
    @IBOutlet weak var topImage: UIImageView!
    
    var QsnArray = ["What inspires you to wake up every day?","What is your favorite childhood memory that still lights you up when you think about it?","if you can be, do, and have anything in this very moment what would it be?","what led to your spiritual awakening/awareness?"]
    
    var AnsArray = [String]()
    
    var ansTable1Count = Int()
    var tribeContain = Bool()
    var SoulLoveContain = Bool()
    var profileImageString = String()
    var picturesArray = [String]()
    var vibeType = String()
    var hobbiesArray = [String]()
    var AgeInt = Int()
    var profileDict = NSDictionary()
    var swipeUserID = Int()
    var interestImage = ["Aliens","Art","Cooking","Dancing","Fitness","Gaming","Hiking","Law of Attraction","Meditation","Music","Outdoors","Plant Medicine","Quantam Physics","Reading","Shopping","Social Events","Spirituality","Sports","Travel","Yoga"]
    var interestTxt = ["Aliens","Art","Cooking","Dancing","Fitness","Gaming","Hiking","Law of Attraction","Meditation","Music","Outdoors","Plant Medicine","Quantam Physics","Reading","Shopping","Social Events","Spirituality","Sports","Travel","Yoga"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.picturesArray.count == 1 {
            self.asnAnsTableHeightContraint.constant = 0
        }else{
            self.asnAnsTableHeightContraint.constant = 300
        }
        
        if self.vibeType == "Soul Love" {
            self.TribeQsnAnsViewHeightConstraint.constant = 0
        }
        blockBtn_Continue.layer.cornerRadius = 6
        blockCornerRadius.layer.cornerRadius = 6
        matchCornerRadius.layer.cornerRadius = 6
        optionMenuView.layer.cornerRadius = 6
        optionMenuView.layer.borderColor = UIColor.lightGray.cgColor
        optionMenuView.layer.borderWidth = 0.6
        self.optionMenuView.isHidden = true
        viewcorner.layer.cornerRadius = 10
        imgprofile.layer.cornerRadius = self.imgprofile.frame.width/2
        btnback.layer.cornerRadius = 5

        borderview.layer.cornerRadius = 10
        borderview.layer.borderWidth = 2
        borderview.layer.borderColor = #colorLiteral(red: 0.4235294118, green: 0.3882352941, blue: 1, alpha: 1)
        
        getProfiledata()
        self.topImage.sd_setImage(with: URL(string: Config().baseImageUrl + self.picturesArray[0]), completed: nil)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func readMoreAction(_ sender: Any) {
        
    }
    @IBAction func matchPopUpCrossBtnAction(_ sender: Any) {
        self.matchView.removeFromSuperview()
    }
    
    @IBAction func cross_Swipe(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "cross"), object: nil,userInfo: ["data": "reject"])
        self.view.makeToast("Swipe Successfully")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.navigationController?.popViewController(animated: true)
        }
    }
    @IBAction func star_Swipe(_ sender: Any) {
        if self.tribeContain == true {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "swipe"), object: nil,userInfo: ["data": "Tribe"])
            self.view.makeToast("Swipe Successfully")
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.navigationController?.popViewController(animated: true)
            }        }
    }
    @IBAction func love_Swipe(_ sender: Any) {
        if self.SoulLoveContain == true {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "swipe"), object: nil,userInfo: ["data": "Soul Love"])
            self.view.makeToast("Swipe Successfully")
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.navigationController?.popViewController(animated: true)
            }        }
    }

    @IBAction func block_PopUp_Continue(_ sender: Any) {
        self.optionMenuView.isHidden = true
        self.blockPopUpView.removeFromSuperview()
        self.view.endEditing(true)
        let parameterDictionary = NSMutableDictionary()
        let userID = Config().AppUserDefaults.value(forKey:"user_id") as? String ?? ""
       parameterDictionary.setValue("tribe123", forKey: "api_key")
       parameterDictionary.setValue(userID, forKey: "user_id")
        parameterDictionary.setValue(self.vibeType, forKey: "vibe")
        parameterDictionary.setValue(self.swipeUserID, forKey: "block_user_id")
       print(parameterDictionary)
        let methodName = "user_block"

        DataManager.getAPIResponse(parameterDictionary , methodName: methodName, methodType: "POST"){(responseData,error)-> Void in
            let status  = DataManager.getVal(responseData?["status"]) as? String ?? ""
//            let message  = DataManager.getVal(responseData?["message"]) as? String ?? ""

            if status == "1" {
                print("rr")
                self.navigationController?.popViewController(animated: true)
            }
            else {
//                 self.view.makeToast(message)
            }
        }
    }
    @IBAction func block_PopUp_Cancel(_ sender: Any) {
        self.blockPopUpView.removeFromSuperview()
        self.optionMenuView.isHidden = true
    }
    
    @IBAction func Report(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ReportPopUpVC") as! ReportPopUpVC
        vc.GetSwipeUserID = self.swipeUserID
        vc.getUserName = self.userName.text ?? ""
        vc.GetAddress = self.CurrentLocationLbl.text ?? ""
        vc.GetImageStr = self.profileImageString
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func Block(_ sender: Any) {
        self.blockPopUpView.frame = self.view.frame
        self.blockPopUpView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        self.view.addSubview(self.blockPopUpView)
    }
    @IBAction func optionMenuAction(_ sender: Any) {
        self.optionMenuView.isHidden =  !self.optionMenuView.isHidden
    }
    @IBAction func gotomsg(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(identifier: "MessageVC") as! MessageVC
        navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func btnback(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    func getProfiledata(){
        self.view.endEditing(true)
        let parameterDictionary = NSMutableDictionary()
        let userID = Config().AppUserDefaults.value(forKey:"user_id") as? String ?? ""
       parameterDictionary.setValue("tribe123", forKey: "api_key")
       parameterDictionary.setValue(self.swipeUserID, forKey: "user_id")
       parameterDictionary.setValue("Tribe", forKey: "vibe")
        parameterDictionary.setValue(userID, forKey: "login_id")
       print(parameterDictionary)
        let methodName = "get_user_details"

        DataManager.getAPIResponse(parameterDictionary , methodName: methodName, methodType: "POST"){(responseData,error)-> Void in
            let status  = DataManager.getVal(responseData?["status"]) as? String ?? ""
//            let message  = DataManager.getVal(responseData?["message"]) as? String ?? ""

            if status == "1" {
                self.profileDict = DataManager.getVal(responseData?["data"]) as! NSDictionary
                self.CurrentLocationLbl.text = "\(self.profileDict.value(forKey: "city") as! String)" + ", " + "\(self.profileDict.value(forKey: "state") as! String)"
                self.userName.text = self.profileDict.value(forKey: "name") as? String
                self.profileImageString = self.profileDict.value(forKey: "profile_image") as? String ?? ""
                self.imgprofile.sd_setImage(with: URL(string: Config().baseImageUrl + self.profileImageString), completed: nil)
                self.firstImpressionLbl.text = self.profileDict.value(forKey: "first_impression") as? String
                let hobbiesStr = self.profileDict.value(forKey: "hobbies") as? String
//                let result = hobbiesStr!.filter { !$0.isWhitespace }
                self.hobbiesArray = hobbiesStr!.components(separatedBy: ", ")
                
                if self.hobbiesArray.count == 1 {
                    self.hobbiesArray = hobbiesStr!.components(separatedBy: ",")
                }else{
                    self.hobbiesArray = hobbiesStr!.components(separatedBy: ", ")
                }
                let vibes = self.profileDict.value(forKey: "vibe") as? String ?? ""
                let vibesArr = vibes.components(separatedBy: ", ")
                print(vibesArr)
                let searchToSearch = "Soul Love"
                let worlds = vibesArr.flatMap { $0.components(separatedBy: ",")}
                self.SoulLoveContain = worlds.filter { searchToSearch.range(of:$0) != nil }.count != 0
                if self.SoulLoveContain == true {
                    self.vibeStatusSoulLbl.text = "Soul Love"
                }else{
                    self.vibeStatusSoulLbl.text = ""
                }
                let searchToSearch1 = "Tribe"
                let worlds1 = vibesArr.flatMap { $0.components(separatedBy: ",")}
                self.tribeContain = worlds1.filter { searchToSearch1.range(of:$0) != nil }.count != 0
                print(self.tribeContain)
                if self.tribeContain == true {
                    self.vibeStatusTribeLbl.text = "Tribe"
                }else{
                    self.vibeStatusTribeLbl.text = ""
                }
                if self.SoulLoveContain == true && self.tribeContain == true {
                    self.matchView.frame = self.view.frame
                    self.matchView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
                    self.view.addSubview(self.matchView)
                    
                }else{
                }
                
                self.SoulLoveAsn1.text = self.profileDict.value(forKey: "relationship_looking_for_soul_love") as? String
                self.SoulLoveAsn2.text = self.profileDict.value(forKey: "soul_love_my_sexuality") as? String
                self.SoulLoveAsn3.text = self.profileDict.value(forKey: "soul_love_my_relationship_status") as? String
                self.SoulLoveAsn4.text = self.profileDict.value(forKey: "soul_love_QA") as? String
                self.TribeAsn1.text = self.profileDict.value(forKey: "tribe_QA") as? String
                self.AKALbl.text = self.profileDict.value(forKey: "nick_name") as? String
                self.SexualityLbl.text = self.profileDict.value(forKey: "soul_love_my_sexuality") as? String
                self.GenderLbl.text = self.profileDict.value(forKey: "gender") as? String
                let distance = self.profileDict.value(forKey: "search_distance") as? String
                let distanceType = self.profileDict.value(forKey: "distance_type") as? String ?? ""
                self.distanceLbl.text = "\(distance!)" + " " + "\(distanceType)"
                self.RelationShipStatusLbl.text = self.profileDict.value(forKey: "soul_love_my_relationship_status") as? String
                self.ReligiousViewsLbl.text = self.profileDict.value(forKey: "religious") as? String
                self.AgeInt = self.profileDict.value(forKey: "age") as! Int
                self.userAge.text = String(self.AgeInt)
                self.intrestCollectionView.reloadData()
                
                let qsn1 = self.profileDict.value(forKey: "QA_1") as? String
                let qsn2 = self.profileDict.value(forKey: "QA_2") as? String
                let qsn3 = self.profileDict.value(forKey: "QA_3") as? String
                let qsn4 = self.profileDict.value(forKey: "QA_4") as? String
                
                if qsn1?.count != nil {
                    self.ansTable1Count = 1
                    self.AnsArray.append(qsn1!)
                }
                if qsn2?.count != nil {
                    self.ansTable1Count = 2
                    self.AnsArray.append(qsn2!)
                }
                if qsn3?.count != nil {
                    self.ansTable1Count = 3
                    self.AnsArray.append(qsn3!)
                }
                if qsn4?.count != nil{
                    self.ansTable1Count = 4
                    self.AnsArray.append(qsn4!)
                }
                
                print(self.AnsArray.count)
                
                self.asnAnsTable1HeightContraint.constant = CGFloat(20 + (self.AnsArray.count * 50))
                
                self.asnAnsTable.reloadData()
                self.asnAnsTable1.reloadData()
            }
            else {
//                 self.view.makeToast(message)
            }
        }
    }
}

extension ProfileController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITableViewDelegate,UITableViewDataSource{
   
    //MARK: COLLECTION VIEW METHOD
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.hobbiesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "interestcollcell", for: indexPath) as! interestcollcell
        cell.cellview.layer.cornerRadius = 5
        cell.cellview.layer.borderWidth = 1
        cell.cellview.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        cell.interestImage.image = UIImage(named: self.hobbiesArray[indexPath.row])
        cell.interstedLbl.text = self.hobbiesArray[indexPath.row]
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 6
        
    }
    //UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width/4, height: collectionView.frame.height/2.2);

       }
    
    //MARK: TABLE VIEW METHOD
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == asnAnsTable {
            return self.picturesArray.count - 1
        }else{
            return self.ansTable1Count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == asnAnsTable {
            let cell = tableView.dequeueReusableCell(withIdentifier: "discriptiontblcell", for: indexPath) as! discriptiontblcell
            cell.imguser.layer.cornerRadius = 10
            cell.imguser.sd_setImage(with: URL(string: Config().baseImageUrl + self.picturesArray[indexPath.row + 1]), completed: nil)
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "discriptiontblcell1", for: indexPath) as! discriptiontblcell1
            cell.qsnLbl.text = self.QsnArray[indexPath.row]
            cell.ansLbl.text = self.AnsArray[indexPath.row]
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == asnAnsTable {
            return 300
        }else{
            return 50
        }
            
    }
}
