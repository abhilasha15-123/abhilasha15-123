//
//  MeetUpInvitaionVC.swift
//  Soul Tribe
//
//  Created by Ashish Soni on 29/06/21.
//

import UIKit
//MARK:- MeetUpInvitaioncell
class MeetUpInvitaioncell: UITableViewCell{
    
    @IBOutlet weak var imguser: UIImageView!
    @IBOutlet weak var lblname: UILabel!
    @IBOutlet weak var lblcreate: UILabel!
    @IBOutlet weak var btncircle: UIButton!
    @IBOutlet weak var lbldate: UILabel!
    @IBOutlet weak var lbltime: UILabel!
    @IBOutlet weak var lbllocation: UILabel!
    @IBOutlet weak var btngoing: UIButton!
    @IBOutlet weak var btnnotsure: UIButton!
    @IBOutlet weak var btnnotgoing: UIButton!
    @IBOutlet weak var lblgoing: UILabel!
    @IBOutlet weak var lblnotgoing: UILabel!
    @IBOutlet weak var lblmightgoing: UILabel!
    @IBOutlet weak var viewcornor: UIView!
}
//MARK:- MeetUpInvitaionVC

class MeetUpInvitaionVC: UIViewController {
    
    //MARK:- IBOutlet
    @IBOutlet weak var btnback: UIView!
    @IBOutlet weak var headerview: UIView!
    @IBOutlet weak var meetUpInvitationTableView: UITableView!
    
    //MARK:- variables
    
    var ApiDataArr = NSMutableArray()
    var ApiDict = NSMutableDictionary()
    

    //MARK:-
    override func viewDidLoad() {
        super.viewDidLoad()
        getdata()
        // Do any additional setup after loading the view.
        headerview.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        headerview.layer.shadowOpacity = 0.5
        headerview.layer.shadowOffset = .zero
        headerview.layer.shadowRadius = 5
    }
    //MARK:- backBtnAction
    @IBAction func backBtnAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)

    }
    //MARK:- apiManager
    
    func getdata(){
        basicFunctions.presentLoader()
        let paraDict = NSMutableDictionary()
        paraDict.setValue(Config().api_key, forKey: "api_key")
        paraDict.setValue(Config().AppUserDefaults.value(forKey:"user_id") as? String ?? "", forKey: "user_id")
        let methodName = "get_mini_tribe_meetup_invitation_list"
        DataManager.getAPIResponse(paraDict , methodName: methodName, methodType: "POST"){(responseData,error)-> Void in
             let status  = DataManager.getVal(responseData?["status"]) as? String ?? ""
             let message  = DataManager.getVal(responseData?["message"]) as? String ?? ""
                print(message)
            
             if status == "1" {
                print(DataManager.getVal(responseData?["data"]) as? [String:Any] ?? [:])
                self.ApiDataArr = DataManager.getVal(responseData?["data"]) as? NSMutableArray ?? []
              
             }
             else {
                print(message)
             }
            self.meetUpInvitationTableView.reloadData()
            basicFunctions.stopLoading()
        }
    }
    //MARK:- goingSelection
    @objc func goingSelection(_ sender : UIButton){
        print("goingSelected")
 
        let dict = ApiDataArr[sender.tag] as? NSMutableDictionary ?? [:]
        api_updateStatus(id: "1", meetupId: DataManager.getVal(dict["mini_tribe_id"]) as? String ?? "", miniTribeId: DataManager.getVal(dict["mini_tribe_meetup_id"]) as? String ?? "")
    }
    //MARK:- NotSureSelection
    
    @objc func NotSureSelection(_ sender : UIButton){
        print("NotSureSelected")
        let dict = ApiDataArr[sender.tag] as? NSMutableDictionary ?? [:]
        api_updateStatus(id: "3", meetupId: DataManager.getVal(dict["mini_tribe_id"]) as? String ?? "", miniTribeId: DataManager.getVal(dict["mini_tribe_meetup_id"]) as? String ?? "")
    }
    
    //MARK:- NotGoingSelection
    
    @objc func NotGoingSelection(_ sender : UIButton){
        print("NotGoingSelected")
        let dict = ApiDataArr[sender.tag] as? NSMutableDictionary ?? [:]
        api_updateStatus(id: "2", meetupId: DataManager.getVal(dict["mini_tribe_id"]) as? String ?? "", miniTribeId: DataManager.getVal(dict["mini_tribe_meetup_id"]) as? String ?? "")
    }
    
    
    func api_updateStatus(id:String, meetupId: String, miniTribeId : String){
        
        basicFunctions.presentLoader()
        self.view.endEditing(true)
        
        let paraDict = NSMutableDictionary()
        paraDict.setValue(Config().api_key, forKey: "api_key")
        paraDict.setValue(Config().AppUserDefaults.value(forKey:"user_id") as? String ?? "", forKey: "user_id")
        paraDict.setValue(miniTribeId, forKey: "mini_tribe_id")
        paraDict.setValue(meetupId, forKey: "mini_tribe_meetup_id")
        paraDict.setValue(id, forKey: "status")
        paraDict.setValue("meetup", forKey: "type")
 
        let methodName = "meetup_status_change"
        DataManager.getAPIResponse(paraDict , methodName: methodName, methodType: "POST"){(responseData,error)-> Void in
             let status  = DataManager.getVal(responseData?["status"]) as? String ?? ""
             let message  = DataManager.getVal(responseData?["message"]) as? String ?? ""
                print(message)
             if status == "1" {
                self.getdata()
             }
             else {
                print(message)
             }
            basicFunctions.stopLoading()
        }
    }
    
    
    
}
extension MeetUpInvitaionVC: UITableViewDelegate,UITableViewDataSource{
    //MARK:- tableViewDataSourceMethods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ApiDataArr.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MeetUpInvitaioncell", for: indexPath) as! MeetUpInvitaioncell
        cell.viewcornor.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        cell.viewcornor.layer.shadowOpacity = 0.5
        cell.viewcornor.layer.shadowOffset = .zero
        cell.viewcornor.layer.shadowRadius = 8
        cell.viewcornor.layer.cornerRadius = 10
        
