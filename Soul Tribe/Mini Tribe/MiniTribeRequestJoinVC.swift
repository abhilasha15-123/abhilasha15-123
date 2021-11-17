//
//  MiniTribeRequestJoinVC.swift
//  Soul Tribe
//
//  Created by Ashish Soni on 01/07/21.
//

import UIKit

class MiniTribeRequestJoinVC: UIViewController {

    @IBOutlet weak var btnback: UIButton!
    @IBOutlet weak var imguser: UIImageView!
    @IBOutlet weak var lblteamtraveller: UILabel!
    @IBOutlet weak var lblmember: UILabel!
    @IBOutlet weak var btnjoin: UIButton!
    @IBOutlet weak var lbldiscription: UILabel!
    @IBOutlet weak var btnreadmore: UIButton!
    @IBOutlet weak var viewcornor: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        viewcornor.layer.cornerRadius = 55
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backBtnAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
   

}
