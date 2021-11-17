//
//  InviatationsVC.swift
//  Soul Tribe
//
//  Created by Ashish Soni on 29/06/21.
//

import UIKit

class InviatationsVC: UIViewController {
    @IBOutlet weak var btnback: UIButton!
    @IBOutlet weak var btnrecive: UIButton!
    @IBOutlet weak var lblreceive: UILabel!
    @IBOutlet weak var btnsend: UIButton!
    @IBOutlet weak var lblsend: UILabel!
    @IBOutlet weak var view_main: UIView!
    @IBOutlet weak var lblstatus: UILabel!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblreceive.isHidden = false
        lblreceive.backgroundColor = UIColor(red: 13/255, green: 58/255, blue: 169/255, alpha: 1.0)
//        btnsend.backgroundColor = UIColor.clear
//        btnsend.isHidden = true
        btnrecive.setTitleColor(UIColor(red: 13/255, green: 58/255, blue: 169/255, alpha: 1.0), for: .normal)
        //btnsend.setTitleColor(UIColor(red: 34/255, green: 51/255, blue: 69/255, alpha: 1.0), for: .normal)
        
        // Do any additional setup after loading the view.
        
        let controller1 = storyboard?.instantiateViewController(identifier: "ReceivedInviatationsVC") as! ReceivedInviatationsVC
        controller1.view.frame = CGRect(x: 0, y: 0, width: self.view_main.frame.size.width, height: self.view_main.frame.size.height)
        controller1.willMove(toParent: self)
        self.view_main.addSubview(controller1.view)
        self.addChild(controller1)
        controller1.didMove(toParent: self)
    }
    @IBAction func recevieBtnAction(_ sender: Any) {
        lblreceive.isHidden = false
        lblreceive.backgroundColor = UIColor(red: 13/255, green: 58/255, blue: 169/255, alpha: 1.0)
        lblsend.backgroundColor = UIColor.clear
        lblsend.isHidden = true
        btnrecive.setTitleColor(UIColor(red: 13/255, green: 58/255, blue: 169/255, alpha: 1.0), for: .normal)
        btnsend.setTitleColor(UIColor(red: 34/255, green: 51/255, blue: 69/255, alpha: 1.0), for: .normal)
        lblstatus.text = "INVITES"
        
        let controller1 = storyboard?.instantiateViewController(identifier: "ReceivedInviatationsVC") as! ReceivedInviatationsVC
        controller1.view.frame = CGRect(x: 0, y: 0, width: self.view_main.frame.size.width, height: self.view_main.frame.size.height)
        controller1.willMove(toParent: self)
        self.view_main.addSubview(controller1.view)
        self.addChild(controller1)
        controller1.didMove(toParent: self)
        
    }
    @IBAction func sendBtnAction(_ sender: Any) {
        
        lblsend.isHidden = false
        lblsend.backgroundColor = UIColor(red: 13/255, green: 58/255, blue: 169/255, alpha: 1.0)
        lblreceive.backgroundColor = UIColor.clear
        lblreceive.isHidden = true
        btnrecive.setTitleColor(UIColor(red: 13/255, green: 58/255, blue: 169/255, alpha: 1.0), for: .normal)
        btnrecive.setTitleColor(UIColor(red: 34/255, green: 51/255, blue: 69/255, alpha: 1.0), for: .normal)
        lblstatus.text = "INVITED"

        let controller2 = storyboard?.instantiateViewController(identifier: "SentInviatationsVC") as! SentInviatationsVC
        controller2.view.frame = CGRect(x: 0, y: 0, width: self.view_main.frame.size.width, height: self.view_main.frame.size.height)
        controller2.willMove(toParent: self)
        self.view_main.addSubview(controller2.view)
        self.addChild(controller2)
        controller2.didMove(toParent: self)
        
        
    }
    @IBAction func btnback(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)

    }
   
}
