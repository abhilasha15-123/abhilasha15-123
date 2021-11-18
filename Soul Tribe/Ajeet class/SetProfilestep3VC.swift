//
//  SetProfilestep3VC.swift
//  DemoNew
//
//  Created by mac-9 on 02/07/21.
//

import UIKit

class SetProfilestep3VC: UIViewController {
    
    @IBOutlet weak var constraint_top_vwTribe: NSLayoutConstraint! //15
    @IBOutlet weak var headerview: UIView!
    @IBOutlet weak var sexview1: UIView!
    @IBOutlet weak var sexview2: UIView!
    @IBOutlet weak var sexview3: UIView!
    @IBOutlet weak var sexview4: UIView!
    @IBOutlet weak var sexview5: UIView!
    @IBOutlet weak var sexview6: UIView!
    @IBOutlet weak var sexview7: UIView!
    @IBOutlet weak var relationstaus1: UIView!
    @IBOutlet weak var relationstaus2: UIView!
    @IBOutlet weak var relationstaus3: UIView!
    @IBOutlet weak var relationstaus4: UIView!
    //mysoullovegender outlet
    @IBOutlet weak var mysoullovegender1: UIView!
    @IBOutlet weak var mysoullovegender2: UIView!
    @IBOutlet weak var mysoullovegender3: UIView!
    @IBOutlet weak var mysoullovegender4: UIView!
    @IBOutlet weak var mysoullovegender5: UIView!
    @IBOutlet weak var mysoullovegender6: UIView!
    @IBOutlet weak var mysoullovegender7: UIView!
   //soulSexuality outlet
    @IBOutlet weak var soulSexualityview1: UIView!
    @IBOutlet weak var soulSexualityview2: UIView!
    @IBOutlet weak var soulSexualityview3: UIView!
    @IBOutlet weak var soulSexualityview4: UIView!
    @IBOutlet weak var soulSexualityview5: UIView!
    @IBOutlet weak var soulSexualityview6: UIView!
    @IBOutlet weak var soulSexualityview7: UIView!
    @IBOutlet weak var soulSexualityview8: UIView!
    //soul term
    @IBOutlet weak var soultermview1: UIView!
    @IBOutlet weak var soultermview2: UIView!
    @IBOutlet weak var souldiscription: UIView!

    
    
    //tribe gender outlet
    @IBOutlet weak var Tribegender1: UIView!
    @IBOutlet weak var Tribegender2: UIView!
    @IBOutlet weak var Tribegender3: UIView!
    @IBOutlet weak var Tribegender4: UIView!
    @IBOutlet weak var Tribegender5: UIView!
    @IBOutlet weak var Tribegender6: UIView!
    @IBOutlet weak var Tribegender7: UIView!
    
    //Tribe Sexuality outlet
    @IBOutlet weak var TribeSexuality1: UIView!
    @IBOutlet weak var TribeSexuality2: UIView!
    @IBOutlet weak var TribeSexuality3: UIView!
    @IBOutlet weak var TribeSexuality4: UIView!
    @IBOutlet weak var TribeSexuality5: UIView!
    @IBOutlet weak var TribeSexuality6: UIView!
    @IBOutlet weak var TribeSexuality7: UIView!
    @IBOutlet weak var TribeSexuality8: UIView!
    @IBOutlet weak var tribediscription: UIView!
    
