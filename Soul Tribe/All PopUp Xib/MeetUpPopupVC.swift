//
//  MeetUpPopupVC.swift
//  Soul Tribe
//
//  Created by MAC-28 on 14/07/21.
//

import UIKit

class MeetUpPopupVC: UIView {

    @IBOutlet weak var btnback: UIButton!
    @IBOutlet weak var btnaccept: UIButton!
    @IBOutlet weak var viewcornor: UIView!
    
    override func awakeFromNib() {
            super.awakeFromNib()
        btnback.layer.cornerRadius = 5
        btnback.layer.borderWidth = 1
        btnback.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        btnaccept.layer.cornerRadius = 5
        viewcornor.layer.cornerRadius = 5
       
        // Do any additional setup after loading the view.
    }


    
    
    @IBAction func btnaccept(_ sender: Any) {
    }
    @IBAction func btnback(_ sender: Any) {
    }
}
