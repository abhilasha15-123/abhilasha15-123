//
//  SetProfilefinalVC.swift
//  DemoNew
//
//  Created by mac-9 on 02/07/21.
//

import UIKit

class SetProfilefinalVC: UIViewController {
    
    @IBOutlet weak var minitribesex1: UIView!
    @IBOutlet weak var minitribesex2: UIView!
    @IBOutlet weak var minitribesex3: UIView!
    @IBOutlet weak var minitribesex4: UIView!
    @IBOutlet weak var minitribesex5: UIView!
    @IBOutlet weak var minitribesex6: UIView!
    @IBOutlet weak var minitribesex7: UIView!
    
    @IBOutlet weak var minitribereletion1: UIView!
    @IBOutlet weak var minitribereletion2: UIView!
    @IBOutlet weak var minitribereletion3: UIView!
    @IBOutlet weak var btnsave: UIButton!
    @IBOutlet weak var headerview: UIView!
    @IBOutlet weak var btnchk1: UIButton!
    @IBOutlet weak var btnchk2: UIButton!
    @IBOutlet weak var btnchk3: UIButton!
    @IBOutlet weak var btnchk4: UIButton!
    @IBOutlet weak var btnchk5: UIButton!
    @IBOutlet weak var btnchk6: UIButton!
    @IBOutlet weak var btnchk7: UIButton!
    @IBOutlet weak var btnchk8: UIButton!
    @IBOutlet weak var btnchk9: UIButton!
    @IBOutlet weak var btnchk10: UIButton!

    var vibe = ""
    
    var arr_my_sexuality : NSMutableArray = []
    var arr_my_relationshipStatus : NSMutableArray = []
    var arr_soul_gender : NSMutableArray = []
    var arr_soul_sexuality : NSMutableArray = []
    var arr_soul_relationshipGoal : NSMutableArray = []
    
    var arr_tribe_gender : NSMutableArray = []
    var arr_tribe_sexuality : NSMutableArray = []
    
    
    var arr_mini_tribe_relationshipStatus : NSMutableArray = []
    var arr_mini_tribe_sexuality : NSMutableArray = []
    
    
    var q1Soul = ""
    var q1Tribe = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerview.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        headerview.layer.shadowOpacity = 0.5
        headerview.layer.shadowOffset = .zero
        headerview.layer.shadowRadius = 5
       
