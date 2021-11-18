//
//  ReportPopupVC.swift
//  Soul Tribe
//
//  Created by MAC-28 on 14/07/21.
//

import UIKit

class ReportPopupVC: UIView {

    @IBOutlet weak var btncancel: UIButton!
    @IBOutlet weak var btncontinue: UIButton!
    @IBOutlet weak var cornorview: UIView!

    var swipeUserID = Int()
    override func awakeFromNib() {
            super.awakeFromNib()
        btncancel.layer.cornerRadius = 5
        btncancel.layer.borderWidth = 1
        btncancel.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        btncontinue.layer.cornerRadius = 5
//        btncontinue.layer.borderWidth = 1
//        btncontinue.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        cornorview.layer.cornerRadius = 5
        // Do any additional setup after loading the view.
    }
   
    @IBAction func btncancel(_ sender: Any) {
        
    }
    @IBAction func btncontinue(_ sender: Any) {
        
    }
}
