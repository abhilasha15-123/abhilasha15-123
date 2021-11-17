//
//  MiniTribeJoinVC.swift
//  Soul Tribe
//
//  Created by Ashish Soni on 01/07/21.
//

import UIKit
class MiniTribeJointblcell: UITableViewCell{
    @IBOutlet weak var imguser: UIImageView!
    @IBOutlet weak var lblusername: UILabel!
    @IBOutlet weak var lbldate_time: UILabel!
    @IBOutlet weak var lbldiscription: UILabel!
    @IBOutlet weak var btnreadmore: UIButton!
}
class MiniTribeJoinCollCell: UICollectionViewCell{
    
    @IBOutlet weak var userimgcoll: UIImageView!
   
}
class MiniTribeJoinVC: UIViewController {

    @IBOutlet weak var btnback: UIButton!
    @IBOutlet weak var imgprofile: UIImageView!
    @IBOutlet weak var lbljournettext: UILabel!
    @IBOutlet weak var lblmember: UILabel!
    @IBOutlet weak var btnjoin: UIButton!
    @IBOutlet weak var lbldiscription: UILabel!
    @IBOutlet weak var btnreadmore: UIButton!
    @IBOutlet weak var btnlike: UIButton!
    @IBOutlet weak var lbllike: UILabel!
    @IBOutlet weak var btncomment: UIButton!
    @IBOutlet weak var lblcomment: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func backBtnAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    

}
extension MiniTribeJoinVC: UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MiniTribeJointblcell", for: indexPath) as! MiniTribeJointblcell
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MiniTribeJoinCollCell", for: indexPath) as! MiniTribeJoinCollCell
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height/2);
        }
}