        minitribesex1.layer.cornerRadius = 5
        minitribesex1.layer.borderWidth = 1
        minitribesex1.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        minitribesex2.layer.cornerRadius = 5
        minitribesex2.layer.borderWidth = 1
        minitribesex2.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        minitribesex3.layer.cornerRadius = 5
        minitribesex3.layer.borderWidth = 1
        minitribesex3.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        minitribesex4.layer.cornerRadius = 5
        minitribesex4.layer.borderWidth = 1
        minitribesex4.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        minitribesex5.layer.cornerRadius = 5
        minitribesex5.layer.borderWidth = 1
        minitribesex5.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        minitribesex6.layer.cornerRadius = 5
        minitribesex6.layer.borderWidth = 1
        minitribesex6.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        minitribesex7.layer.cornerRadius = 5
        minitribesex7.layer.borderWidth = 1
        minitribesex7.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        minitribereletion1.layer.cornerRadius = 5
        minitribereletion1.layer.borderWidth = 1
        minitribereletion1.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        minitribereletion2.layer.cornerRadius = 5
        minitribereletion2.layer.borderWidth = 1
        minitribereletion2.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        minitribereletion3.layer.cornerRadius = 5
        minitribereletion3.layer.borderWidth = 1
        minitribereletion3.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        btnsave.layer.cornerRadius = 5
        btnsave.layer.borderWidth = 1
        btnsave.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        // Do any additional setup after loading the view.
    }
    @IBAction func btnback(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnsave(_ sender: Any) {
        if ValidationClass().ValidateProfileSetup4Form(self){
            
            basicFunctions.presentLoader()

            let parameterDictionary = NSMutableDictionary()
            parameterDictionary.setValue(Config().AppUserDefaults.value(forKey:"user_id") as? String ?? "", forKey: "user_id")
            parameterDictionary.setValue(Config().api_key, forKey: "api_key")
            
            parameterDictionary.setValue(arr_my_sexuality.componentsJoined(by:","), forKey: "soul_love_my_sexuality")
            parameterDictionary.setValue(arr_my_relationshipStatus.componentsJoined(by:","), forKey: "soul_love_my_relationship_status")
            parameterDictionary.setValue(arr_soul_gender.componentsJoined(by:","), forKey: "soul_love_my_prefer_gender")
            parameterDictionary.setValue(arr_soul_sexuality.componentsJoined(by:","), forKey: "soul_love_my_prefer_sexuality")
            parameterDictionary.setValue(arr_soul_relationshipGoal.componentsJoined(by:","), forKey: "relationship_looking_for_soul_love")
            parameterDictionary.setValue(q1Soul, forKey: "soul_love_QA")
            parameterDictionary.setValue(arr_tribe_gender.componentsJoined(by:","), forKey: "tribe_gender")
            parameterDictionary.setValue(arr_tribe_sexuality.componentsJoined(by:","), forKey: "tribe_sexuality")
            
            parameterDictionary.setValue(q1Tribe, forKey: "tribe_QA")
            parameterDictionary.setValue(arr_mini_tribe_sexuality.componentsJoined(by:","), forKey: "mini_tribe_sexuality")
            parameterDictionary.setValue(arr_mini_tribe_relationshipStatus.componentsJoined(by:","), forKey: "mini_tribe_relationship_status")
            
            parameterDictionary.setValue("add", forKey: "type")
            
            print(parameterDictionary)

            let methodName = "update_form_three"

            DataManager.getAPIResponse(parameterDictionary , methodName: methodName, methodType: "POST"){(responseData,error)-> Void in
                let status  = DataManager.getVal(responseData?["status"]) as! String
                let message  = DataManager.getVal(responseData?["message"]) as! String

                if status == "1" {
                    self.view.makeToast(message)

                    DispatchQueue.main.asyncAfter(deadline: .now()+1.5, execute: {
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let navigate = storyboard.instantiateViewController(withIdentifier: "TTabBarViewController") as! TTabBarViewController
                        let leftController = storyboard.instantiateViewController(withIdentifier: "LeftMenuViewController") as! LeftMenuViewController
                        let slideMenuController = SlideMenuController(mainViewController: UINavigationController(rootViewController:navigate), leftMenuViewController: leftController)
                        slideMenuController.delegate = leftController as? SlideMenuControllerDelegate
                        UIApplication.shared.windows.first?.rootViewController = slideMenuController
                        UIApplication.shared.windows.first?.makeKeyAndVisible()
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
    @IBAction func soullsexualtiy1(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected{
            minitribesex1.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
            minitribesex1.layer.borderWidth = 1
            btnchk1.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
            
            arr_mini_tribe_sexuality.add("Straight")
        }
        else{
            minitribesex1.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            minitribesex1.layer.borderWidth = 1
            btnchk1.setImage(UIImage(named: "black circle"), for: .normal)
            arr_mini_tribe_sexuality.remove("Straight")
        }
    }
    @IBAction func soullsexualtiy2(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected{
            minitribesex2.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
            minitribesex2.layer.borderWidth = 1
            btnchk2.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
            arr_mini_tribe_sexuality.add("Gay")
        }
        else{
            minitribesex2.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            minitribesex2.layer.borderWidth = 1
            btnchk2.setImage(UIImage(named: "black circle"), for: .normal)
            arr_mini_tribe_sexuality.remove("Gay")
        }
    }
    @IBAction func soullsexualtiy3(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected{
            minitribesex3.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
            minitribesex3.layer.borderWidth = 1
            btnchk3.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
            arr_mini_tribe_sexuality.add("Bisexual")
        }
        else{
            minitribesex3.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            minitribesex3.layer.borderWidth = 1
            btnchk3.setImage(UIImage(named: "black circle"), for: .normal)
            arr_mini_tribe_sexuality.remove("Bisexual")
        }
    }
    @IBAction func soullsexualtiy4(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected{
            minitribesex4.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
            minitribesex4.layer.borderWidth = 1
            btnchk4.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
            arr_mini_tribe_sexuality.add("Queer")
        }
        else{
            minitribesex3.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            minitribesex3.layer.borderWidth = 1
            btnchk4.setImage(UIImage(named: "black circle"), for: .normal)
            arr_mini_tribe_sexuality.remove("Queer")
        }
    }
    @IBAction func soullsexualtiy5(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected{
            minitribesex5.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
            minitribesex5.layer.borderWidth = 1
            btnchk5.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
            arr_mini_tribe_sexuality.add("Questioning")
        }
        else{
            minitribesex5.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            minitribesex5.layer.borderWidth = 1
            btnchk5.setImage(UIImage(named: "black circle"), for: .normal)
            arr_mini_tribe_sexuality.remove("Questioning")
        }
    }
    @IBAction func soullsexualtiy6(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected{
            minitribesex6.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
            minitribesex6.layer.borderWidth = 1
            btnchk6.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
            arr_mini_tribe_sexuality.add("Asexual")
        }
        else{
            minitribesex6.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            minitribesex6.layer.borderWidth = 1
            btnchk6.setImage(UIImage(named: "black circle"), for: .normal)
            arr_mini_tribe_sexuality.remove("Asexual")
        }
    }
    @IBAction func soullsexualtiy7(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected{
            minitribesex7.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
            minitribesex7.layer.borderWidth = 1
            btnchk7.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
            arr_mini_tribe_sexuality.add("Other")
        }
        else{
            minitribesex7.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            minitribesex7.layer.borderWidth = 1
            btnchk7.setImage(UIImage(named: "black circle"), for: .normal)
            arr_mini_tribe_sexuality.remove("Other")
        }
    }
    @IBAction func relation1(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected{
            minitribereletion1.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
            minitribereletion1.layer.borderWidth = 1
            btnchk8.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
            arr_mini_tribe_relationshipStatus.add("Single")
        }
        else{
            minitribereletion1.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            minitribereletion1.layer.borderWidth = 1
            btnchk8.setImage(UIImage(named: "black circle"), for: .normal)
            arr_mini_tribe_relationshipStatus.remove("Single")
        }
    }
    @IBAction func relation2(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected{
        minitribereletion2.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
        minitribereletion2.layer.borderWidth = 1
        btnchk9.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
        arr_mini_tribe_relationshipStatus.add("Married")
    }
    else{
        minitribereletion2.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        minitribereletion2.layer.borderWidth = 1
        btnchk9.setImage(UIImage(named: "black circle"), for: .normal)
        arr_mini_tribe_relationshipStatus.remove("Married")
    }
    }
    @IBAction func relation3(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected{
            minitribereletion3.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
            minitribereletion3.layer.borderWidth = 1
            btnchk10.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
            arr_mini_tribe_relationshipStatus.add("It's complicated")

        }
        else{
            minitribereletion3.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            minitribereletion3.layer.borderWidth = 1
            btnchk10.setImage(UIImage(named: "black circle"), for: .normal)
            arr_mini_tribe_relationshipStatus.remove("It's complicated")
        }
    }
}
