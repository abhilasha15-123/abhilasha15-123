//
//  WhoLikedMeVC.swift
//  Soul Tribe
//
//  Created by Ashish Soni on 11/06/21.
//

import UIKit

class WhoLikedMetblcell: UITableViewCell{
    @IBOutlet weak var imagecolletion: UICollectionView!
    @IBOutlet weak var interestcollection: UICollectionView!
    @IBOutlet weak var mainviewcornor: UIView!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.imagecolletion.delegate = self
        self.imagecolletion.dataSource = self

        self.interestcollection.delegate = self
        self.interestcollection.dataSource = self

    }
    
}
class WhoLikedMecollcell1: UICollectionViewCell{
    @IBOutlet weak var lblKm: UILabel!

}

class WhoLikedMecollcell2: UICollectionViewCell{
    @IBOutlet weak var cornorview: UIView!
    @IBOutlet weak var interestImage: UIImageView!
    @IBOutlet weak var interstedLbl: UILabel!
    
}

class WhoLikedMeVC: UIViewController {
    var interestImage = ["Aliens","Art","Cooking","Dancing","Fitness","Gaming","Hiking","Law of Attraction","Meditation","Music","Outdoors","Plant Medicine","Quantam Physics","Reading","Shopping","Social Events","Spirituality","Sports","Travel","Yoga"]
    var interestTxt = ["Aliens","Art","Cooking","Dancing","Fitness","Gaming","Hiking","Law of Attraction","Meditation","Music","Outdoors","Plant Medicine","Quantam Physics","Reading","Shopping","Social Events","Spirituality","Sports","Travel","Yoga"]
   
    @IBOutlet weak var table_view: UITableView!
    var leftDrawerTransition:DrawerTransition!
    var left = LeftMenuViewController()
    var wholikeList = NSDictionary()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        getlikeduser_list()
        // Do any additional setup after loading the view.
    }
    
    func getlikeduser_list(){
        let parameterDictionary = NSMutableDictionary()
     let userID = Config().AppUserDefaults.value(forKey:"user_id") as? String ?? ""
       parameterDictionary.setValue("tribe123", forKey: "api_key")
        parameterDictionary.setValue(userID, forKey: "user_id")

       print(parameterDictionary)
        let methodName = "get_liked_users_list"

        DataManager.getAPIResponse(parameterDictionary , methodName: methodName, methodType: "POST"){(responseData,error)-> Void in
            let status  = DataManager.getVal(responseData?["status"]) as? String ?? ""
            let message  = DataManager.getVal(responseData?["message"]) as? String ?? ""

            if status == "1" {
                self.wholikeList = DataManager.getVal(responseData?["data"]) as! NSDictionary
                print(self.wholikeList)
            }
            else {
//                 self.view.makeToast(message)
            }
        }
    }
    @IBAction func backbtnaction(_ sender:UIButton) {
        self.slideMenuController()?.toggleLeft()

    }

}
extension WhoLikedMeVC: UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        var numOfSections: Int = 0
        if self.wholikeList.count>0
          {
            numOfSections = 1
            table_view.backgroundView = nil
             }
        else{
            let noDataLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: table_view.bounds.size.width, height: table_view.bounds.size.height))
            noDataLabel.text = "Attraction in Process"
            noDataLabel.textColor = UIColor.black
            noDataLabel.textAlignment = .center
            table_view.backgroundView  = noDataLabel
        }
        return numOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.wholikeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WhoLikedMetblcell", for: indexPath) as! WhoLikedMetblcell
        cell.mainviewcornor.layer.cornerRadius = 12
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 700
        
    }
}
    extension WhoLikedMetblcell: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        if collectionView == imagecolletion
        {
            return 5
        }
        else
        {
            return 5
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == imagecolletion
        
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WhoLikedMecollcell1", for: indexPath) as! WhoLikedMecollcell1
            cell.lblKm.layer.cornerRadius = 6
            return cell
        }
        else
        {
            let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "WhoLikedMecollcell2", for: indexPath) as! WhoLikedMecollcell2
            cell1.cornorview.layer.cornerRadius = 5
            var interestImage = ["Aliens","Art","Cooking","Dancing","Fitness","Gaming","Hiking","Law of Attraction","Meditation","Music","Outdoors","Plant Medicine","Quantam Physics","Reading","Shopping","Social Events","Spirituality","Sports","Travel","Yoga"]
            var interestTxt = ["Aliens","Art","Cooking","Dancing","Fitness","Gaming","Hiking","Law of Attraction","Meditation","Music","Outdoors","Plant Medicine","Quantam Physics","Reading","Shopping","Social Events","Spirituality","Sports","Travel","Yoga"]
            
            cell1.interestImage.image = UIImage(named: interestImage[indexPath.item])
            cell1.interstedLbl.text = interestTxt[indexPath.item]
//            cell1.cornorview.layer.borderWidth = 1
//            cell1.cornorview.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)


            return cell1
        }
    
    
    
}
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 10
            
        }
        //UICollectionViewDelegateFlowLayout
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            
            return CGSize(width: collectionView.frame.width/3.3, height: collectionView.frame.height/2.5);

           }
}

