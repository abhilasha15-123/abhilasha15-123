//
//  BlockListVC.swift
//  Soul Tribe
//
//  Created by Ashish Soni on 11/06/21.
//

import UIKit
class BlockListCell: UITableViewCell{
    @IBOutlet weak var imguser: UIImageView!
    @IBOutlet weak var lblname: UILabel!
    @IBOutlet weak var btnblock: UIButton!
}

class BlockListVC: UIViewController {
    @IBOutlet weak var searchview: UIView!
    @IBOutlet weak var headerview: UIView!
    @IBOutlet weak var tableview: UITableView!

    var blockID = Int()
    var blockedList = NSDictionary()
    var leftDrawerTransition:DrawerTransition!
    var left = LeftMenuViewController()
    override func viewDidLoad() {

        super.viewDidLoad()
        tableview.tableFooterView = UIView() 
        self.navigationController?.isNavigationBarHidden = true
        searchview.layer.cornerRadius = 6
        searchview.layer.borderWidth = 1
        searchview.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)

        headerview.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        headerview.layer.shadowOpacity = 0.5
        headerview.layer.shadowOffset = .zero
        headerview.layer.shadowRadius = 5
        getBlockedList()
        // Do any additional setup after loading the view.
    }
    
    func getBlockedList(){
         self.view.endEditing(true)

         let parameterDictionary = NSMutableDictionary()
      
        parameterDictionary.setValue("tribe123", forKey: "api_key")
        parameterDictionary.setValue("14", forKey: "user_id")
//        parameterDictionary.setValue("Tribe", forKey: "vibe")
//        parameterDictionary.setValue(SwipeUserId, forKey: "swipe_user_id")
//        parameterDictionary.setValue(type, forKey: "type")
        print(parameterDictionary)
         let methodName = "get_blocked_users_list"

         DataManager.getAPIResponse(parameterDictionary , methodName: methodName, methodType: "POST"){(responseData,error)-> Void in
             let status  = DataManager.getVal(responseData?["status"]) as? String ?? ""
             let message  = DataManager.getVal(responseData?["message"]) as? String ?? ""

             if status == "1" {
                 self.blockedList = DataManager.getVal(responseData?["data"]) as? NSDictionary ?? [:]
                 print(self.blockedList)
                 self.tableview.reloadData()
             }
             else {
//                 self.view.makeToast(message)
             }
         }
     }
    func unBlockUser_API(){
         self.view.endEditing(true)

         let parameterDictionary = NSMutableDictionary()
      
        parameterDictionary.setValue("tribe123", forKey: "api_key")
        parameterDictionary.setValue("14", forKey: "user_id")
        parameterDictionary.setValue(self.blockID, forKey: "blocked_id")

        print(parameterDictionary)
         let methodName = "unblock_user"

         DataManager.getAPIResponse(parameterDictionary , methodName: methodName, methodType: "POST"){(responseData,error)-> Void in
             let status  = DataManager.getVal(responseData?["status"]) as? String ?? ""
             let message  = DataManager.getVal(responseData?["message"]) as? String ?? ""

             if status == "1" {
                 self.tableview.reloadData()
             }
             else {
//                 self.view.makeToast(message)
             }
         }
     }
    @IBAction func backbtnaction(_ sender:UIButton) {
        self.slideMenuController()?.toggleLeft()
    }

    @IBAction func blockBtnAction(_ sender: Any) {
        unBlockUser_API()
    }
}

extension BlockListVC: UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        var numOfSections: Int = 0
        if self.blockedList.count>0
          {
            numOfSections = 1
            tableview.backgroundView = nil
             }
        else{
            let noDataLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: tableview.bounds.size.width, height: tableview.bounds.size.height))
            noDataLabel.text = "No data found"
            noDataLabel.textColor = UIColor.black
            noDataLabel.textAlignment = .center
            tableview.backgroundView  = noDataLabel
        }
        return numOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.blockedList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BlockListCell", for: indexPath) as! BlockListCell
        let dict = self.blockedList[indexPath.row] as? NSDictionary ?? [:]
        cell.lblname.text = dict.value(forKey: "name") as? String
        let userImage = dict.value(forKey: "profile_image") as? String ?? ""
        cell.imguser.sd_setImage(with: URL(string: Config().baseImageUrl + userImage), completed: nil)
        self.blockID = dict.value(forKey: "id") as! Int
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}
