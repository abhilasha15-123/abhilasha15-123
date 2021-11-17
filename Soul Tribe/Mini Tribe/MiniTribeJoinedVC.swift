//
//  MiniTribeJoinedVC.swift
//  Soul Tribe
//
//  Created by Ashish Soni on 01/07/21.
//

import UIKit
class MiniTribeJoinedTblCell: UITableViewCell{
    @IBOutlet weak var imguser: UIImageView!
    @IBOutlet weak var lblname: UILabel!
    @IBOutlet weak var lbldate_time: UILabel!
    @IBOutlet weak var lbldiscription: UILabel!
    @IBOutlet weak var btnreadmore: UIButton!
    
}
class MiniTribeJoinedCollcell: UICollectionViewCell{
    @IBOutlet weak var lblusercoll: UIImageView!
    
}
class MiniTribeJoinedVC: UIViewController {

    @IBOutlet weak var imguser: UIImageView!
    @IBOutlet weak var lbljourney: UILabel!
    @IBOutlet weak var lblmember: UILabel!
    @IBOutlet weak var btnjoin: UIButton!
    @IBOutlet weak var lbldiscription: UILabel!
    @IBOutlet weak var btnreadmore: UIButton!
    @IBOutlet weak var btnlike: UIButton!
    @IBOutlet weak var lbllike: UILabel!
    @IBOutlet weak var btncomment: UIButton!
    @IBOutlet weak var lblcomment: UILabel!
    @IBOutlet weak var btnlike2: UIButton!
    @IBOutlet weak var btn2comment: UIButton!
    @IBOutlet weak var btnshare: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
