//
//  AcceptedMeetUpVC.swift
//  Soul Tribe
//
//  Created by Ashish Soni on 29/06/21.
//

import UIKit
import FSCalendar
class AcceptedMeetUpVC: UIViewController {
    @IBOutlet weak var btnback: UIButton!
    @IBOutlet weak var viewdate: UIView!
    @IBOutlet weak var txtdate: UITextField!
    @IBOutlet weak var btndate: UIButton!
    @IBOutlet weak var viewcalendar: UIView!
    @IBOutlet weak var headerview: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewdate.layer.cornerRadius = 5
        viewdate.layer.borderWidth = 1
        viewdate.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
       
        headerview.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        headerview.layer.shadowOpacity = 0.5
        headerview.layer.shadowOffset = .zero
        headerview.layer.shadowRadius = 5
        
        viewcalendar.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        viewcalendar.layer.shadowOpacity = 0.6
        viewcalendar.layer.shadowOffset = .zero
        viewcalendar.layer.shadowRadius = 6
        viewcalendar.layer.cornerRadius = 8

        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backBtnAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)

    }

   

}
