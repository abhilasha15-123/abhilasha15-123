//
//  SignUpViewController.swift
//  Soul Tribe
//
//  Created by Ashish Soni on 04/06/21.
//

import UIKit

class SignUpViewController: UIViewController {
    @IBOutlet weak var fullnameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var MobileTxt: UITextField!
    @IBOutlet weak var PasswordTxt: UITextField!
    @IBOutlet weak var ConfirmPasswordTxt: UITextField!
    @IBOutlet weak var checkBtn: UIButton!
    @IBOutlet weak var fullname: UIView!
    @IBOutlet weak var emailview: UIView!
    @IBOutlet weak var mobileview: UIView!
    @IBOutlet weak var passwordview: UIView!
    @IBOutlet weak var confirmpasswordview: UIView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fullname.layer.cornerRadius = 7
        fullname.layer.borderWidth = 1.2
        fullname.layer.borderColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1.0).cgColor
        
        emailview.layer.cornerRadius = 7
        emailview.layer.borderWidth = 1.2
        emailview.layer.borderColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1.0).cgColor
        
        mobileview.layer.cornerRadius = 7
        mobileview.layer.borderWidth = 1.2
        mobileview.layer.borderColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1.0).cgColor
        
        passwordview.layer.cornerRadius = 7
        passwordview.layer.borderWidth = 1.2
        passwordview.layer.borderColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1.0).cgColor
        
        emailview.layer.cornerRadius = 7
        emailview.layer.borderWidth = 1.2
        emailview.layer.borderColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1.0).cgColor
        
        confirmpasswordview.layer.cornerRadius = 7
        confirmpasswordview.layer.borderWidth = 1.2
        confirmpasswordview.layer.borderColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1.0).cgColor

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func signInBtnAction(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(identifier: "LoginViewController") as! LoginViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func RegisterBtnAction(_ sender: Any) {
        self.view.endEditing(true)
        if ValidationClass().ValidateSignUpForm(self){
                 
            basicFunctions.presentLoader()
  
            let parameterDictionary = NSMutableDictionary()
                   
            parameterDictionary.setValue(fullnameTxt.text ?? "", forKey: "name")
            parameterDictionary.setValue(emailTxt.text ?? "", forKey: "email")
            parameterDictionary.setValue(MobileTxt.text ?? "", forKey: "mobile")
            parameterDictionary.setValue(PasswordTxt.text ?? "", forKey: "password")
            parameterDictionary.setValue(Config().api_key, forKey: "api_key")
    
            print(parameterDictionary)

            let methodName = "register"
               
            DataManager.getAPIResponse(parameterDictionary , methodName: methodName, methodType: "POST"){(responseData,error)-> Void in
                let status  = DataManager.getVal(responseData?["status"]) as? String ?? ""
                let message  = DataManager.getVal(responseData?["message"]) as? String ?? ""
              
                if status == "1" {
                   
                    let data = DataManager.getVal(responseData?["data"]) as? [String:Any] ?? [:]
                 
                    self.view.makeToast(message)
                            
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){

                        let vc = self.storyboard?.instantiateViewController(identifier: "VerficationViewController") as! VerficationViewController
                        vc.datatype = "1"
                        vc.userId = DataManager.getVal(data["id"]) as? String ?? ""
                        self.navigationController?.pushViewController(vc, animated: true)

                    }
                }else{
                    self.view.makeToast(message)
                }
                   
                basicFunctions.stopLoading()
             
            }
        }
    }
    
    @IBAction func facebookBtnAction(_ sender: Any) {
    }
    
    @IBAction func twitterBtnAction(_ sender: Any) {
    }
    
    @IBAction func googleBtnAction(_ sender: Any) {
    }
    
    @IBAction func termsConditionBtnAction(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(identifier: "WebVwViewController") as! WebVwViewController
        vc.urlStr = "https://soultribenow.com/terms"
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}
