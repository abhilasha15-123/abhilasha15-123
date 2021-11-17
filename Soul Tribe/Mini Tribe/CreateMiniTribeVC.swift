//
//  CreateMiniTribeVC.swift
//  Soul Tribe
//
//  Created by Ashish Soni on 29/06/21.
//

import UIKit

class CreateMiniTribeVC: UIViewController,UITextViewDelegate {

    @IBOutlet weak var Btnback: UIButton!
    @IBOutlet weak var btneditprofile: UIButton!
    @IBOutlet weak var txtname: UITextField!
    @IBOutlet weak var txtdiscription: UITextView!
    @IBOutlet weak var viewprivate: UIView!
    @IBOutlet weak var btnprivate: UIButton!
    @IBOutlet weak var viewpublic: UIView!
    @IBOutlet weak var btnpublic: UIButton!
    @IBOutlet weak var btninvitemember: UIButton!
//@IBOutlet weak var imgmember: UIImageView!
    @IBOutlet weak var btncreatetribe: UIButton!
   


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        viewprivate.layer.cornerRadius = 5
        viewprivate.layer.borderWidth = 1
        viewprivate.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
      //  imgmember.layer.cornerRadius = 50
       
        
        viewpublic.layer.cornerRadius = 5
        viewpublic.layer.borderWidth = 1
        viewpublic.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
     
        txtname.layer.cornerRadius = 5
        txtname.layer.borderWidth = 1
        txtname.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        txtdiscription.layer.cornerRadius = 5
        txtdiscription.layer.borderWidth = 1
        txtdiscription.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        

        txtdiscription.delegate = self
        txtdiscription.text = "Describe your Mini Tribe"
        txtdiscription.textColor = UIColor.lightGray
    }
    
    @IBAction func backBtnAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    

}
