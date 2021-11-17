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
    var interestImage = ["Fitness","Music","Shopping","Aliens","Art","Sport"]
    var interestTxt = ["Fitness","Music","Shopping","Aliens","Art","Sport"]
   
    var leftDrawerTransition:DrawerTransition!
    var left = LeftMenuViewController()
   
  
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true

        // Do any additional setup after loading the view.
    }
    @IBAction func backbtnaction(_ sender:UIButton) {
        self.slideMenuController()?.toggleLeft()

    }

}
extension WhoLikedMeVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
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
            var interestImage = ["Fitness","Music","Shopping","Aliens","Art","Sport"]
            var interestTxt = ["Fitness","Music","Shopping","Aliens","Art","Sport"]
            
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

