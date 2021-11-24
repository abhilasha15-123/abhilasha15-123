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
                self.meetUpInvitationTableView.reloadData()
                
             }
             else {
                print(message)
             }
    }
    }
    //MARK:- goingSelection
    @objc func goingSelection(){
        print("goingSelected")
    }
    //MARK:- NotSureSelection
    
    @objc func NotSureSelection(){
        print("NotSureSelected")
    }
    
    //MARK:- NotGoingSelection
    
    @objc func NotGoingSelection(){
        print("NotGoingSelected")
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
        cell.lblmightgoing.text = "\(self.ApiDict["meetup_might_go_members"] as? Int ?? 0) Might Go"
        cell.lblcreate.text = "Created By \(self.ApiDict["user_name"] as? String ?? "")"
        cell.btngoing.addTarget(self, action: #selector(goingSelection), for: .touchUpInside)
        cell.btnnotsure.addTarget(self, action: #selector(NotSureSelection), for: .touchUpInside)
        cell.btnnotgoing.addTarget(self, action: #selector(NotGoingSelection), for: .touchUpInside)
        
        return cell
    }
    //MARK:- tableViewDelegateMethods
    
    
}
