//
//  VerficationViewController.swift
//  Soul Tribe
//
//  Created by Ashish Soni on 04/06/21.
//

import UIKit

class VerficationViewController: UIViewController,VPMOTPViewDelegate {

    @IBOutlet weak var otpView: VPMOTPView!
    var GetotpString = ""
    var GetComeOtp = String()
   
    var datatype : String = ""
    var userId = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GetComeOtp = "00000"
      
        otpView.otpFieldsCount = 4
                otpView.otpFieldDefaultBorderColor = UIColor.lightGray
               
              
        otpView.otpFieldBorderWidth = 0.6
                otpView.delegate = self
                otpView.shouldAllowIntermediateEditing = false
                
                // Create the UI
                otpView.initalizeUI()
        // Do any additional setup after loading the view.
    }
    
    
    //MARK:- OTP TextView Delegate  ---- Start
    func shouldBecomeFirstResponderForOTP(otpFieldIndex index: Int) -> Bool {
        return true
    }
    
    func hasEnteredAllOTP(hasEntered: Bool) {
        print("Has entered all OTP? \(hasEntered)")
    }
    
    func enteredOTP(otpString: String) {
        GetotpString = otpString
        print("OTPString: \(otpString)")
    }
    
    @IBAction func backBtnAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func submitBtnAction(_ sender: Any) {
      
        if GetotpString != "" {
            
                self.view.endEditing(true)
                basicFunctions.presentLoader()
          
                let parameterDictionary = NSMutableDictionary()

                parameterDictionary.setValue(userId, forKey: "user_id")
                parameterDictionary.setValue(GetotpString, forKey: "otp")
                parameterDictionary.setValue(datatype, forKey: "type")
                parameterDictionary.setValue(Config().api_key, forKey: "api_key")
            
                print(parameterDictionary)

                let methodName = "otp_verification"
                       
                DataManager.getAPIResponse(parameterDictionary , methodName: methodName, methodType: "POST"){(responseData,error)-> Void in
                        let status  = DataManager.getVal(responseData?["status"]) as? String ?? ""
                        let message  = DataManager.getVal(responseData?["message"]) as? String ?? ""
                      
                        if status == "1" {
                           
                            self.view.makeToast(message)
                                    
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){

                                if self.datatype == "1"{
                                    let vc = self.storyboard?.instantiateViewController(identifier: "LocationAccessVC") as! LocationAccessVC
                                    self.navigationController?.pushViewController(vc, animated: true)
                                }else{
                                    let vc = self.storyboard?.instantiateViewController(identifier: "ResetPasswordViewController") as! ResetPasswordViewController
                                    vc.userId = self.userId
                                    self.navigationController?.pushViewController(vc, animated: true)
                                }
                                
                              
                                
        //                        let vc = self.storyboard?.instantiateViewController(identifier: "VerificationViewController") as! VerificationViewController
        //                        vc.viewComesFrom = "SignUp"
        //                        vc.email = userEmail
        //                        vc.phone = userPhone
        //                        self.navigationController?.pushViewController(vc, animated: true)
                            }
                        }else{
                            self.view.makeToast(message)
                        }
                           
                        basicFunctions.stopLoading()
                     
                    }
             
        }else{
            self.view.makeToast("Please enter OTP.")
        }
        
       
    }
    @IBAction func resendBtnAction(_ sender: Any) {
            
        
              self.view.endEditing(true)
              basicFunctions.presentLoader()
        
              let parameterDictionary = NSMutableDictionary()

              parameterDictionary.setValue(userId, forKey: "user_id")
              parameterDictionary.setValue(GetotpString, forKey: "otp")
              parameterDictionary.setValue(datatype, forKey: "type")
              parameterDictionary.setValue(Config().api_key, forKey: "api_key")
          
              print(parameterDictionary)

              let methodName = "resend_otp"
                     
              DataManager.getAPIResponse(parameterDictionary , methodName: methodName, methodType: "POST"){(responseData,error)-> Void in
                      let status  = DataManager.getVal(responseData?["status"]) as? String ?? ""
                      let message  = DataManager.getVal(responseData?["message"]) as? String ?? ""
                    
                      if status == "1" {
                         
                          self.view.makeToast(message)
                                  
//                          DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
//
//                              if self.datatype == "1"{
//                                  let vc = self.storyboard?.instantiateViewController(identifier: "LocationAccessVC") as! LocationAccessVC
//                                  self.navigationController?.pushViewController(vc, animated: true)
//                              }else{
//                                  let vc = self.storyboard?.instantiateViewController(identifier: "ResetPasswordViewController") as! ResetPasswordViewController
//                                  self.navigationController?.pushViewController(vc, animated: true)
//                              }
//
//
//
//      //                        let vc = self.storyboard?.instantiateViewController(identifier: "VerificationViewController") as! VerificationViewController
//      //                        vc.viewComesFrom = "SignUp"
//      //                        vc.email = userEmail
//      //                        vc.phone = userPhone
//      //                        self.navigationController?.pushViewController(vc, animated: true)
//                          }
                      }else{
                          self.view.makeToast(message)
                      }
                         
                      basicFunctions.stopLoading()
                   
                  }
        
//
//        let vc = self.storyboard?.instantiateViewController(identifier: "ResetPasswordViewController") as! ResetPasswordViewController
//        self.navigationController?.pushViewController(vc, animated: true)
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
