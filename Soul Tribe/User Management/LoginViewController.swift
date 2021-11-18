//
//  LoginViewController.swift
//  Soul Tribe
//
//  Created by Ashish Soni on 04/06/21.
//

import UIKit
import KeychainSwift

class LoginViewController: UIViewController {
   
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var checkBtn: UIButton!
    @IBOutlet weak var emailview: UIView!
    @IBOutlet weak var passwordview: UIView!
    
    @IBAction func checkbtnAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    let keychain = KeychainSwift()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true

        emailview.layer.cornerRadius = 7
        emailview.layer.borderWidth = 1.2
        emailview.layer.borderColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1.0).cgColor
        
        passwordview.layer.cornerRadius = 7
        passwordview.layer.borderWidth = 1.2
        passwordview.layer.borderColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0).cgColor
       
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if DataManager.getVal(self.keychain.get("email_A")) as? String ?? "" != "" {
            emailTxt.text = (DataManager.getVal(self.keychain.get("email_A")) as? String ?? "")
            passwordTxt.text = (DataManager.getVal(self.keychain.get("password_A")) as? String ?? "")
            checkBtn.isSelected = true
        } else {
            passwordTxt.text = ""
            emailTxt.text = ""
            checkBtn.isSelected = false
        }
    }
    
    
    @IBAction func forgotPasswordBtnAction(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(identifier: "ForgotPasswordViewController") as! ForgotPasswordViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func signInBtnAction(_ sender: Any) {

        self.view.endEditing(true)
        
        if ValidationClass().ValidateLoginForm(self){
            basicFunctions.presentLoader()
      
            let parameterDictionary = NSMutableDictionary()

            parameterDictionary.setValue(emailTxt.text ?? "", forKey: "email")
            parameterDictionary.setValue(passwordTxt.text ?? "", forKey: "password")
            parameterDictionary.setValue(Config().api_key, forKey: "api_key")
        
            print(parameterDictionary)

            let methodName = "login"
                   
            DataManager.getAPIResponse(parameterDictionary , methodName: methodName, methodType: "POST"){(responseData,error)-> Void in
                let status  = DataManager.getVal(responseData?["status"]) as? String ?? ""
                let message  = DataManager.getVal(responseData?["message"]) as? String ?? ""
                  
                if status == "1" {
                       
                    let data = DataManager.getVal(responseData?["data"]) as? [String:Any] ?? [:]
                    let screen_val = DataManager.getVal(data["app_screen"]) as? String ?? ""
                        
                        
                    self.view.makeToast(message)
                        
                    Config().AppUserDefaults.setValue(DataManager.getVal(data["id"]) as? String ?? "", forKey: "user_id")
                        
                    if self.checkBtn.isSelected == true {
                        self.keychain.set(self.passwordTxt.text ?? "", forKey: "password_A")
                        self.keychain.set(self.emailTxt.text ?? "", forKey: "email_A")
                    }else {
                        if (DataManager.getVal(Config().AppUserDefaults.value(forKey: "email_A")) as! String) != "" {
                                
                            self.keychain.delete("email_A")
                            self.keychain.delete("password_A")
                        }
                    }
                        
                        
                    if screen_val == "0"{
                        let vc = self.storyboard?.instantiateViewController(identifier: "LocationAccessVC") as! LocationAccessVC
                        self.navigationController?.pushViewController(vc, animated: true)
                    }else if screen_val == "1"{
                        let vc = self.storyboard?.instantiateViewController(identifier: "SetprofileVC") as! SetprofileVC
                        self.navigationController?.pushViewController(vc, animated: true)
                    }else if screen_val == "2"{
                        let vc = self.storyboard?.instantiateViewController(identifier: "SetProfilestep2VC") as! SetProfilestep2VC
                        self.navigationController?.pushViewController(vc, animated: true)
                    }else if screen_val == "3"{
                        let arr = (DataManager.getVal(data["vibe"]) as? String ?? "").components(separatedBy: ",")
                            
                        if arr.contains("Soul Love") || arr.contains("Tribe"){
                            let vc = self.storyboard?.instantiateViewController(identifier: "SetProfilestep3VC") as! SetProfilestep3VC
                            vc.vibe = DataManager.getVal(data["vibe"]) as? String ?? ""
                            self.navigationController?.pushViewController(vc, animated: true)
                        }
                        else{
                            let vc = self.storyboard?.instantiateViewController(identifier: "SetProfilefinalVC") as! SetProfilefinalVC
                            self.navigationController?.pushViewController(vc, animated: true)
                        }
                    }else if screen_val == "4"{
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            let navigate = storyboard.instantiateViewController(withIdentifier: "TTabBarViewController") as! TTabBarViewController
                            let leftController = storyboard.instantiateViewController(withIdentifier: "LeftMenuViewController") as! LeftMenuViewController
                            let slideMenuController = SlideMenuController(mainViewController: UINavigationController(rootViewController:navigate), leftMenuViewController: leftController)
                            slideMenuController.delegate = leftController as? SlideMenuControllerDelegate
                            UIApplication.shared.windows.first?.rootViewController = slideMenuController
                            UIApplication.shared.windows.first?.makeKeyAndVisible()
                        }
                    }
                }
                else if status == "2"{
                    let data = DataManager.getVal(responseData?["data"]) as? [String:Any] ?? [:]
    
                    self.view.makeToast(message)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
                        let vc = self.storyboard?.instantiateViewController(identifier: "VerficationViewController") as! VerficationViewController
                        vc.datatype = "1"
                        vc.userId = DataManager.getVal(data["id"]) as? String ?? ""
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                }
                else if status == "0"{
                    if message == "Invalid email" {
                        self.emailTxt.layer.borderColor = UIColor.red.cgColor
                    }
                    else if message == "Invalid password"{
                        self.passwordTxt.layer.borderColor = UIColor.red.cgColor
                    }
                }
                else{
                    self.view.makeToast(message)
                }
                basicFunctions.stopLoading()
            }
        }
    }

    @IBAction func facebookBtnAction(_ sender: Any) {
        
    }
    
    @IBAction func twitterBtnAction(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(identifier: "TribefullDeatilsVC") as! TribefullDeatilsVC
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func googleBtnAction(_ sender: Any) {
    }
    
    @IBAction func signUpBtnAction(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(identifier: "SignUpViewController") as! SignUpViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
   

}
