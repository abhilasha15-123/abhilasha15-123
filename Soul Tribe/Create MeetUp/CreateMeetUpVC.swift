//
//  CreateMeetUpVC.swift
//  Soul Tribe
//
//  Created by Ashish Soni on 29/06/21.
//

import UIKit

class CreateMeetUpVC: UIViewController,UIPopoverPresentationControllerDelegate {

    @IBOutlet weak var btnback: UIButton!
    @IBOutlet weak var imguser: UIImageView!
    @IBOutlet weak var btneditprofile: UIButton!
    @IBOutlet weak var viewtopic: UIView!
    @IBOutlet weak var txttopic: UITextField!
    @IBOutlet weak var btntopicdown: UIButton!
    @IBOutlet weak var viewdate: UIView!
    @IBOutlet weak var txtdate: UITextField!
    @IBOutlet weak var btndate: UIButton!
    @IBOutlet weak var txtviewdiscription: UITextView!
    @IBOutlet weak var viewprivat: UIView!
    @IBOutlet weak var viewpublic: UIView!
    @IBOutlet weak var btnprivate: UIButton!
    @IBOutlet weak var lblprivate: UILabel!
    @IBOutlet weak var btnpublic: UIButton!
    @IBOutlet weak var lblpublic: UILabel!
    @IBOutlet weak var btninvitemember: UIButton!
    @IBOutlet weak var btncreatemember: UIButton!
    @IBOutlet weak var viewtime: UIView!
    @IBOutlet weak var txttime: UITextField!
    @IBOutlet weak var viewAM: UIView!
    @IBOutlet weak var txtAM: UITextField!
    @IBOutlet weak var btnAM: UIButton!
    @IBOutlet weak var viewlocation: UIView!
    @IBOutlet weak var txtlocation: UITextField!
    @IBOutlet weak var btnlocation: UIButton!
    @IBOutlet weak var viewsharetribe: UIView!
    @IBOutlet weak var txttribe: UITextField!
    @IBOutlet weak var btnminitribe: UIButton!
    @IBOutlet weak var popupview: UIView!
    @IBOutlet weak var btncreatepop: UIButton!
    @IBOutlet weak var btnbackpop: UIButton!
    @IBOutlet weak var innerpopview: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        
        popupview.isHidden = true
        innerpopview.layer.cornerRadius = 8

        btncreatepop.layer.cornerRadius = 5
        btnbackpop.layer.cornerRadius = 5
        btnbackpop.layer.borderWidth = 1
        btnbackpop.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        viewtopic.layer.cornerRadius = 5
        viewtopic.layer.borderWidth = 1
        viewtopic.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        viewdate.layer.cornerRadius = 5
        viewdate.layer.borderWidth = 1
        viewdate.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        viewtime.layer.cornerRadius = 5
        viewtime.layer.borderWidth = 1
        viewtime.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        viewAM.layer.cornerRadius = 5
        viewAM.layer.borderWidth = 1
        viewAM.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        viewtopic.layer.cornerRadius = 5
        viewtopic.layer.borderWidth = 1
        viewtopic.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        
        viewlocation.layer.cornerRadius = 5
        viewlocation.layer.borderWidth = 1
        viewlocation.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        viewprivat.layer.cornerRadius = 5
        viewprivat.layer.borderWidth = 1
        viewprivat.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        viewpublic.layer.cornerRadius = 5
        viewpublic.layer.borderWidth = 1
        viewpublic.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        viewsharetribe.layer.cornerRadius = 5
        viewsharetribe.layer.borderWidth = 1
        viewsharetribe.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        txtviewdiscription.layer.cornerRadius = 5
        txtviewdiscription.layer.borderWidth = 1
        txtviewdiscription.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        
//        let nextview = CreateMeetuppopupVC.intitiateFromNib()
//                       let model = BackModel()
//                       nextview.buttonCreateHandler = {
//                           model.closewithAnimation()
//                       }
//
//                       nextview.buttoncancelHandler = {
//                           let deafults = UserDefaults.standard
//                           deafults.set("0", forKey: "Logoutstatus")
//                           deafults.removeObject(forKey: "UserIDAutologin")
//                           deafults.synchronize()
//                           let vc = self.storyboard?.instantiateViewController(withIdentifier: "CreateMeetuppopupVC") as! CreateMeetuppopupVC
//                           self.navigationController?.pushViewController(vc, animated: true)
//                           model.closewithAnimation()
//                       }
                       
