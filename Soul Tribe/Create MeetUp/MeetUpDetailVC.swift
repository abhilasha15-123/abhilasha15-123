//
//  MeetUpDetailVC.swift
//  Soul Tribe
//
//  Created by Ashish Soni on 29/06/21.
//

import UIKit
import MapKit

class MeetUpDetailVC: UIViewController {
    //MARK:- IBOutlet

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
    @IBOutlet weak var lblGoing: UILabel!
    @IBOutlet weak var lblNotGoing: UILabel!
    @IBOutlet weak var lblMightGo: UILabel!
    //MARK:- Variables
    var ApiDict = NSMutableDictionary()
    //MARK:- viewDidLoad

    override func viewDidLoad() {
        super.viewDidLoad()
        getdata()

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
    
    //MARK:- backBtnAction

    @IBAction func backBtnAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)

    }
    //MARK:- ApiManager

    func getdata(){
        let userID = Config().AppUserDefaults.value(forKey:"user_id") as? String ?? ""
        let paraDict = NSMutableDictionary()
        paraDict.setValue(Config().api_key, forKey: "api_key")
        paraDict.setValue(userID, forKey: "user_id")
        paraDict.setValue("3", forKey: "mini_tribe_id")
        paraDict.setValue("1", forKey: "mini_tribe_meetup_id")
        
        let methodName = "get_detail_mini_tribe_meetup"
        DataManager.getAPIResponse(paraDict , methodName: methodName, methodType: "POST"){(responseData,error)-> Void in
             let status  = DataManager.getVal(responseData?["status"]) as? String ?? ""
             let message  = DataManager.getVal(responseData?["message"]) as? String ?? ""
                print(message)
             if status == "1" {
                print(DataManager.getVal(responseData?["data"]) as? [String:Any] ?? [:])
                self.ApiDict = DataManager.getVal(responseData?["data"]) as? NSMutableDictionary ?? [:]
                self.lbldate.text = self.ApiDict["meetup_date"] as? String ?? ""
                self.lbltime.text = self.ApiDict["meetup_time"] as? String ?? ""
                self.lbllocation.text = self.ApiDict["meetup_location"] as? String ?? ""
                self.lbldiscription.text = self.ApiDict["meetup_description"] as? String ?? ""
                self.lblcreated.text = "Created By \(self.ApiDict["name"] as? String ?? "")"
                self.lblGoing.text = "\(self.ApiDict["meetup_going_members"] as? Int ?? 0) People Are Going"
                self.lblNotGoing.text = "\(self.ApiDict["meetup_not_going_members"] as? Int ?? 0) People Are Not Going"
                self.lblMightGo.text = "\(self.ApiDict["meetup_might_go_members"] as? Int ?? 0) Might Go"
             }
             else {
                print(message)
             }
    }
    }

}
