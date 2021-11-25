//
//  MiniTribeRequetedVC.swift
//  Soul Tribe
//
//  Created by Ashish Soni on 01/07/21.
//

import UIKit

class MiniTribeRequetedVC: UIViewController {
   
    @IBAction func btn_joinAction(_ sender: UIButton) {
        
        miniTribeId = DataManager.getVal(dictData["id"]) as? String ?? ""
        selectedRequestJoinUserId = DataManager.getVal(dictData["user_id"]) as? String ?? ""
        
        if DataManager.getVal(dictData["tribe_status"]) as? String ?? "" == "join"{
            lbl_subviewHeading.text = "Request to join this Mini Tribe"
            btn_request.setTitle("Request", for: .normal)
            btn_cenacel.setTitle("Cancel", for: .normal)
          
            vw_confirmation.isHidden = false
        }
        else if DataManager.getVal(dictData["tribe_status"]) as? String ?? "" == "requested"{
        }else if DataManager.getVal(dictData["tribe_status"]) as? String ?? "" == "invited"{
            lbl_subviewHeading.text = "Would you like to accept or reject this tribe request?"
            btn_request.setTitle("Accept", for: .normal)
            btn_cenacel.setTitle("Reject", for: .normal)
            
            vw_confirmation.isHidden = false
        }else if DataManager.getVal(dictData["tribe_status"]) as? String ?? "" == "joined"{
        }
    }
    
    @IBAction func btn_cancelAction(_ sender: UIButton) {
        if btn_cenacel.title(for: .normal) == "Cancel"{
            vw_confirmation.isHidden = true
        }else{
            api_call_acceptReject(status: "2")
        }
    }
    
    @IBAction func btn_requestAction(_ sender: UIButton) {
        
        if btn_request.title(for: .normal) == "Request"{
            basicFunctions.presentLoader()
           
            let paraDict = NSMutableDictionary()
            paraDict.setValue(Config().api_key, forKey: "api_key")
            paraDict.setValue(selectedRequestJoinUserId, forKey: "user_id")
            paraDict.setValue(miniTribeId, forKey: "mini_tribe_id")
            paraDict.setValue(Config().AppUserDefaults.value(forKey:"user_id") as? String ?? "", forKey: "join_request_user_id")
            
            print(paraDict)
            
            let methodName = "request_to_join_mini_tribe"
            DataManager.getAPIResponse(paraDict , methodName: methodName, methodType: "POST"){(responseData,error)-> Void in
                let status  = DataManager.getVal(responseData?["status"]) as? String ?? ""
                let message  = DataManager.getVal(responseData?["message"]) as? String ?? ""
                print(message)
                if status == "1" {
                    self.vw_confirmation.isHidden = true
                    self.view.makeToast(message)
                    DispatchQueue.main.asyncAfter(deadline: .now()+1.5, execute: {
                        self.api_getData()
                    })
                }
                else {
                    self.vw_confirmation.isHidden = true
                    self.view.makeToast(message)
                }
            basicFunctions.stopLoading()
            }
        }else{
            api_call_acceptReject(status: "1")
        }
    }
    
    @IBAction func btn_closePopupAction(_ sender: UIButton) {
        self.vw_confirmation.isHidden = true
    }
    
