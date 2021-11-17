//
//  CreateMeetuppopupVC.swift
//  Soul Tribe
//
//  Created by MAC-28 on 14/07/21.
//

import UIKit

class CreateMeetuppopupVC: UIView {

    @IBOutlet weak var btnback: UIButton!
    @IBOutlet weak var btncreate: UIButton!
    @IBOutlet weak var viewcornor: UIView!
    var buttonCreateHandler : (() -> Void)?
    var buttoncancelHandler : (() -> Void)?
    
    class func intitiateFromNib() -> CreateMeetuppopupVC {
            let View1 = UINib.init(nibName: "CreateMeetuppopupVC", bundle: nil).instantiate(withOwner: self, options: nil).first as! CreateMeetuppopupVC
            return View1
        }
    
    override func awakeFromNib() {
            super.awakeFromNib()
        btnback.layer.cornerRadius = 5
        btnback.layer.borderWidth = 1
        btnback.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        btncreate.layer.cornerRadius = 5
        btncreate.layer.borderWidth = 1
        btncreate.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        viewcornor.layer.cornerRadius = 5
      
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func btnback(_ sender: Any) {
        buttoncancelHandler?()
    }

    @IBAction func btnCeate(_ sender: Any) {
        buttonCreateHandler?()
    }

    
}

