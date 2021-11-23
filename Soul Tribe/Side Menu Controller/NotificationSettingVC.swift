//
//  NotificationSettingVC.swift
//  Soul Tribe
//
//  Created by Ashish Soni on 21/06/21.
//

import UIKit

class NotificationSettingVC: UIViewController {
    @IBOutlet weak var headerview: UIView!
    @IBOutlet weak var EmailSwitch: UISwitch!
    @IBOutlet weak var InAppSwitch: UISwitch!
    var emailStatus = String()
    var emailType = String()
    var leftDrawerTransition:DrawerTransition!
    var left = LeftMenuViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        headerview.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        headerview.layer.shadowOpacity = 0.5
        headerview.layer.shadowOffset = .zero
        headerview.layer.shadowRadius = 5
        
        let emailStatus = UserDefaults.standard.value(forKey: "emailNotificationStatus") as? String
        let InAppStatus = UserDefaults.standard.value(forKey: "InAppNotificationStatus") as? String
//        let emailType = UserDefaults.standard.value(forKey: "emailNotificationType") as? String
//        let InAppType = UserDefaults.standard.value(forKey: "InAppNotificationStatus") as? String
        if emailStatus == "1" {
            self.EmailSwitch.setOn(true, animated: true)
        }else{
            self.EmailSwitch.setOn(false, animated: true)
        }
        if InAppStatus == "1" {
            self.InAppSwitch.setOn(true, animated: true)
        }else{
            self.InAppSwitch.setOn(false, animated: true)
        }
        
    }
    @IBAction func EmailSwitchAction(_ sender: UISwitch) {
        if sender.isOn == true{
            print("on")
            self.emailStatus = "1"
            self.SendNotification(type: "email_notification", status: self.emailStatus)
        }else{
            print("off")
            self.emailStatus = "0"
            self.SendNotification(type: "email_notification", status: self.emailStatus)
        }
    }
    @IBAction func InAppSwitchAction(_ sender: UISwitch) {
        if sender.isOn == true{
            print("on")
            self.emailStatus = "1"
            self.SendNotification(type: "in_app_notification", status: self.emailStatus)
        }else{
            print("off")
            self.emailStatus = "0"
            self.SendNotification(type: "in_app_notification", status: self.emailStatus)
        }
    }
    func SendNotification(type: String, status: String) {
        self.view.endEditing(true)
        let userID = Config().AppUserDefaults.value(forKey:"user_id") as? String ?? ""
        let parameterDictionary = NSMutableDictionary()
     //   in_app_notification email_notification
       parameterDictionary.setValue("tribe123", forKey: "api_key")
       parameterDictionary.setValue(userID, forKey: "user_id")
        parameterDictionary.setValue(type, forKey: "type")
        parameterDictionary.setValue(status, forKey: "status")
       print(parameterDictionary)
        let methodName = "notification_status_update"

        DataManager.getAPIResponse(parameterDictionary , methodName: methodName, methodType: "POST"){(responseData,error)-> Void in
            let status  = DataManager.getVal(responseData?["status"]) as? String ?? ""
            let message  = DataManager.getVal(responseData?["message"]) as? String ?? ""

            if status == "1" {
                let data = DataManager.getVal(responseData?["data"]) as! NSDictionary
                let status = data.value(forKey: "status") as? String
                let type = data.value(forKey: "type") as? String
                if type == "email_notification" {
                    UserDefaults.standard.set(type, forKey: "emailNotificationType")
                    UserDefaults.standard.set(status, forKey: "emailNotificationStatus")
                }else{
                    UserDefaults.standard.set(type, forKey: "InAppNotificationType")
                    UserDefaults.standard.set(status, forKey: "InAppNotificationStatus")
                }
            }
            else {
//                 self.view.makeToast(message)
            }
        }
    }
    @IBAction func backbtnaction(_ sender:UIButton) {
        navigationController?.popViewController(animated: true)

    }
}