    @IBOutlet weak var btnnext: UIButton!
    @IBOutlet weak var btncheck1: UIButton!
    @IBOutlet weak var btncheck2: UIButton!
    @IBOutlet weak var btncheck3: UIButton!
    @IBOutlet weak var btncheck4: UIButton!
    @IBOutlet weak var btncheck5: UIButton!
    @IBOutlet weak var btncheck6: UIButton!
    @IBOutlet weak var btncheck7: UIButton!
    @IBOutlet weak var btncheck8: UIButton!
    @IBOutlet weak var btncheck9: UIButton!
    @IBOutlet weak var btncheck10: UIButton!
    @IBOutlet weak var btncheck11: UIButton!
    @IBOutlet weak var btncheck12: UIButton!
    @IBOutlet weak var btncheck13: UIButton!
    @IBOutlet weak var btncheck14: UIButton!
    @IBOutlet weak var btncheck15: UIButton!
    @IBOutlet weak var btncheck16: UIButton!
    @IBOutlet weak var btncheck17: UIButton!
    @IBOutlet weak var btncheck18: UIButton!
    @IBOutlet weak var btncheck19: UIButton!
    @IBOutlet weak var btncheck20: UIButton!
    @IBOutlet weak var btncheck21: UIButton!
    @IBOutlet weak var btncheck22: UIButton!
    @IBOutlet weak var btncheck23: UIButton!
    @IBOutlet weak var btncheck24: UIButton!
    @IBOutlet weak var btncheck25: UIButton!
    @IBOutlet weak var btncheck26: UIButton!
    @IBOutlet weak var btncheck27: UIButton!
    @IBOutlet weak var btncheck28: UIButton!
    @IBOutlet weak var btntribechk1: UIButton!
    @IBOutlet weak var btntribechk2: UIButton!
    @IBOutlet weak var btntribechk3: UIButton!
    @IBOutlet weak var btntribechk4: UIButton!
    @IBOutlet weak var btntribechk5: UIButton!
    @IBOutlet weak var btntribechk6: UIButton!
    @IBOutlet weak var btntribechk7: UIButton!
    @IBOutlet weak var btntribechk8: UIButton!
    @IBOutlet weak var btntribechk9: UIButton!
    @IBOutlet weak var btntribechk10: UIButton!
    @IBOutlet weak var btntribechk11: UIButton!
    @IBOutlet weak var btntribechk12: UIButton!
    @IBOutlet weak var btntribechk13: UIButton!
    @IBOutlet weak var btntribechk14: UIButton!
    @IBOutlet weak var btntribechk15: UIButton!

    @IBOutlet weak var vw_hideShow: UIView!
    
    var vibe = ""
    var arr_vibes = [String]()
    var api_call_here = false
    
    
    var arr_my_sexuality : NSMutableArray = []
    var arr_my_relationshipStatus : NSMutableArray = []
    var arr_soul_gender : NSMutableArray = []
    var arr_soul_sexuality : NSMutableArray = []
    var arr_soul_relationshipGoal : NSMutableArray = []
    
    var arr_tribe_gender : NSMutableArray = []
    var arr_tribe_sexuality : NSMutableArray = []
   
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        vw_hideShow.isHidden = true
        arr_vibes = vibe.components(separatedBy: ",")
        
        if arr_vibes.contains("Soul Love"){
            constraint_top_vwTribe.constant = 15
            vw_hideShow.isHidden = true
        }else{
            constraint_top_vwTribe.constant = -1135
            vw_hideShow.isHidden = false
        }
        
        
        if arr_vibes.contains("Mini Tribes") {
            api_call_here = false
        }else{
            api_call_here = true
        }
        
        
        headerview.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        headerview.layer.shadowOpacity = 0.5
        headerview.layer.shadowOffset = .zero
        headerview.layer.shadowRadius = 5
        
        // My sexuality is All view
        sexview1.layer.cornerRadius = 5
        sexview1.layer.borderWidth = 1
        sexview1.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        sexview2.layer.cornerRadius = 5
        sexview2.layer.borderWidth = 1
        sexview2.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        sexview3.layer.cornerRadius = 5
        sexview3.layer.borderWidth = 1
        sexview3.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        sexview4.layer.cornerRadius = 5
        sexview4.layer.borderWidth = 1
        sexview4.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        sexview5.layer.cornerRadius = 5
        sexview5.layer.borderWidth = 1
        sexview5.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        sexview6.layer.cornerRadius = 5
        sexview6.layer.borderWidth = 1
        sexview6.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        sexview7.layer.cornerRadius = 5
        sexview7.layer.borderWidth = 1
        sexview7.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        // My relationstaus is All view

        relationstaus1.layer.cornerRadius = 5
        relationstaus1.layer.borderWidth = 1
        relationstaus1.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        relationstaus2.layer.cornerRadius = 5
        relationstaus2.layer.borderWidth = 1
        relationstaus2.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        relationstaus3.layer.cornerRadius = 5
        relationstaus3.layer.borderWidth = 1
        relationstaus3.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        relationstaus4.layer.cornerRadius = 5
        relationstaus4.layer.borderWidth = 1
        relationstaus4.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        // My soullove Gender All view
        mysoullovegender1.layer.cornerRadius = 5
        mysoullovegender1.layer.borderWidth = 1
        mysoullovegender1.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        mysoullovegender2.layer.cornerRadius = 5
        mysoullovegender2.layer.borderWidth = 1
        mysoullovegender2.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        mysoullovegender3.layer.cornerRadius = 5
        mysoullovegender3.layer.borderWidth = 1
        mysoullovegender3.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        mysoullovegender4.layer.cornerRadius = 5
        mysoullovegender4.layer.borderWidth = 1
        mysoullovegender4.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        mysoullovegender5.layer.cornerRadius = 5
        mysoullovegender5.layer.borderWidth = 1
        mysoullovegender5.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        mysoullovegender6.layer.cornerRadius = 5
        mysoullovegender6.layer.borderWidth = 1
        mysoullovegender6.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        mysoullovegender7.layer.cornerRadius = 5
        mysoullovegender7.layer.borderWidth = 1
        mysoullovegender7.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
       
