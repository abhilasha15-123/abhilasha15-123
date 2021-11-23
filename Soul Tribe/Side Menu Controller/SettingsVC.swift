//
//  SettingsVC.swift
//  Soul Tribe
//
//  Created by Ashish Soni on 11/06/21.
//

import UIKit

class SettingsVC: UIViewController {
    @IBOutlet weak var Paswrdview: UIView!
    @IBOutlet weak var Emailview: UIView!
    @IBOutlet weak var PhoneNOview: UIView!
    @IBOutlet weak var headerview: UIView!
    @IBOutlet weak var PopUpMenuView: UIView!
    @IBOutlet weak var PopUpTextFieldView: UIView!
    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var popUpLabel: UILabel!
    @IBOutlet weak var popUpDoneBtn: UIButton!
    
    @IBOutlet weak var popCornerRadius: UIView!
    @IBOutlet weak var otherView: UIView!

    var leftDrawerTransition:DrawerTransition!
    var left = LeftMenuViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
//        self.PopUpMenuView.isHidden = true
        popCornerRadius.layer.cornerRadius = 8
        popUpDoneBtn.layer.cornerRadius = 8
        Paswrdview.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        Paswrdview.layer.shadowOpacity = 0.5
        Paswrdview.layer.shadowOffset = .zero
        Paswrdview.layer.shadowRadius = 5
        Paswrdview.layer.cornerRadius = 12
        
        Emailview.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        Emailview.layer.shadowOpacity = 0.5
        Emailview.layer.shadowOffset = .zero
        Emailview.layer.shadowRadius = 5
        Emailview.layer.cornerRadius = 12
       
        PhoneNOview.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        PhoneNOview.layer.shadowOpacity = 0.5
        PhoneNOview.layer.shadowOffset = .zero
        PhoneNOview.layer.shadowRadius = 5
        PhoneNOview.layer.cornerRadius = 12
      
        headerview.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        headerview.layer.shadowOpacity = 0.5
        headerview.layer.shadowOffset = .zero
        headerview.layer.shadowRadius = 5

        // Do any additional setup after loading the view.
    }
    
    @IBAction func otherBtnAction(_ sender:UIButton) {
        self.otherView.frame = self.view.frame
        self.otherView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        self.view.addSubview(self.otherView)
    }
    @IBAction func backbtnaction(_ sender:UIButton) {
        self.slideMenuController()?.toggleLeft()

    }

    @IBAction func btnpasword(_ sender:UIButton) {
        let vc = self.storyboard?.instantiateViewController(identifier: "ChangePasswordViewController") as! ChangePasswordViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func ChangeEmailIdBtnAction(_ sender:UIButton) {
        self.otherView.frame = self.view.frame
        self.otherView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        self.view.addSubview(self.otherView)
        self.EmailTextField.placeholder = "Email"
        self.popUpLabel.text = "Enter your updated email address to receive a verification code"
    }
    
    @IBAction func PhoneNumberVerifBtnAction(_ sender:UIButton) {
        self.otherView.frame = self.view.frame
        self.otherView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        self.view.addSubview(self.otherView)
        self.EmailTextField.placeholder = "Mobile"
        self.popUpLabel.text = "Enter your mobile number to verify your device. SMS fee may apply"
    }
    
    @IBAction func DoneEmailidAction(_ sender:UIButton) {
        let userID = Config().AppUserDefaults.value(forKey:"user_id") as? String ?? ""
        if self.EmailTextField.text == "" {
            self.view.makeToast("Please enter email")
            self.PopUpTextFieldView.layer.borderColor = UIColor.red.cgColor
        }else if self.EmailTextField.text!.count <= 6 {
            self.view.makeToast("Please enter valid email")
            self.PopUpTextFieldView.layer.borderColor = UIColor.red.cgColor
        }
        else{
            self.PopUpTextFieldView.layer.borderColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1.0).cgColor
            if self.EmailTextField.placeholder == "Email" {
                let parameterDictionary = NSMutableDictionary()
             
               parameterDictionary.setValue("tribe123", forKey: "api_key")
               parameterDictionary.setValue(userID, forKey: "user_id")
               parameterDictionary.setValue(self.EmailTextField.text, forKey: "email")

               print(parameterDictionary)
                let methodName = "send_email_verification_otp"

                DataManager.getAPIResponse(parameterDictionary , methodName: methodName, methodType: "POST"){(responseData,error)-> Void in
                    let status  = DataManager.getVal(responseData?["status"]) as? String ?? ""
                    let message  = DataManager.getVal(responseData?["message"]) as? String ?? ""

                    if status == "1" {
                        self.view.makeToast(message)
                        self.otherView.removeFromSuperview()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                            let vc = self.storyboard?.instantiateViewController(identifier: "VerficationViewController") as! VerficationViewController
                            vc.comeFromSetting = "1"
                            vc.comeFromSettingEmail_Phone = self.EmailTextField.text!
                            self.navigationController?.pushViewController(vc, animated: true)
                        }
                    }
                    else {
                        self.view.makeToast(message)
                    }
                }
            }else{
                let parameterDictionary = NSMutableDictionary()
                let userID = Config().AppUserDefaults.value(forKey:"user_id") as? String ?? ""
               parameterDictionary.setValue("tribe123", forKey: "api_key")
               parameterDictionary.setValue(userID, forKey: "user_id")
               parameterDictionary.setValue(self.EmailTextField.text, forKey: "mobile")

               print(parameterDictionary)
                let methodName = "send_phone_verification_otp"

                DataManager.getAPIResponse(parameterDictionary , methodName: methodName, methodType: "POST"){(responseData,error)-> Void in
                    let status  = DataManager.getVal(responseData?["status"]) as? String ?? ""
                    let message  = DataManager.getVal(responseData?["message"]) as? String ?? ""

                    if status == "1" {
                        self.view.makeToast(message)
                        self.otherView.removeFromSuperview()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                            let vc = self.storyboard?.instantiateViewController(identifier: "VerficationViewController") as! VerficationViewController
                            vc.comeFromSetting = "1"
                            vc.comeFromSettingEmail_Phone = self.EmailTextField.text ?? ""
                            self.navigationController?.pushViewController(vc, animated: true)
                        }
                    }
                    else {
                        self.view.makeToast(message)
                    }
                }
            }
        }
    }
    @IBAction func EmailPopUpCrossAction(_ sender:UIButton) {
        self.EmailTextField.text = ""
        self.otherView.removeFromSuperview()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
