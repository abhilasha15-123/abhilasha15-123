//
//  ResetPasswordViewController.swift
//  Soul Tribe
//
//  Created by Ashish Soni on 04/06/21.
//

import UIKit

class ResetPasswordViewController: UIViewController {

    @IBOutlet weak var newPassView: UIView!
    @IBOutlet weak var ReNewPassView: UIView!
    @IBOutlet weak var enternewpasaTxt: UITextField!
    @IBOutlet weak var reenterpassTxt: UITextField!
    
    
    var userId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        newPassView.layer.cornerRadius = 7
        newPassView.layer.borderWidth = 1.2
        newPassView.layer.borderColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0).cgColor
        
        ReNewPassView.layer.cornerRadius = 7
        ReNewPassView.layer.borderWidth = 1.2
        ReNewPassView.layer.borderColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0).cgColor
       
        // Do any additional setup after loading the view.
    }
    
  
    @IBAction func backBtnAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func submitBtnAction(_ sender: Any) {
        
        if ValidationClass().ValidateResetPasswordForm(self){
            
            basicFunctions.presentLoader()

            let parameterDictionary = NSMutableDictionary()
            parameterDictionary.setValue(userId, forKey: "user_id")
            parameterDictionary.setValue(reenterpassTxt.text ?? "", forKey: "new_password")
            parameterDictionary.setValue(Config().api_key, forKey: "api_key")
            print(parameterDictionary)

            let methodName = "reset_password"

            DataManager.getAPIResponse(parameterDictionary , methodName: methodName, methodType: "POST"){(responseData,error)-> Void in
                let status  = DataManager.getVal(responseData?["status"]) as! String
                let message  = DataManager.getVal(responseData?["message"]) as! String

                if status == "1" {
                    self.view.makeToast(message)

                    DispatchQueue.main.asyncAfter(deadline: .now()+1.5, execute: {
                        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
                        self.navigationController!.popToViewController(viewControllers[viewControllers.count - 4], animated: true)
                    })
                }
                else {
                    self.view.makeToast(message, duration: 2.0, position: .bottom, title: nil, image: nil, style: ToastManager.shared.style, completion: nil)
                }
//                self.removeSpinner()
                basicFunctions.stopLoading()
            }
        }
    }
}