        cell.btngoing.layer.cornerRadius = 5
        cell.btngoing.layer.borderWidth = 0.8
        cell.btngoing.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        cell.btnnotsure.layer.cornerRadius = 5
        cell.btnnotsure.layer.borderWidth = 0.8
        cell.btnnotsure.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        cell.btnnotgoing.layer.cornerRadius = 5
        cell.btnnotgoing.layer.borderWidth = 0.8
        cell.btnnotgoing.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
       
        
        let apidata = ApiDataArr[indexPath.row]
        ApiDict = apidata as? NSMutableDictionary ?? [:]
    
        cell.lbldate.text = self.ApiDict["meetup_date"] as? String ?? ""
        cell.lbltime.text = self.ApiDict["meetup_time"] as? String ?? ""
        cell.lbllocation.text = self.ApiDict["meetup_location"] as? String ?? ""
        cell.lblgoing.text = "\(self.ApiDict["meetup_going_members"] as? Int ?? 0) People Are Going"
        cell.lblnotgoing.text = "\(self.ApiDict["meetup_not_going_members"] as? Int ?? 0) People Are Not Going"
        cell.lblmightgoing.text = "\(self.ApiDict["meetup_might_go_members"] as? Int ?? 0) People Might Go"
        cell.lblcreate.text = "Created By \(self.ApiDict["user_name"] as? String ?? "")"
        cell.lblname.text = self.ApiDict["meetup_topic"] as? String ?? ""
        
        let meetupStatus = DataManager.getVal(self.ApiDict["meetup_status"]) as? String ?? ""
        
        if meetupStatus == "1"{
            cell.btngoing.backgroundColor = UIColor(red: 0.05, green: 0.23, blue: 0.66, alpha: 0.2)
            cell.btnnotsure.backgroundColor = UIColor.white
            cell.btnnotgoing.backgroundColor = UIColor.white
        }else if meetupStatus == "2"{
            cell.btngoing.backgroundColor = UIColor.white
            cell.btnnotsure.backgroundColor = UIColor.white
            cell.btnnotgoing.backgroundColor = UIColor(red: 0.05, green: 0.23, blue: 0.66, alpha: 0.2)
        }else if meetupStatus == "3"{
            cell.btngoing.backgroundColor = UIColor.white
            cell.btnnotsure.backgroundColor = UIColor(red: 0.05, green: 0.23, blue: 0.66, alpha: 0.2)
            cell.btnnotgoing.backgroundColor = UIColor.white
        }else{
            cell.btngoing.backgroundColor = UIColor.white
            cell.btnnotsure.backgroundColor = UIColor.white
            cell.btnnotgoing.backgroundColor = UIColor.white
        }
        
        cell.btngoing.tag = indexPath.row
        cell.btnnotgoing.tag = indexPath.row
        cell.btnnotsure.tag = indexPath.row
    
        cell.btngoing.addTarget(self, action: #selector(goingSelection(_:)), for: .touchUpInside)
        cell.btnnotsure.addTarget(self, action: #selector(NotSureSelection(_:)), for: .touchUpInside)
        cell.btnnotgoing.addTarget(self, action: #selector(NotGoingSelection(_:)), for: .touchUpInside)
        
        cell.imguser.sd_setImage(with: URL(string: "\(Config().baseImageUrl)\(DataManager.getVal(ApiDict["meetup_image"]) as? String ?? "")"), completed: nil)
        
        return cell
    }
    //MARK:- tableViewDelegateMethods
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
}
