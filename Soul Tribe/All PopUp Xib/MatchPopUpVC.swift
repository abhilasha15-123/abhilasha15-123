//
//  MatchPopUpVC.swift
//  Soul Tribe
//
//  Created by MAC-28 on 14/07/21.
//

import UIKit

class MatchPopUpVC: UIView {

    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var img2: UIImageView!
    @IBOutlet weak var btnmessage: UIButton!
    @IBOutlet weak var btnkeepsweeing: UIButton!
  
    override func awakeFromNib() {
            super.awakeFromNib()
        img1.layer.cornerRadius = 5
        img2.layer.cornerRadius = 5
        btnmessage.layer.cornerRadius = 5
        btnmessage.layer.cornerRadius = 5
        // Do any additional setup after loading the view.
    }
    @IBAction func btncancel(_ sender: Any) {
    }
    @IBAction func btnmessage(_ sender: Any) {
    }
    @IBAction func btnkeepswiping(_ sender: Any) {
    }
}
