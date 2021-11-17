//
//  MeetUpDetailVC.swift
//  Soul Tribe
//
//  Created by Ashish Soni on 29/06/21.
//

import UIKit
import MapKit

class MeetUpDetailVC: UIViewController {

    @IBOutlet weak var btnback: UIButton!
    @IBOutlet weak var imguser: UIImageView!
    @IBOutlet weak var lblmeditation: UILabel!
    @IBOutlet weak var btnpublic: UIButton!
    @IBOutlet weak var lblcreated: UILabel!
    @IBOutlet weak var lbldate: UILabel!
    @IBOutlet weak var lbltime: UILabel!
    @IBOutlet weak var lbllocation: UILabel!
    @IBOutlet weak var btnmap: UIButton!
    @IBOutlet weak var lbldiscription: UILabel!
    @IBOutlet weak var btnraedmore: UIButton!
    @IBOutlet weak var btngoing: UIButton!
    @IBOutlet weak var btnmightgo: UIButton!
    @IBOutlet weak var btnnotgoing: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        btngoing.layer.cornerRadius = 6
//        btngoing.layer.borderWidth = 0.7
//        btngoing.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)

        btnmightgo.layer.cornerRadius = 6
        btnmightgo.layer.borderWidth = 0.7
        btnmightgo.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        btnnotgoing.layer.cornerRadius = 6
        btnnotgoing.layer.borderWidth = 0.7
        btnnotgoing.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backBtnAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)

    }
  

}
