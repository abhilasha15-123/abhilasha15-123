//
//  ForgotPasswordViewController.swift
//  Soul Tribe
//
//  Created by Ashish Soni on 04/06/21.
//

import UIKit

class ForgotPasswordViewController: UIViewController {

    @IBOutlet weak var ForgotTxtView: UIView!
    var type:String!
    @IBOutlet weak var ForgotTxt: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ForgotTxtView.layer.cornerRadius = 7
        ForgotTxtView.layer.borderWidth = 1.2
        ForgotTxtView.layer.borderColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0).cgColor
       
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backBtnAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func subnitBtnAction(_ sender: Any) {
        
        if ForgotTxt.text != "" {
            ForgotTxtView.layer.borderColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0).cgColor
           
            self.view.endEditing(true)
            basicFunctions.presentLoader()
      
            let parameterDictionary = NSMutableDictionary()

            parameterDictionary.setValue(ForgotTxt.text ?? "", forKey: "email")
            parameterDictionary.setValue(Config().api_key, forKey: "api_key")
        
            print(parameterDictionary)

            let methodName = "forgot_password"
                   
            DataManager.getAPIResponse(parameterDictionary , methodName: methodName, methodType: "POST"){(responseData,error)-> Void in
                    let status  = DataManager.getVal(responseData?["status"]) as? String ?? ""
                    let message  = DataManager.getVal(responseData?["message"]) as? String ?? ""
                  
                    if status == "1" {
                       
                        let data = DataManager.getVal(responseData?["data"]) as? [String:Any] ?? [:]
                        
                        self.view.makeToast(message)
                                
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
                            let vc = self.storyboard?.instantiateViewController(identifier: "VerficationViewController") as! VerficationViewController
                            vc.datatype = "2"
                            vc.userId = DataManager.getVal(data["id"]) as? String ?? ""
                            self.navigationController?.pushViewController(vc, animated: true)
                        }
                    }else{
                        self.view.makeToast(message)
                    }
                       
                    basicFunctions.stopLoading()
                 
                }
        }else{
            self.view.makeToast("Please enter registered email id or phone number.")
            ForgotTxtView.layer.borderColor = UIColor.red.cgColor
        }
        
       
    }

}
