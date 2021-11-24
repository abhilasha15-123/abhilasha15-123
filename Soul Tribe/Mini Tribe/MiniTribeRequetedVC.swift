//
//  MiniTribeRequetedVC.swift
//  Soul Tribe
//
//  Created by Ashish Soni on 01/07/21.
//

import UIKit

class MiniTribeRequetedVC: UIViewController {
   
//    @IBOutlet weak var lbl_visibility: UILabel!
    @IBOutlet weak var lbl_name: UILabel!
    @IBOutlet weak var btnback: UIButton!
    @IBOutlet weak var imgprofile: UIImageView!
    @IBOutlet weak var lblmember: UILabel!
    @IBOutlet weak var btnjoin: UIButton!
    @IBOutlet weak var lbldiscription: UILabel!

    
    var miniTribeId = ""
    var dictData = [String:Any]()
    
    
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
