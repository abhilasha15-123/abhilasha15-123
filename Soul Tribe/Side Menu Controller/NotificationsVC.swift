//
//  NotificationsVC.swift
//  Soul Tribe
//
//  Created by Ashish Soni on 11/06/21.
//

import UIKit

class NotificationsCell: UITableViewCell{
    @IBOutlet weak var btnstatus: UIButton!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var messageLbl: UILabel!
    @IBOutlet weak var img: UIImageView!
}
class NotificationsVC: UIViewController {
    var leftDrawerTransition:DrawerTransition!
    var left = LeftMenuViewController()
    @IBOutlet weak var headerview: UIView!
    @IBOutlet weak var notificationTableView: UITableView!

    var notificationArray = [NSDictionary]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        // Do any additional setup after loading the view.
        headerview.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        headerview.layer.shadowOpacity = 0.5
        headerview.layer.shadowOffset = .zero
        headerview.layer.shadowRadius = 5

        getNotificationVC()
    }
    
    func getNotificationVC() {
        self.view.endEditing(true)
        let parameterDictionary = NSMutableDictionary()
     
       parameterDictionary.setValue("tribe123", forKey: "api_key")
       parameterDictionary.setValue("14", forKey: "user_id")
       print(parameterDictionary)
        let methodName = "get_notifications_list"

        DataManager.getAPIResponse(parameterDictionary , methodName: methodName, methodType: "POST"){(responseData,error)-> Void in
            let status  = DataManager.getVal(responseData?["status"]) as? String ?? ""
            let message  = DataManager.getVal(responseData?["message"]) as? String ?? ""

            if status == "1" {
                self.notificationArray = DataManager.getVal(responseData?["data"]) as! [NSDictionary]
                self.notificationTableView.reloadData()
                
            }
            else {
//                 self.view.makeToast(message)
            }
        }
    }
    
    @IBAction func backbtnaction(_ sender:UIButton) {
        navigationController?.popViewController(animated: true)
        
        //self.slideMenuController()?.toggleLeft()
    }
    
    @IBAction func btngosetting(_ sender:UIButton) {
        let vc = self.storyboard?.instantiateViewController(identifier: "NotificationSettingVC") as! NotificationSettingVC
        navigationController?.pushViewController(vc, animated: true)
        
    }
}
extension NotificationsVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.notificationArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationsCell", for: indexPath) as! NotificationsCell
        cell.btnstatus.layer.cornerRadius = 3
        var dict = NSDictionary()
        dict = self.notificationArray[indexPath.row]
        cell.dateLbl.text = dict.value(forKey: "date") as? String
        cell.messageLbl.text = dict.value(forKey: "message") as? String
        cell.nameLbl.text = dict.value(forKey: "sender_name") as? String
        return cell
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
         return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            // handle delete (by removing the data from your array and updating the tableview)
        }
    }
    
}
