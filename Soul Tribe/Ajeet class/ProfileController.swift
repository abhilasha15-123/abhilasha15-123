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
    
    var picturesArray = [String]()
    var hobbiesArray = [String]()
    var AgeInt = Int()
    var profileDict = NSDictionary()
    var swipeUserID = Int()
    var interestImage = ["Aliens","Art","Cooking","Dancing","Fitness","Gaming","Hiking","Law of Attraction","Meditation","Music","Outdoors","Plant Medicine","Quantam Physics","Reading","Shopping","Social Events","Spirituality","Sports","Travel","Yoga"]
    var interestTxt = ["Aliens","Art","Cooking","Dancing","Fitness","Gaming","Hiking","Law of Attraction","Meditation","Music","Outdoors","Plant Medicine","Quantam Physics","Reading","Shopping","Social Events","Spirituality","Sports","Travel","Yoga"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    @IBAction func Report(_ sender: Any) {
        self.optionMenuView.isHidden = true
        self.view.endEditing(true)
        let parameterDictionary = NSMutableDictionary()
        let userID = Config().AppUserDefaults.value(forKey:"user_id") as? String ?? ""
       parameterDictionary.setValue("tribe123", forKey: "api_key")
       parameterDictionary.setValue(userID, forKey: "user_id")
       parameterDictionary.setValue("Tribe", forKey: "vibe")
       parameterDictionary.setValue(self.swipeUserID, forKey: "report_reason_id")
       parameterDictionary.setValue("", forKey: "comment")
       print(parameterDictionary)
        let methodName = "get_report_reason"

        DataManager.getAPIResponse(parameterDictionary , methodName: methodName, methodType: "POST"){(responseData,error)-> Void in
            let status  = DataManager.getVal(responseData?["status"]) as? String ?? ""
//            let message  = DataManager.getVal(responseData?["message"]) as? String ?? ""

            if status == "1" {
                print("rr")
            }
            else {
//                 self.view.makeToast(message)
            }
        }
    }
    @IBAction func Block(_ sender: Any) {
        self.optionMenuView.isHidden = true
        self.view.endEditing(true)
        let parameterDictionary = NSMutableDictionary()
        let userID = Config().AppUserDefaults.value(forKey:"user_id") as? String ?? ""
       parameterDictionary.setValue("tribe123", forKey: "api_key")
       parameterDictionary.setValue(userID, forKey: "user_id")
       parameterDictionary.setValue("Tribe", forKey: "vibe")
        parameterDictionary.setValue(self.swipeUserID, forKey: "block_user_id")
       print(parameterDictionary)
        let methodName = "user_block"

        DataManager.getAPIResponse(parameterDictionary , methodName: methodName, methodType: "POST"){(responseData,error)-> Void in
            let status  = DataManager.getVal(responseData?["status"]) as? String ?? ""
//            let message  = DataManager.getVal(responseData?["message"]) as? String ?? ""

            if status == "1" {
                print("rr")
            }
            else {
//                 self.view.makeToast(message)
            }
        }
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
                let profileImg = self.profileDict.value(forKey: "profile_image") as? String
                self.imgprofile.sd_setImage(with: URL(string: Config().baseImageUrl + profileImg!), completed: nil)
                self.firstImpressionLbl.text = self.profileDict.value(forKey: "first_impression") as? String
                let hobbiesStr = self.profileDict.value(forKey: "hobbies") as? String
//                let result = hobbiesStr!.filter { !$0.isWhitespace }
                self.hobbiesArray = hobbiesStr!.components(separatedBy: ", ")
                let vibes = self.profileDict.value(forKey: "vibe") as? String ?? ""
                let vibesArr = vibes.components(separatedBy: ", ")
                print(vibesArr)
                let searchToSearch = "Soul Tribe"
                let worlds = vibesArr.flatMap { $0.components(separatedBy: " ")}
                let match = worlds.filter { searchToSearch.range(of:$0) != nil }.count != 0
                if match == true {
                    self.vibeStatusSoulLbl.text = "Soul Tribe"
                }else{
                    self.vibeStatusSoulLbl.text = ""
                }
                let searchToSearch1 = "Tribe"
                let worlds1 = vibesArr.flatMap { $0.components(separatedBy: " ")}
                let match1 = worlds1.filter { searchToSearch1.range(of:$0) != nil }.count != 0
                print(match1)
                if match == true {
                    self.vibeStatusTribeLbl.text = "Tribe"
                }else{
                    self.vibeStatusTribeLbl.text = ""
                }
                if match == true && match1 == true {
                    self.matchView.frame = self.view.frame
                    self.matchView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
                    self.view.addSubview(self.matchView)
                }else{
                }
                self.SexualityLbl.text = self.profileDict.value(forKey: "soul_love_my_sexuality") as? String
                self.GenderLbl.text = self.profileDict.value(forKey: "gender") as? String
                let distance = self.profileDict.value(forKey: "search_distance") as? String
                let distanceType = self.profileDict.value(forKey: "distance_type") as? String
                self.distanceLbl.text = "\(distance!)" + " " + "\(distanceType!)"
                self.RelationShipStatusLbl.text = self.profileDict.value(forKey: "soul_love_my_relationship_status") as? String
                self.ReligiousViewsLbl.text = self.profileDict.value(forKey: "religious") as? String
                self.AgeInt = self.profileDict.value(forKey: "age") as! Int
                self.userAge.text = String(self.AgeInt)
                self.intrestCollectionView.reloadData()
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
        return 10
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "discriptiontblcell", for: indexPath) as! discriptiontblcell
        cell.imguser.layer.cornerRadius = 10
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 320
        
        
    }
}