                       // model.showLogout(view: nextview)
        
        // Do any additional setup after loading the view.
    }
    @IBAction func backBtnAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

    @IBAction func btncreatemeet(_ sender: Any) {
        
       popupview.isHidden = false
//        let nextview = CreateMeetuppopupVC.intitiateFromNib()
//        let model = BackModel()
//        nextview.buttoncancelHandler = {
//            model.closewithAnimation()
//        }
//
//        nextview.buttonCreateHandler = {
////            let vc = self.storyboard?.instantiateViewController(withIdentifier: "CreateMeetuppopupVC") as! CreateMeetuppopupVC
////            self.navigationController?.pushViewController(vc, animated: true)
////            model.closewithAnimation()
//        }
//          model.showLogout(view: nextview)
    }
    @IBAction func btncreatepop(_ sender: Any) {
        getData()
//        let vc = self.storyboard?.instantiateViewController(identifier: "GroupTribeTabVC") as! GroupTribeTabVC
//        navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func btnbackpop(_ sender: Any) {
        popupview.isHidden = true

    }


    
    @IBAction func btninvitemember(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(identifier: "InviteMemberVC") as! InviteMemberVC
        //navigationController?.pushViewController(vc, animated: true)
        vc.modalTransitionStyle = .coverVertical
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true, completion: nil)

    }
    func getData(){
        
         self.view.endEditing(true)
        let paraDict = NSMutableDictionary()
        paraDict.setValue(Config().api_key, forKey: "api_key")
        paraDict.setValue("37", forKey: "user_id")
        paraDict.setValue("7", forKey: "mini_tribe_id")
        paraDict.setValue(txttopic.text!, forKey: "meetup_topic")
        paraDict.setValue(txtdate.text!, forKey: "meetup_date")
        paraDict.setValue(txttime.text!, forKey: "meetup_time")
        paraDict.setValue(txtAM.text!, forKey: "meetup_period")
        paraDict.setValue(txtviewdiscription.text!, forKey: "meetup_description")
        paraDict.setValue(txtlocation.text!, forKey: "meetup_location")
        paraDict.setValue("7.88888", forKey: "meetup_latitude")
        paraDict.setValue("8.66666", forKey: "meetup_longitude")
        paraDict.setValue("1", forKey: "meetup_visibility")
        paraDict.setValue("1", forKey: "invite_ids")
        paraDict.setValue( "", forKey: "meetup_icon")
        paraDict.setValue("", forKey: "meetup_status")
        print(paraDict)
         let methodName = "create_mini_tribe_meetup"

        DataManager.getAPIResponse(paraDict , methodName: methodName, methodType: "POST"){(responseData,error)-> Void in
             let status  = DataManager.getVal(responseData?["status"]) as? String ?? ""
             let message  = DataManager.getVal(responseData?["message"]) as? String ?? ""
                print(message)
             if status == "1" {
                
                print(DataManager.getVal(responseData?["message"]) as? [String:Any] ?? [:])
//                 self.userDict = DataManager.getVal(responseData?["profile"]) as? [String:Any] ?? [:]
//                 let countryDict = DataManager.getVal(self.userDict["country"]) as? [String:Any] ?? [:]
//
//                 self.lbl_name.text = DataManager.getVal(self.userDict["username"]) as? String ?? ""
//                 self.lbl_email.text = DataManager.getVal(self.userDict["email"]) as? String ?? ""
//                 self.lbl_phone.text = "+\(DataManager.getVal(self.userDict["phone"]) as? String ?? "")"
//                 self.lbl_country.text = DataManager.getVal(countryDict["name"]) as? String ?? ""
//                 self.img_disp.sd_setImage(with: URL(string: DataManager.getVal(self.userDict["image"]) as? String ?? ""), placeholderImage: UIImage(named: "user"))
//                 Config().AppUserDefaults.setValue(DataManager.getVal(self.userDict["image"]) as? String ?? "", forKey: "user_img")
//                 Config().AppUserDefaults.setValue(DataManager.getVal(self.userDict["username"]) as? String ?? "", forKey: "user_name")
//                 Config().AppUserDefaults.setValue(DataManager.getVal(self.userDict["phone"]) as? String ?? "", forKey: "user_phone")
             }
             else {
//                 self.view.makeToast(message)
             }
//         basicFunctions.stopLoading()
         }
     }
     
}
