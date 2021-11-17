//
//  SoultribepopupVC.swift
//  Soul Tribe
//
//  Created by MAC-28 on 14/07/21.
//

import UIKit

class SoultribepopupVC: UIView {
    @IBOutlet weak var btnstar: UIButton!
    @IBOutlet weak var btnheart: UIButton!
    @IBOutlet weak var cornorview: UIView!
    override func awakeFromNib() {
            super.awakeFromNib()
        
        btnstar.layer.cornerRadius = 5
        btnstar.layer.borderWidth = 1
        btnstar.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        btnheart.layer.cornerRadius = 5
        btnheart.layer.borderWidth = 1
        btnheart.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        cornorview.layer.cornerRadius = 5

        // Do any additional setup after loading the view.
    }

    @IBAction func btncancel(_ sender: Any) {
    }
  

}
