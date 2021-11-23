//
//  ReportPopUpVC.swift
//  Soul Tribe
//
//  Created by Ashish Soni on 29/06/21.
//

import UIKit

class ReportPopUpVC: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate,UITextViewDelegate {

    @IBOutlet weak var headerview: UIView!
    @IBOutlet weak var profileview: UIView!
    @IBOutlet weak var reasonview: UIView!
    @IBOutlet weak var commentTxtview: UITextView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userNmae: UILabel!
    @IBOutlet weak var userAddress: UILabel!
    @IBOutlet weak var reasonTextFld: UITextField!
    
    var productPickerView:UIPickerView = UIPickerView()
    var optionNameArray = [String]()
    var optionIdArray = [Int]()
    var optionDict = NSMutableArray()
    var getUserName = String()
    var GetAddress = String()
    var GetSwipeUserID = Int()
    var reportReasonId = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.reasonTextFld.delegate = self
        reasonTextFld.inputView = productPickerView
        productPickerView.delegate = self
        productPickerView.dataSource = self
        self.userNmae.text = getUserName
        self.userAddress.text = GetAddress
        
        headerview.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        headerview.layer.shadowOpacity = 0.5
        headerview.layer.shadowOffset = .zero
        headerview.layer.shadowRadius = 5

        profileview.layer.cornerRadius = 5
        
        reasonview.layer.cornerRadius = 5
        reasonview.layer.borderWidth = 1
        reasonview.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)

        commentTxtview.layer.cornerRadius = 5
        commentTxtview.layer.borderWidth = 1
        commentTxtview.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        
        backBtn.layer.cornerRadius = 5
        backBtn.layer.borderWidth = 1
        backBtn.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        submitBtn.layer.cornerRadius = 5
        submitBtn.layer.borderWidth = 1
        submitBtn.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        // Do any additional setup after loading the view.
        reportReasonApi()
        commentTxtview.text = "Write your comment here (Optional)"
        commentTxtview.textColor = UIColor.lightGray
        commentTxtview.delegate = self
    }
    
    func reportReasonApi() {
        let tempVw = KolView()
        tempVw.menuoptionView.isHidden = true
        let parameterDictionary = NSMutableDictionary()
     
       parameterDictionary.setValue("tribe123", forKey: "api_key")

       print(parameterDictionary)
        let methodName = "get_report_reason"

        DataManager.getAPIResponse(parameterDictionary , methodName: methodName, methodType: "POST"){(responseData,error)-> Void in
            let status  = DataManager.getVal(responseData?["status"]) as? String ?? ""
            let message  = DataManager.getVal(responseData?["message"]) as? String ?? ""

            if status == "1" {
                self.optionDict = DataManager.getVal(responseData?["data"]) as! NSMutableArray
                print(self.optionDict[0])
                for i in 0..<self.optionDict.count{
                    var dict = NSDictionary()
                    dict = self.optionDict.object(at: i) as! NSDictionary
                    let name = dict.value(forKey: "name") as? String
                    let id = dict.value(forKey: "id") as? Int
                    self.optionNameArray.append(name!)
                    self.optionIdArray.append(id!)
                }
                print(self.optionIdArray)
                print(self.optionNameArray)
            }
            else {
//                 self.view.makeToast(message)
            }
        }
    }

    func reportApi() {
        
        let userID = Config().AppUserDefaults.value(forKey:"user_id") as? String ?? ""
        let parameterDictionary = NSMutableDictionary()
        
        if self.commentTxtview.textColor == UIColor.lightGray {
            parameterDictionary.setValue("", forKey: "comment")
        }else{
            parameterDictionary.setValue(self.commentTxtview.text, forKey: "comment")
        }
       parameterDictionary.setValue("tribe123", forKey: "api_key")
       parameterDictionary.setValue(userID, forKey: "user_id")
       parameterDictionary.setValue("Tribe", forKey: "vibe")
       parameterDictionary.setValue(self.reportReasonId, forKey: "report_reason_id")
        
       print(parameterDictionary)
        let methodName = "user_report"

        DataManager.getAPIResponse(parameterDictionary , methodName: methodName, methodType: "POST"){(responseData,error)-> Void in
            let status  = DataManager.getVal(responseData?["status"]) as? String ?? ""
            let message  = DataManager.getVal(responseData?["message"]) as? String ?? ""

            if status == "1" {
                self.view.makeToast(message)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    self.navigationController?.popViewController(animated: true)
                }
            }
            else {
//                 self.view.makeToast(message)
            }
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Write your comment here (Optional)" {
            textView.text = ""
        }
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            self.commentTxtview.textColor = UIColor.black
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.count == 0 {
            textView.text = " Write your comment here (Optional)"
            textView.textColor = UIColor.lightGray
        }
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return optionNameArray.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return optionNameArray[row] as? String
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        if optionNameArray.count>0 {
            self.reasonTextFld.text = optionNameArray[row] as? String
            self.reportReasonId = optionIdArray[row] as? Int ?? 0
        }else{
        }
    }
    
    
    
    @IBAction func submitBtnAction(_ sender: Any) {
        
        if self.reasonTextFld.text == "" {
            self.view.makeToast("Please select reason type")
        }else{
            reportApi()
        }
    }
    
    @IBAction func backBtnAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)

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