        //soulSexualityview
        soulSexualityview1.layer.cornerRadius = 5
        soulSexualityview1.layer.borderWidth = 1
        soulSexualityview1.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        soulSexualityview2.layer.cornerRadius = 5
        soulSexualityview2.layer.borderWidth = 1
        soulSexualityview2.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        soulSexualityview3.layer.cornerRadius = 5
        soulSexualityview3.layer.borderWidth = 1
        soulSexualityview3.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        soulSexualityview4.layer.cornerRadius = 5
        soulSexualityview4.layer.borderWidth = 1
        soulSexualityview4.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        soulSexualityview5.layer.cornerRadius = 5
        soulSexualityview5.layer.borderWidth = 1
        soulSexualityview5.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        soulSexualityview6.layer.cornerRadius = 5
        soulSexualityview6.layer.borderWidth = 1
        soulSexualityview6.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        soulSexualityview7.layer.cornerRadius = 5
        soulSexualityview7.layer.borderWidth = 1
        soulSexualityview7.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        soulSexualityview8.layer.cornerRadius = 5
        soulSexualityview8.layer.borderWidth = 1
        soulSexualityview8.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
    
        // soultermview
        soultermview1.layer.cornerRadius = 5
        soultermview1.layer.borderWidth = 1
        soultermview1.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        soultermview2.layer.cornerRadius = 5
        soultermview2.layer.borderWidth = 1
        soultermview2.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
       
        souldiscription.layer.cornerRadius = 5
        souldiscription.layer.borderWidth = 1
        souldiscription.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        
        //tribe gender
        
        Tribegender1.layer.cornerRadius = 5
        Tribegender1.layer.borderWidth = 1
        Tribegender1.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        Tribegender2.layer.cornerRadius = 5
        Tribegender2.layer.borderWidth = 1
        Tribegender2.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        Tribegender3.layer.cornerRadius = 5
        Tribegender3.layer.borderWidth = 1
        Tribegender3.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        Tribegender4.layer.cornerRadius = 5
        Tribegender4.layer.borderWidth = 1
        Tribegender4.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        Tribegender5.layer.cornerRadius = 5
        Tribegender5.layer.borderWidth = 1
        Tribegender5.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        Tribegender6.layer.cornerRadius = 5
        Tribegender6.layer.borderWidth = 1
        Tribegender6.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        Tribegender7.layer.cornerRadius = 5
        Tribegender7.layer.borderWidth = 1
        Tribegender7.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        //TribeSexuality
        
        TribeSexuality1.layer.cornerRadius = 5
        TribeSexuality1.layer.borderWidth = 1
        TribeSexuality1.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        TribeSexuality2.layer.cornerRadius = 5
        TribeSexuality2.layer.borderWidth = 1
        TribeSexuality2.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        TribeSexuality3.layer.cornerRadius = 5
        TribeSexuality3.layer.borderWidth = 1
        TribeSexuality3.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        TribeSexuality4.layer.cornerRadius = 5
        TribeSexuality4.layer.borderWidth = 1
        TribeSexuality4.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        TribeSexuality5.layer.cornerRadius = 5
        TribeSexuality5.layer.borderWidth = 1
        TribeSexuality5.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        TribeSexuality6.layer.cornerRadius = 5
        TribeSexuality6.layer.borderWidth = 1
        TribeSexuality6.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        TribeSexuality7.layer.cornerRadius = 5
        TribeSexuality7.layer.borderWidth = 1
        TribeSexuality7.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        TribeSexuality8.layer.cornerRadius = 5
        TribeSexuality8.layer.borderWidth = 1
        TribeSexuality8.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        // TribeDiscription
        tribediscription.layer.cornerRadius = 5
        tribediscription.layer.borderWidth = 1
        tribediscription.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        btnnext.layer.cornerRadius = 8
        btnnext.layer.borderWidth = 1
        btnnext.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
    
