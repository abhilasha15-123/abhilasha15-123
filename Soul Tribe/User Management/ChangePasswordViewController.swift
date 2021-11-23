//
//  ChangePasswordViewController.swift
//  Soul Tribe
//
//  Created by Ashish Soni on 04/06/21.
//

import UIKit

class ChangePasswordViewController: UIViewController {
    @IBOutlet weak var headerview: UIView!

    @IBOutlet weak var oldpassView: UIView!
    @IBOutlet weak var newpassView: UIView!
    @IBOutlet weak var confirmpassView: UIView!
    @IBOutlet weak var oldPassTxt: UITextField!
    @IBOutlet weak var newpassTxt: UITextField!
    @IBOutlet weak var confirmpassTxt: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        oldpassView.layer.cornerRadius = 7
        oldpassView.layer.borderWidth = 1.2
        oldpassView.layer.borderColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0).cgColor
        
        newpassView.layer.cornerRadius = 7
        newpassView.layer.borderWidth = 1.2
        newpassView.layer.borderColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0).cgColor
        
        confirmpassView.layer.cornerRadius = 7
        confirmpassView.layer.borderWidth = 1.2
        confirmpassView.layer.borderColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0).cgColor
        
        headerview.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        headerview.layer.shadowOpacity = 0.8
        headerview.layer.shadowOffset = .zero
        headerview.layer.shadowRadius = 7

    }
    
    func changePasswordAPI(){
         self.view.endEditing(true)

         let parameterDictionary = NSMutableDictionary()
        let userID = Config().AppUserDefaults.value(forKey:"user_id") as? String ?? ""
        parameterDictionary.setValue("tribe123", forKey: "api_key")
        parameterDictionary.setValue(userID, forKey: "user_id")
        parameterDictionary.setValue(self.oldPassTxt.text, forKey: "old_password")
        parameterDictionary.setValue(self.newpassTxt.text, forKey: "new_password")

        print(parameterDictionary)
         let methodName = "change_password"

         DataManager.getAPIResponse(parameterDictionary , methodName: methodName, methodType: "POST"){(responseData,error)-> Void in
             let status  = DataManager.getVal(responseData?["status"]) as? String ?? ""
             let message  = DataManager.getVal(responseData?["message"]) as? String ?? ""

             if status == "1" {
                 self.view.makeToast(message)
                 DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                     self.navigationController?.popViewController(animated: true)
                 }
                 
             }
             else {
                 self.view.makeToast(message)
             }
         }
     }
    
    @IBAction func backBtnAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func submitBtnAction(_ sender: Any) {
        
        if ValidationClass().ValidationChangePasswordForm(self) {
            changePasswordAPI()
        }
    }
   
}
