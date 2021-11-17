//
//  PremiumFeaturepopupVC.swift
//  Soul Tribe
//
//  Created by MAC-28 on 14/07/21.
//

import UIKit

class PremiumFeaturepopupVC: UIView {

    @IBOutlet weak var btnsigme: UIButton!
    @IBOutlet weak var cornorview: UIView!
    override func awakeFromNib() {
            super.awakeFromNib()
        
        btnsigme.layer.cornerRadius = 5
        cornorview.layer.cornerRadius = 5
        
        // Do any additional setup after loading the view.
    }
    @IBAction func btncancel(_ sender: Any) {
    }

    @IBAction func btnsignme(_ sender: Any) {
    }



}