        // Do any additional setup after loading the view.
    }
    
 
    
    @IBAction func btnnext(_ sender: Any) {
        
        if api_call_here == true {
            
            if ValidationClass().ValidateProfileSetup3Form(self){
                
                basicFunctions.presentLoader()

                let parameterDictionary = NSMutableDictionary()
                parameterDictionary.setValue(Config().AppUserDefaults.value(forKey:"user_id") as? String ?? "", forKey: "user_id")
                parameterDictionary.setValue(Config().api_key, forKey: "api_key")
                
                parameterDictionary.setValue(arr_my_sexuality.componentsJoined(by:","), forKey: "soul_love_my_sexuality")
                parameterDictionary.setValue(arr_my_relationshipStatus.componentsJoined(by:","), forKey: "soul_love_my_relationship_status")
                parameterDictionary.setValue(arr_soul_gender.componentsJoined(by:","), forKey: "soul_love_my_prefer_gender")
                parameterDictionary.setValue(arr_soul_sexuality.componentsJoined(by:","), forKey: "soul_love_my_prefer_sexuality")
                parameterDictionary.setValue(arr_soul_relationshipGoal.componentsJoined(by:","), forKey: "relationship_looking_for_soul_love")
                parameterDictionary.setValue("", forKey: "soul_love_QA")
                parameterDictionary.setValue(arr_tribe_gender.componentsJoined(by:","), forKey: "tribe_gender")
                parameterDictionary.setValue(arr_tribe_sexuality.componentsJoined(by:","), forKey: "tribe_sexuality")
                
                parameterDictionary.setValue("", forKey: "tribe_QA")
                parameterDictionary.setValue("", forKey: "mini_tribe_sexuality")
                parameterDictionary.setValue("", forKey: "mini_tribe_relationship_status")
                
                parameterDictionary.setValue("add", forKey: "type")
                
                print(parameterDictionary)

                let methodName = "update_form_three"

                DataManager.getAPIResponse(parameterDictionary , methodName: methodName, methodType: "POST"){(responseData,error)-> Void in
                    let status  = DataManager.getVal(responseData?["status"]) as! String
                    let message  = DataManager.getVal(responseData?["message"]) as! String

                    if status == "1" {
                        self.view.makeToast(message)

                        let data = DataManager.getVal(responseData?["data"]) as? [String:Any] ?? [:]
                        
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

//                    let vc = self.storyboard?.instantiateViewController(identifier: "AddIntentionsVC") as! AddIntentionsVC
//                    navigationController?.pushViewController(vc, animated: true)

        }else{
            
            if ValidationClass().ValidateProfileSetup3Form(self){
                let vc = self.storyboard?.instantiateViewController(identifier: "SetProfilefinalVC") as! SetProfilefinalVC
                
                vc.arr_my_sexuality = self.arr_my_sexuality
                vc.arr_my_relationshipStatus = self.arr_my_relationshipStatus
                vc.arr_soul_gender = self.arr_soul_gender
                vc.arr_soul_sexuality = self.arr_soul_sexuality
                vc.arr_soul_relationshipGoal = self.arr_soul_relationshipGoal
                vc.arr_tribe_gender = self.arr_tribe_gender
                vc.arr_tribe_sexuality = self.arr_tribe_sexuality
                
                navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    @IBAction func btnBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func soulsex1(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected{
            sexview1.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
            sexview1.layer.borderWidth = 1
            btncheck1.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
            arr_my_sexuality.add("Straight")
        }
        else{
            sexview1.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            sexview1.layer.borderWidth = 1
            btncheck1.setImage(UIImage(named: "black circle"), for: .normal)
            arr_my_sexuality.remove("Straight")
        }
    }
    @IBAction func soulsex2(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected{
            sexview2.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
            sexview2.layer.borderWidth = 1
            btncheck2.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
            arr_my_sexuality.add("Gay")
        }
        else{
            sexview2.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            sexview2.layer.borderWidth = 1
            btncheck2.setImage(UIImage(named: "black circle"), for: .normal)
            arr_my_sexuality.remove("Gay")
        }
    }
    @IBAction func soulsex3(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected{
            sexview3.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
            sexview3.layer.borderWidth = 1
            btncheck3.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
            arr_my_sexuality.add("Bisexual")
        }
        else{
            sexview3.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            sexview3.layer.borderWidth = 1
            btncheck3.setImage(UIImage(named: "black circle"), for: .normal)
            arr_my_sexuality.remove("Bisexual")

        }
    }
    @IBAction func soulsex4(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected{
            sexview4.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
            sexview4.layer.borderWidth = 1
            btncheck4.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
            arr_my_sexuality.add("Queer")
        }
        else{
            sexview4.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            sexview4.layer.borderWidth = 1
            btncheck4.setImage(UIImage(named: "black circle"), for: .normal)
            arr_my_sexuality.remove("Queer")
        }
    }
    @IBAction func soulsex5(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected{
            sexview5.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
            sexview5.layer.borderWidth = 1
            btncheck5.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
            arr_my_sexuality.add("Questioning")
        }
        else{
            sexview5.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            sexview5.layer.borderWidth = 1
            btncheck5.setImage(UIImage(named: "black circle"), for: .normal)
            arr_my_sexuality.remove("Questioning")
        }
    }
    @IBAction func soulsex6(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected{
            sexview6.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
            sexview6.layer.borderWidth = 1
            btncheck6.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
            arr_my_sexuality.add("Asexual")
        }
        else{
            sexview6.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            sexview6.layer.borderWidth = 1
            btncheck6.setImage(UIImage(named: "black circle"), for: .normal)
            arr_my_sexuality.remove("Asexual")
        }
    }
    @IBAction func soulsex7(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected{
            sexview7.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
            sexview7.layer.borderWidth = 1
            btncheck7.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
            arr_my_sexuality.add("Other")
        }
        else{
            sexview7.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            sexview7.layer.borderWidth = 1
            btncheck7.setImage(UIImage(named: "black circle"), for: .normal)
            arr_my_sexuality.remove("Other")
        }
    }
    @IBAction func soulrelation1(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected{
            relationstaus1.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
            relationstaus1.layer.borderWidth = 1
            btncheck8.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
            arr_my_relationshipStatus.add("Single")
        }
        else{
            relationstaus1.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            relationstaus1.layer.borderWidth = 1
            btncheck8.setImage(UIImage(named: "black circle"), for: .normal)
            arr_my_relationshipStatus.remove("Single")
        }
    }
    @IBAction func soulrelation2(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected{
            relationstaus2.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
            relationstaus2.layer.borderWidth = 1
            btncheck9.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
            arr_my_relationshipStatus.add("Married")
        }
        else{
            relationstaus2.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            relationstaus2.layer.borderWidth = 1
            btncheck9.setImage(UIImage(named: "black circle"), for: .normal)
            arr_my_relationshipStatus.remove("Married")
        }
    }
    @IBAction func soulreletion3(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected{
            relationstaus3.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
            relationstaus3.layer.borderWidth = 1
            btncheck10.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
            arr_my_relationshipStatus.add("It's complicated")
        }
        else{
            relationstaus3.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            relationstaus3.layer.borderWidth = 1
            btncheck10.setImage(UIImage(named: "black circle"), for: .normal)
            arr_my_relationshipStatus.remove("It's complicated")
        }
    }
    @IBAction func solulreletion4(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected{
            relationstaus4.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
            relationstaus4.layer.borderWidth = 1
            btncheck11.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
            arr_my_relationshipStatus.add("In Relationship")
        }
        else{
            relationstaus4.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            relationstaus4.layer.borderWidth = 1
            btncheck11.setImage(UIImage(named: "black circle"), for: .normal)
            arr_my_relationshipStatus.remove("In Relationship")
        }
    }
    @IBAction func solulgender1(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected{
            mysoullovegender1.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
            mysoullovegender1.layer.borderWidth = 1
            btncheck12.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
            arr_soul_gender.add("Female")
        }
        else{
            mysoullovegender1.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            mysoullovegender1.layer.borderWidth = 1
            btncheck12.setImage(UIImage(named: "black circle"), for: .normal)
            arr_soul_gender.remove("Female")
        }
    }
    @IBAction func soulgender2(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected{
            mysoullovegender2.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
            mysoullovegender2.layer.borderWidth = 1
            btncheck13.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
            arr_soul_gender.add("Male")
        }
        else{
            mysoullovegender2.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            mysoullovegender2.layer.borderWidth = 1
            btncheck13.setImage(UIImage(named: "black circle"), for: .normal)
            arr_soul_gender.remove("Male")
        }
    }
    
    @IBAction func soulgender3(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected{
            mysoullovegender3.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
            mysoullovegender3.layer.borderWidth = 1
            btncheck14.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
            arr_soul_gender.add("Transgender")
        }
        else{
            mysoullovegender3.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            mysoullovegender3.layer.borderWidth = 1
            btncheck14.setImage(UIImage(named: "black circle"), for: .normal)
            arr_soul_gender.remove("Transgender")
        }
    }
    
    @IBAction func soulgender4(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected{
            mysoullovegender4.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
            mysoullovegender4.layer.borderWidth = 1
            btncheck15.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
            arr_soul_gender.add("Gender Fluid")
        }
        else{
            mysoullovegender4.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            mysoullovegender4.layer.borderWidth = 1
            btncheck15.setImage(UIImage(named: "black circle"), for: .normal)
            arr_soul_gender.remove("Gender Fluid")
        }
    }
    
    @IBAction func soulgender5(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected{
            mysoullovegender5.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
            mysoullovegender5.layer.borderWidth = 1
            btncheck16.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
            arr_soul_gender.add("Prefer not to say")
        }
        else{
            mysoullovegender5.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            mysoullovegender5.layer.borderWidth = 1
            btncheck16.setImage(UIImage(named: "black circle"), for: .normal)
            arr_soul_gender.remove("Prefer not to say")
        }
    }
    
    @IBAction func soulgender6(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected{
            mysoullovegender6.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
            mysoullovegender6.layer.borderWidth = 1
            btncheck17.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
            arr_soul_gender.add("Other")
        }
        else{
            mysoullovegender6.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            mysoullovegender6.layer.borderWidth = 1
            btncheck17.setImage(UIImage(named: "black circle"), for: .normal)
            arr_soul_gender.remove("Other")
        }
    }
    
    @IBAction func soulgender7(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected{
            mysoullovegender7.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
            mysoullovegender7.layer.borderWidth = 1
            btncheck18.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
            arr_soul_gender.add("No Preference")
        }
        else{
            mysoullovegender7.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            mysoullovegender7.layer.borderWidth = 1
            btncheck18.setImage(UIImage(named: "black circle"), for: .normal)
            arr_soul_gender.remove("No Preference")
        }
    }
   
    
    @IBAction func soullsexualtiy1(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected{
           soulSexualityview1.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
            soulSexualityview1.layer.borderWidth = 1
            btncheck19.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
            arr_soul_sexuality.add("Straight")
        }
        else{
            soulSexualityview1.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            soulSexualityview1.layer.borderWidth = 1
            btncheck19.setImage(UIImage(named: "black circle"), for: .normal)
            arr_soul_sexuality.remove("Straight")
        }
    }
    @IBAction func soullsexualtiy2(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected{
            soulSexualityview2.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
            soulSexualityview2.layer.borderWidth = 1
            btncheck20.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
            arr_soul_sexuality.add("Gay")
        }
        else{
            soulSexualityview2.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            soulSexualityview2.layer.borderWidth = 1
            btncheck20.setImage(UIImage(named: "black circle"), for: .normal)
            arr_soul_sexuality.remove("Gay")
        }
    }
    @IBAction func soullsexualtiy3(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected{
            soulSexualityview3.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
            soulSexualityview3.layer.borderWidth = 1
            btncheck21.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
            arr_soul_sexuality.add("Bisexual")
        }
        else{
            soulSexualityview3.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            soulSexualityview3.layer.borderWidth = 1
            btncheck21.setImage(UIImage(named: "black circle"), for: .normal)
            arr_soul_sexuality.remove("Bisexual")
        }
    }
    
    @IBAction func soullsexualtiy4(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected{
            soulSexualityview4.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
            soulSexualityview4.layer.borderWidth = 1
            btncheck22.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
            arr_soul_sexuality.add("Queer")
        }
        else{
            soulSexualityview4.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            soulSexualityview4.layer.borderWidth = 1
            btncheck22.setImage(UIImage(named: "black circle"), for: .normal)
            arr_soul_sexuality.remove("Queer")
        }
    }
    
    @IBAction func soullsexualtiy5(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected{
            soulSexualityview5.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
            soulSexualityview5.layer.borderWidth = 1
            btncheck23.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
            arr_soul_sexuality.add("Questioning")
        }
        else{
            soulSexualityview5.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            soulSexualityview5.layer.borderWidth = 1
            btncheck23.setImage(UIImage(named: "black circle"), for: .normal)
            arr_soul_sexuality.remove("Questioning")
        }
    }
    @IBAction func soullsexualtiy6(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected{
            soulSexualityview6.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
            soulSexualityview6.layer.borderWidth = 1
            btncheck24.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
            arr_soul_sexuality.add("Asexual")
        }
        else{
            soulSexualityview6.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            soulSexualityview6.layer.borderWidth = 1
            btncheck24.setImage(UIImage(named: "black circle"), for: .normal)
            arr_soul_sexuality.remove("Asexual")
        }
    }
    
    @IBAction func soullsexualtiy7(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected{
            soulSexualityview7.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
            soulSexualityview7.layer.borderWidth = 1
            btncheck25.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
            arr_soul_sexuality.add("Other")
        }
        else{
            soulSexualityview7.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            soulSexualityview7.layer.borderWidth = 1
            btncheck25.setImage(UIImage(named: "black circle"), for: .normal)
            arr_soul_sexuality.remove("Other")
        }
    }
    
    @IBAction func soullsexualtiy8(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected{
            soulSexualityview8.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
            soulSexualityview8.layer.borderWidth = 1
            btncheck26.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
            arr_soul_sexuality.add("No Preference")
        }
        else{
            soulSexualityview8.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            soulSexualityview8.layer.borderWidth = 1
            btncheck26.setImage(UIImage(named: "black circle"), for: .normal)
            arr_soul_sexuality.remove("No Preference")
        }
    }
    
    @IBAction func btnsoulterm1(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected{
            soultermview1.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
            soultermview1.layer.borderWidth = 1
            btncheck27.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
            arr_soul_relationshipGoal.add("Long term")
        }
        else{
            soultermview1.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            soultermview1.layer.borderWidth = 1
            btncheck27.setImage(UIImage(named: "black circle"), for: .normal)
            arr_soul_relationshipGoal.remove("Long term")
        }
    }
    @IBAction func btnsoulterm2(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected{
            soultermview2.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
            soultermview2.layer.borderWidth = 1
            btncheck28.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
            arr_soul_relationshipGoal.add("Casual")
        }
        else{
            soultermview2.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            soultermview2.layer.borderWidth = 1
            btncheck28.setImage(UIImage(named: "black circle"), for: .normal)
            arr_soul_relationshipGoal.remove("Casual")
        }
    }
    
   // tribe all action
    
    @IBAction func tribegender1(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected{
            Tribegender1.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
            Tribegender1.layer.borderWidth = 1
            btntribechk1.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
            arr_tribe_gender.add("Female")
        }
        else{
            Tribegender1.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            Tribegender1.layer.borderWidth = 1
            btntribechk1.setImage(UIImage(named: "black circle"), for: .normal)
            arr_tribe_gender.remove("Female")
        }
    }
    
    @IBAction func tribegender2(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected{
            Tribegender2.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
            Tribegender2.layer.borderWidth = 1
            btntribechk2.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
            arr_tribe_gender.add("Male")
        }
        else{
            Tribegender2.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            Tribegender2.layer.borderWidth = 1
            btntribechk2.setImage(UIImage(named: "black circle"), for: .normal)
            arr_tribe_gender.remove("Male")

        }
    }
    
    @IBAction func tribegender3(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected{
            Tribegender3.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
            Tribegender3.layer.borderWidth = 1
            btntribechk3.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
            arr_tribe_gender.add("Transgender")
        }
        else{
            Tribegender3.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            Tribegender3.layer.borderWidth = 1
            btntribechk3.setImage(UIImage(named: "black circle"), for: .normal)
            arr_tribe_gender.remove("Transgender")
        }
    }
    
    @IBAction func tribegender4(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected{
            Tribegender4.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
            Tribegender4.layer.borderWidth = 1
            btntribechk4.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
            arr_tribe_gender.add("Gender Fluid")
        }
        else{
            Tribegender4.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            Tribegender4.layer.borderWidth = 1
            btntribechk4.setImage(UIImage(named: "black circle"), for: .normal)
            arr_tribe_gender.remove("Gender Fluid")

        }
    }
    @IBAction func tribegender5(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected{
            Tribegender5.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
            Tribegender5.layer.borderWidth = 1
            btntribechk5.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
            arr_tribe_gender.add("Prefer not to say")
        }
        else{
            Tribegender5.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            Tribegender5.layer.borderWidth = 1
            btntribechk5.setImage(UIImage(named: "black circle"), for: .normal)
            arr_tribe_gender.remove("Prefer not to say")
            
        }
    }
    @IBAction func tribegender6(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected{
            Tribegender6.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
            Tribegender6.layer.borderWidth = 1
            btntribechk6.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
            arr_tribe_gender.add("Other")
        }
        else{
            Tribegender6.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            Tribegender6.layer.borderWidth = 1
            btntribechk6.setImage(UIImage(named: "black circle"), for: .normal)
            arr_tribe_gender.remove("Other")

        }
    }
    @IBAction func tribegender7(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected{
            Tribegender7.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
            Tribegender7.layer.borderWidth = 1
            btntribechk7.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
            arr_tribe_gender.add("No Preference")
        }
        else{
            Tribegender7.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            Tribegender7.layer.borderWidth = 1
            btntribechk7.setImage(UIImage(named: "black circle"), for: .normal)
            arr_tribe_gender.add("No Preference")

        }
    }
    
    @IBAction func tribesexualtiy1(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected{
            TribeSexuality1.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
            TribeSexuality1.layer.borderWidth = 1
            btntribechk8.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
            arr_tribe_sexuality.add("Straight")
        }
        else{
            TribeSexuality1.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            TribeSexuality1.layer.borderWidth = 1
            btntribechk8.setImage(UIImage(named: "black circle"), for: .normal)
            arr_tribe_sexuality.remove("Straight")

        }
    }
    
    @IBAction func tribesexualtiy2(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected{
            TribeSexuality2.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
            TribeSexuality2.layer.borderWidth = 1
            btntribechk9.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
            arr_tribe_sexuality.add("Gay")
        }
        else{
            TribeSexuality2.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            TribeSexuality2.layer.borderWidth = 1
            btntribechk9.setImage(UIImage(named: "black circle"), for: .normal)
            arr_tribe_sexuality.remove("Gay")

        }
    }
    
    @IBAction func tribesexualtiy3(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected{
            TribeSexuality3.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
            TribeSexuality3.layer.borderWidth = 1
            btntribechk10.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
            arr_tribe_sexuality.add("Bisexual")
        }
        else{
            TribeSexuality3.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            TribeSexuality3.layer.borderWidth = 1
            btntribechk10.setImage(UIImage(named: "black circle"), for: .normal)
            arr_tribe_sexuality.remove("Bisexual")
        }
    }
    
    @IBAction func tribesexualtiy4(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected{
            TribeSexuality4.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
            TribeSexuality4.layer.borderWidth = 1
            btntribechk11.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
            arr_tribe_sexuality.add("Queer")
        }
        else{
            TribeSexuality4.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            TribeSexuality4.layer.borderWidth = 1
            btntribechk11.setImage(UIImage(named: "black circle"), for: .normal)
            arr_tribe_sexuality.remove("Queer")

        }
    }
    @IBAction func tribesexualtiy5(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected{
            TribeSexuality5.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
            TribeSexuality5.layer.borderWidth = 1
            btntribechk12.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
            arr_tribe_sexuality.add("Questioning")
        }
        else{
            TribeSexuality5.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            TribeSexuality5.layer.borderWidth = 1
            btntribechk12.setImage(UIImage(named: "black circle"), for: .normal)
            arr_tribe_sexuality.remove("Questioning")

        }
    }
    
    @IBAction func tribesexualtiy6(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected{
            TribeSexuality6.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
            TribeSexuality6.layer.borderWidth = 1
            btntribechk13.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
            arr_tribe_sexuality.add("Asexual")
        }
        else{
            TribeSexuality6.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            TribeSexuality6.layer.borderWidth = 1
            btntribechk13.setImage(UIImage(named: "black circle"), for: .normal)
            arr_tribe_sexuality.remove("Asexual")
        }
    }
    
    @IBAction func tribesexualtiy7(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected{
            TribeSexuality7.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
            TribeSexuality7.layer.borderWidth = 1
            btntribechk14.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
            arr_tribe_sexuality.add("Other")

        }
        else{
            TribeSexuality7.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            TribeSexuality7.layer.borderWidth = 1
            btntribechk14.setImage(UIImage(named: "black circle"), for: .normal)
            arr_tribe_sexuality.remove("Other")

        }
    }
    
    @IBAction func tribesexualtiy8(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected{
            TribeSexuality8.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
            TribeSexuality8.layer.borderWidth = 1
            btntribechk15.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
            arr_tribe_sexuality.add("No Preference")

        }
        else{
            TribeSexuality8.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            TribeSexuality8.layer.borderWidth = 1
            btntribechk15.setImage(UIImage(named: "black circle"), for: .normal)
            arr_tribe_sexuality.remove("No Preference")


        }
    }
}