    @IBOutlet weak var btn_closePopup: ResponsiveButton!
    @IBOutlet weak var lbl_subviewHeading: UILabel!
    @IBOutlet weak var btn_cenacel: UIButton!
    @IBOutlet weak var btn_request: UIButton!
    @IBOutlet weak var vw_confirmation: UIView!
    @IBOutlet weak var vw_subView: UIView!
    
//    @IBOutlet weak var lbl_visibility: UILabel!
    @IBOutlet weak var lbl_name: UILabel!
    @IBOutlet weak var btnback: UIButton!
    @IBOutlet weak var imgprofile: UIImageView!
    @IBOutlet weak var lblmember: UILabel!
    @IBOutlet weak var btnjoin: UIButton!
    @IBOutlet weak var lbldiscription: UILabel!

    
    var miniTribeId = ""
    var dictData = [String:Any]()
    var selectedRequestJoinUserId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imgprofile.layer.cornerRadius = imgprofile.frame.size.width/2
        imgprofile.contentMode = .scaleToFill
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        api_getData()
    }
    
    @IBAction func backBtnAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    func api_call_acceptReject(status: String){
        basicFunctions.presentLoader()
        
        let paraDict = NSMutableDictionary()
        paraDict.setValue(Config().api_key, forKey: "api_key")
        paraDict.setValue(selectedRequestJoinUserId, forKey: "user_id")
        paraDict.setValue(miniTribeId, forKey: "mini_tribe_id")
        paraDict.setValue(Config().AppUserDefaults.value(forKey:"user_id") as? String ?? "", forKey: "invited_user_id")
        paraDict.setValue(status, forKey: "status")
        print(paraDict)
        
        let methodName = "accept_reject_invite_request_mini_tribe"
        DataManager.getAPIResponse(paraDict , methodName: methodName, methodType: "POST"){(responseData,error)-> Void in
            let status  = DataManager.getVal(responseData?["status"]) as? String ?? ""
            let message  = DataManager.getVal(responseData?["message"]) as? String ?? ""
            print(message)
            if status == "1" {
                self.vw_confirmation.isHidden = true
                self.view.makeToast(message)
                DispatchQueue.main.asyncAfter(deadline: .now()+1.5, execute: {
                    self.api_getData()
                })
            }
            else {
                print(message)
            }
        basicFunctions.stopLoading()
        }
    }
    
    func api_getData(){
        basicFunctions.presentLoader()
       
        let paraDict = NSMutableDictionary()
        paraDict.setValue(Config().api_key, forKey: "api_key")
        paraDict.setValue(Config().AppUserDefaults.value(forKey:"user_id") as? String ?? "", forKey: "user_id")
        paraDict.setValue(miniTribeId, forKey: "mini_tribe_id")
        
        print(paraDict)
        
        let methodName = "get_detail_mini_tribe"
        DataManager.getAPIResponse(paraDict , methodName: methodName, methodType: "POST"){(responseData,error)-> Void in
            let status  = DataManager.getVal(responseData?["status"]) as? String ?? ""
            let message  = DataManager.getVal(responseData?["message"]) as? String ?? ""
            print(message)
            if status == "1" {
                self.dictData = DataManager.getVal(responseData?["data"]) as? [String:Any] ?? [:]
                self.setupData()
            }
            else {
                print(message)
            }
        basicFunctions.stopLoading()
        }
    }
    
    func setupData(){
        imgprofile.sd_setImage(with: URL(string: "\(Config().baseImageUrl)\(DataManager.getVal(self.dictData["image"]) as? String ?? "")"), completed: nil)
        self.lbl_name.text = DataManager.getVal(self.dictData["name"]) as? String ?? ""
        self.lblmember.text = "\(DataManager.getVal(self.dictData["members_count"]) as? String ?? "") members"
        self.lbldiscription.text = DataManager.getVal(self.dictData["about"]) as? String ?? ""
        
        if DataManager.getVal(self.dictData["tribe_status"]) as? String ?? "" == "join"{
            btnjoin.setTitle("Request to Join", for: .normal)
        }
        else if DataManager.getVal(self.dictData["tribe_status"]) as? String ?? "" == "requested"{
            btnjoin.setTitle("Requested", for: .normal)
        }else if DataManager.getVal(self.dictData["tribe_status"]) as? String ?? "" == "invited"{
            btnjoin.setTitle("Invited", for: .normal)
        }else if DataManager.getVal(self.dictData["tribe_status"]) as? String ?? "" == "joined"{
            btnjoin.setTitle("Joined", for: .normal)
        }
    }
}
