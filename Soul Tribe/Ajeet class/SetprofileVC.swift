//
//  SetprofileVC.swift
//  DemoNew
//
//  Created by mac-9 on 02/07/21.
//

import UIKit
import YYCalendar
import AssetsPickerViewController
import Photos

class uploadimgcollcell: UICollectionViewCell{
    @IBOutlet weak var userimg: UIImageView!
    @IBOutlet weak var  brncross: UIButton!
}

class SetprofileVC: UIViewController {
    
    @IBOutlet weak var btn_gender5: UIButton!
    @IBOutlet weak var btn_gender4: UIButton!
    @IBOutlet weak var btn_gender6: UIButton!
    @IBOutlet weak var btn_gender3: UIButton!
    @IBOutlet weak var btn_gender2: UIButton!
    
    
    
    @IBAction func btn_profilePicChangeAction(_ sender: UIButton) {
        addingPicssDp = "dp"
        let picker = AssetsPickerViewController()
        let config = AssetsPickerConfig()
        config.albumIsShowEmptyAlbum = false
        
        let options = PHFetchOptions()
        options.predicate = NSPredicate(format: "mediaType = %d", PHAssetMediaType.image.rawValue)
        options.sortDescriptors = [NSSortDescriptor(key: "duration", ascending: true)]
        
        config.assetFetchOptions = [
            .smartAlbum: options,
            .album: options
        ]
        picker.pickerConfig = config
        picker.pickerDelegate = self
        present(picker, animated: true, completion: nil)
        
    }
    @IBOutlet weak var txt_firstImpression: UITextView!
    
    
    @IBOutlet weak var img_profilePic: UIImageView!
    @IBOutlet weak var constraint_height_collectionVw: NSLayoutConstraint!
    @IBOutlet weak var vw_displayCalendar_submain: UIView!
    @IBOutlet weak var vw_displayCalendar_main: UIView!
    
    @IBOutlet weak var btn_cancel_Calendar: UIButton!
    @IBOutlet weak var btn_continue_Calendar: UIButton!
    
    @IBAction func btn_Cancel_CalendarAction(_ sender: UIButton) {
        showAgePopup = false
        vw_displayCalendar_main.isHidden = true
    }
    
    
    @IBAction func btn_continueCalendarAction(_ sender: UIButton) {
        showAgePopup = false
        vw_displayCalendar_main.isHidden = true
        self.view.endEditing(true)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yy"
        
        
        let today = Date()
        let modifiedDate = Calendar.current.date(byAdding: .year, value: -17, to: today)!
        print(modifiedDate)
        let strDate = formatter.string(from: modifiedDate)
          
        let calendar = YYCalendar(limitedCalendarLangType: .ENG, date: strDate, minDate: nil , maxDate: strDate, format: "MM-dd-yy", completion: {date in
                print(date)
                self.selectedDate = date
                self.txt_dob.text = self.selectedDate
                self.txtage.text = "\(basicFunctions.calcAge(birthday: date))"
            })
            
            calendar.headerViewBackgroundColor = Config().AppThemeMainColor.withAlphaComponent(0.3)
            calendar.selectedDayColor = Config().AppThemeMainColor
            calendar.show()
    }
    
    
    @IBOutlet weak var lbl_distanceFormat: UILabel!
    @IBOutlet weak var tableViewDistanceFormat: UITableView!
    
    @IBOutlet weak var profileview: UIView!
    @IBOutlet weak var txtname: UITextField!
    @IBOutlet weak var txtsurname: UITextField!
    @IBOutlet weak var btnnext: UIButton!
    @IBOutlet weak var viewdob: UIView!
    @IBOutlet weak var txtage: UITextField!
    @IBOutlet weak var txtkm: UITextField!
    @IBOutlet weak var viewkm: UIView!
    @IBOutlet weak var viewdiscription: UIView!

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var txt_dob: UITextField!
    @IBOutlet weak var genderview1: UIView!
    @IBOutlet weak var genderview2: UIView!
    @IBOutlet weak var genderview3: UIView!
    @IBOutlet weak var genderview4: UIView!
    @IBOutlet weak var genderview5: UIView!
    @IBOutlet weak var genderview6: UIView!
    @IBOutlet weak var headerview: UIView!
    @IBOutlet weak var btngender1: UIButton!
    @IBOutlet weak var btnchk1: UIButton!
    @IBOutlet weak var btnchk2: UIButton!
    @IBOutlet weak var btnchk3: UIButton!
    @IBOutlet weak var btnchk4: UIButton!
    @IBOutlet weak var btnchk5: UIButton!
    @IBOutlet weak var btnchk6: UIButton!
    @IBOutlet weak var slider: UISlider!
    
    var addingPicssDp = ""
    var genderVal = ""
    var arr_gender : NSMutableArray = []
    var imgarray = ["Group 27152.png"]
    
    var arr_disFormat = ["Km","Mi"]
    var selectedDistanceFormat = "Km"
    var showAgePopup = true
    var selectedDate : String = ""
    
    var arr_assets = [PHAsset]()
    var profilePicAdded = false
    
    var userData = [String:Any]()
    
    var comesFrom = ""
    
    
    var arr_editAsset = [[String:Any]] ()
    var editAssetCount = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txt_firstImpression.delegate = self
        txt_firstImpression.text = "Share something that is unique and stands out. Something that makes users want to stop swiping and explore more about you!"
        txt_firstImpression.textColor = UIColor.lightGray
        
        constraint_height_collectionVw.constant = collectionView.frame.width/2.1 + 20
        
        txtage.text = ""
        txtage.isUserInteractionEnabled = false
        
        btn_continue_Calendar.layer.cornerRadius = 8
        btn_cancel_Calendar.layer.cornerRadius = 8
        vw_displayCalendar_submain.layer.cornerRadius = 8
        
        btn_cancel_Calendar.layer.borderWidth = 2
        btn_cancel_Calendar.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.3).cgColor
        
        viewkm.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(selectDistanceFormat))
        viewkm.addGestureRecognizer(tap)
          
        viewdob.isUserInteractionEnabled = true
        let tapA = UITapGestureRecognizer(target: self, action: #selector(selectDOB))
        viewdob.addGestureRecognizer(tapA)
        
        self.slider.value = 15
        self.slider.addTarget(self, action: #selector(sliderSlided), for: .valueChanged)

        tableViewDistanceFormat.delegate = self
        tableViewDistanceFormat.dataSource = self
        tableViewDistanceFormat.reloadData()
        
        headerview.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        headerview.layer.shadowOpacity = 0.5
        headerview.layer.shadowOffset = .zero
        headerview.layer.shadowRadius = 5
        
        profileview.layer.cornerRadius = 60
        img_profilePic.layer.cornerRadius = img_profilePic.frame.size.width/2
        
        profileview.layer.borderWidth = 2
        profileview.layer.borderColor = #colorLiteral(red: 0.05098039216, green: 0.2274509804, blue: 0.662745098, alpha: 1)
        
        txtname.layer.cornerRadius = 5
        txtname.layer.borderWidth = 1
        txtname.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        txtsurname.layer.cornerRadius = 5
        txtsurname.layer.borderWidth = 1
        txtsurname.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        viewdob.layer.cornerRadius = 5
        viewdob.layer.borderWidth = 1
        viewdob.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        txtage.layer.cornerRadius = 5
        txtage.layer.borderWidth = 1
        txtage.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        txtkm.layer.cornerRadius = 5
        txtkm.layer.borderWidth = 1
        txtkm.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        viewkm.layer.cornerRadius = 5
        viewkm.layer.borderWidth = 1
        viewkm.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        viewdiscription.layer.cornerRadius = 5
        viewdiscription.layer.borderWidth = 1
        viewdiscription.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        genderview1.layer.cornerRadius = 5
        genderview1.layer.borderWidth = 1
        genderview1.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        genderview2.layer.cornerRadius = 5
        genderview2.layer.borderWidth = 1
        genderview2.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        genderview3.layer.cornerRadius = 5
        genderview3.layer.borderWidth = 1
        genderview3.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        genderview4.layer.cornerRadius = 5
        genderview4.layer.borderWidth = 1
        genderview4.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        genderview5.layer.cornerRadius = 5
        genderview5.layer.borderWidth = 1
        genderview5.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        genderview6.layer.cornerRadius = 5
        genderview6.layer.borderWidth = 1
        genderview6.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        btnnext.layer.cornerRadius = 8
        self.slider.setThumbImage(UIImage(named: "Group 27193"), for: .normal)

        txt_dob.isUserInteractionEnabled = false
        
        if comesFrom == "Edit"{
            showAgePopup = false
            api_getData()
        }
    }
    
    func api_getData(){
           
        basicFunctions.presentLoader()

        let parameterDictionary = NSMutableDictionary()
        parameterDictionary.setValue(Config().AppUserDefaults.value(forKey:"user_id") as? String ?? "", forKey: "user_id")
        parameterDictionary.setValue(Config().api_key, forKey: "api_key")
        print(parameterDictionary)

        let methodName = "get_profile"

        DataManager.getAPIResponse(parameterDictionary , methodName: methodName, methodType: "POST"){(responseData,error)-> Void in
            let status  = DataManager.getVal(responseData?["status"]) as! String
            let message  = DataManager.getVal(responseData?["message"]) as! String

            if status == "1" {
                self.userData = DataManager.getVal(responseData?["data"]) as? [String:Any] ?? [:]
                self.setData()
            }
            else {
                self.view.makeToast(message, duration: 2.0, position: .bottom, title: nil, image: nil, style: ToastManager.shared.style, completion: nil)
            }
//            self.removeSpinner()
            basicFunctions.stopLoading()
        }
    }
    
    
    func setData(){
        
        let urlStr = "\(Config().baseImageUrl)\(DataManager.getVal(userData["profile_image"]) as? String ?? "")"
        img_profilePic.sd_setImage(with: URL(string: urlStr), completed: nil)
    
        profilePicAdded = true
        
        
        txtname.text = "\(DataManager.getVal(userData["name"]) as? String ?? "")"
        txtsurname.text = DataManager.getVal(userData["nick_name"]) as? String ?? ""
        
        txt_firstImpression.text = DataManager.getVal(userData["first_impression"]) as? String ?? ""
        
        if txt_firstImpression.text != ""{
            txt_firstImpression.textColor = UIColor.black
        }
        
        let dis = Float(DataManager.getVal(userData["search_distance"]) as? String ?? "") ?? 0
        slider.value = dis
        txtkm.text = "\(dis)"
        txtage.text = DataManager.getVal(userData["age"]) as? String ?? ""
        txt_dob.text = DataManager.getVal(userData["dob"]) as? String ?? ""
        selectedDate = txt_dob.text ?? ""
        selectedDistanceFormat = DataManager.getVal(userData["distance_type"]) as? String ?? ""
        self.lbl_distanceFormat.text = self.selectedDistanceFormat
          
        genderVal = DataManager.getVal(userData["gender"]) as? String ?? ""
        let arr = genderVal.components(separatedBy: ", ")
        
        for str in arr{
            if str == "Female" {
                genderview1.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
                genderview1.layer.borderWidth = 1
                btnchk1.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
                arr_gender.add("Female")
                btngender1.isSelected = true
                
            }else if str == "Male"{
                genderview2.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
                genderview2.layer.borderWidth = 1
                btnchk2.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
                arr_gender.add("Male")
                btn_gender2.isSelected = true
            }else if str == "Transgender"{
                genderview3.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
                genderview3.layer.borderWidth = 1
                btnchk3.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
                arr_gender.add("Transgender")
                btn_gender3.isSelected = true
            }else if str == "Gender Fluid"{
                genderview4.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
                genderview4.layer.borderWidth = 1
                btnchk4.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
                arr_gender.add("Gender Fluid")
                btn_gender4.isSelected = true
            }else if str == "Prefer not to say"{
                genderview5.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
                genderview5.layer.borderWidth = 1
                btnchk5.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
                arr_gender.add("Prefer not to say")
                btn_gender5.isSelected = true
            }else if str == "Other"{
                genderview6.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
                genderview6.layer.borderWidth = 1
                btnchk6.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
                arr_gender.add("Other")
                btn_gender6.isSelected = true
            }
        }
        
        self.arr_editAsset = DataManager.getVal(userData["get_product_images"]) as? [[String:Any]] ?? []
        self.editAssetCount = self.arr_editAsset.count
        
        if arr_editAsset.count + 1 > 4{
            constraint_height_collectionVw.constant = (collectionView.frame.width/2.1 * 3) + 20
        }
        else if arr_editAsset.count + 1 > 2{
            constraint_height_collectionVw.constant = (collectionView.frame.width/2.1 * 2) + 20
        }else{
            constraint_height_collectionVw.constant = (collectionView.frame.width/2.1 * 1) + 20
        }
        
        collectionView.reloadData()
        
    }
    
    @objc func selectDistanceFormat(){
        tableViewDistanceFormat.isHidden = !tableViewDistanceFormat.isHidden
    }
    
    @objc func selectDOB(){
        if showAgePopup == true {
            vw_displayCalendar_main.isHidden = false
        }else{
            self.view.endEditing(true)
            
            let formatter = DateFormatter()
            formatter.dateFormat = "MM-dd-yy"
            
            
            let today = Date()
            let modifiedDate = Calendar.current.date(byAdding: .year, value: -17, to: today)!
            print(modifiedDate)
            let strDate = formatter.string(from: modifiedDate)
              
            let calendar = YYCalendar(limitedCalendarLangType: .ENG, date: strDate, minDate: nil , maxDate: strDate, format: "MM-dd-yy", completion: {date in
                    print(date)
                    self.selectedDate = date
                    self.txt_dob.text = self.selectedDate
                    self.txtage.text = "\(basicFunctions.calcAge(birthday: date))"
                })
                
                calendar.headerViewBackgroundColor = Config().AppThemeMainColor.withAlphaComponent(0.3)
                calendar.selectedDayColor = Config().AppThemeMainColor
                calendar.show()
            
        }
    }
    
    
    @objc func sliderSlided (){
        self.txtkm.text = String(format: "%.2f", self.slider.value)
          
    }
    
    @IBAction func btnnext(_ sender: Any) {
 
        genderVal = arr_gender.componentsJoined(by: ", ")
        
        self.view.endEditing(true)

        if ValidationClass().ValidateProfileSetup1Form(self){

            basicFunctions.presentLoader()

            let parameterDictionary = NSMutableDictionary()

            parameterDictionary.setValue(Config().AppUserDefaults.value(forKey:"user_id") as? String ?? "", forKey: "user_id")
            
            parameterDictionary.setValue(Config().api_key, forKey: "api_key")
            parameterDictionary.setValue(txtname.text ?? "", forKey: "name")
            parameterDictionary.setValue(txtsurname.text ?? "", forKey: "nick_name")
            parameterDictionary.setValue(genderVal, forKey: "gender")
            parameterDictionary.setValue(txt_dob.text ?? "", forKey: "dob")
            parameterDictionary.setValue(txtage.text ?? "", forKey: "age")
            parameterDictionary.setValue(txtkm.text ?? "", forKey: "search_distance")
            parameterDictionary.setValue(txt_firstImpression.text ?? "", forKey: "first_impression")
            parameterDictionary.setValue(selectedDistanceFormat, forKey: "distance_type")
            
            if comesFrom == "Edit"{
                parameterDictionary.setValue("edit", forKey: "type")
            }else{
                parameterDictionary.setValue("add", forKey: "type")
            }
            
            let arr_images = NSMutableArray()
            
            if comesFrom == "Edit"{
                for index in 0..<self.arr_editAsset.count{
                    let dict = arr_editAsset[index]
                    let id = DataManager.getVal(dict["gallery_id"]) as? String ?? ""
                   
                    if id == "abc_abhilasha"{
                        let str = DataManager.getVal(dict["name"]) as? String ?? ""
                        do {
                            
                            let d = try Data(contentsOf: URL(string: str)!)
                            let img = UIImage(data: d)
                      
                            let dataDict = NSMutableDictionary()
                            
                            dataDict.setObject("photos", forKey: "keyName" as NSCopying)
                            dataDict.setObject(img?.pngData() ?? Data(), forKey: "MyData" as NSCopying)
                            dataDict.setObject("png", forKey: "ext" as NSCopying)
                            arr_images.add(dataDict)
                        }catch{
                            print(error)
                        }
                    }
                }
            }else{
                
                for index in 0..<self.arr_assets.count {
                    let asset = arr_assets[index]
                    let img = basicFunctions.getAssetThumbnail(asset: asset)
                        
                    let dataDict = NSMutableDictionary()
                        
                    dataDict.setObject("photos", forKey: "keyName" as NSCopying)
                    dataDict.setObject(img.pngData() ?? Data(), forKey: "MyData" as NSCopying)
                    dataDict.setObject("png", forKey: "ext" as NSCopying)
                    arr_images.add(dataDict)
                }
            }
            
            //For upload image
            let dataArr = NSMutableArray()
            let dataDict = NSMutableDictionary()
            dataDict.setObject("profile_image", forKey: "image" as NSCopying)
            dataDict.setObject(self.img_profilePic.image!.pngData()!, forKey: "imageData" as NSCopying)
            dataDict.setObject("png", forKey: "imagetype" as NSCopying)
            dataArr.add(dataDict)
            
            print(parameterDictionary)
           
            let methodName = "update_form_one"
            
            DataManager.MultipleImageArrayAndSingleImage(parameterDictionary: parameterDictionary, methodName: methodName, dataArray: arr_images, CertificateArray: dataArr, success: {
                (responseData,error)-> Void in
                    
                    let status = DataManager.getVal(responseData?["status"]) as! String
                    let message = DataManager.getVal(responseData?["message"]) as! String
                     
                    if status == "1" {
                        self.view.makeToast(message)
                        DispatchQueue.main.asyncAfter(deadline: .now()+1.5, execute: {
                            let vc = self.storyboard?.instantiateViewController(identifier: "SetProfilestep2VC") as! SetProfilestep2VC
                            vc.comesFrom = self.comesFrom
                            vc.userData = self.userData
                            self.navigationController?.pushViewController(vc, animated: true)
                        })
                    }
                    else {
                        self.view.makeToast(message)
                    }
                    basicFunctions.stopLoading()
            })
        }
    }
    
    @IBAction func btnBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

    @IBAction func btnfemale(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected{
            genderview1.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
            genderview1.layer.borderWidth = 1
            btnchk1.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
            arr_gender.add("Female")
        }
        else{
            genderview1.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            genderview1.layer.borderWidth = 1
            btnchk1.setImage(UIImage(named: "black circle"), for: .normal)
            arr_gender.remove("Female")
        }
    }
    @IBAction func btnmale(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected{
            genderview2.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
            genderview2.layer.borderWidth = 1.5
            btnchk2.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
            arr_gender.add("Male")
        }
        else{
            genderview2.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            genderview2.layer.borderWidth = 1
            btnchk2.setImage(UIImage(named: "black circle"), for: .normal)
            arr_gender.remove("Male")
        }
    }
    @IBAction func btntransgender(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected{
            genderview3.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
            genderview3.layer.borderWidth = 1.5
            btnchk3.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
            arr_gender.add("Transgender")
        }
        else{
            genderview3.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            genderview3.layer.borderWidth = 1
            btnchk3.setImage(UIImage(named: "black circle"), for: .normal)
            arr_gender.remove("Transgender")
        }
    }
    
    
    @IBAction func btnfluidgender(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected{
            genderview4.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
            genderview4.layer.borderWidth = 1.5
            btnchk4.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
            arr_gender.add("Gender Fluid")
        }
        else{
            genderview4.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            genderview4.layer.borderWidth = 1
            btnchk4.setImage(UIImage(named: "black circle"), for: .normal)
            arr_gender.remove("Gender Fluid")
        }
    }
    @IBAction func btnprefertosay(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected{
            genderview5.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
            genderview5.layer.borderWidth = 1.5
            btnchk5.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
            arr_gender.add("Prefer not to say")
        }
        else{
            genderview5.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            genderview5.layer.borderWidth = 1
            btnchk5.setImage(UIImage(named: "black circle"), for: .normal)
            arr_gender.remove("Prefer not to say")
        }
    }
    
    @IBAction func btnothergender(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected{
            genderview6.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
            genderview6.layer.borderWidth = 1.5
            btnchk6.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
            arr_gender.add("Other")
        }
        else{
            genderview6.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            genderview6.layer.borderWidth = 1
            btnchk6.setImage(UIImage(named: "black circle"), for: .normal)
            arr_gender.remove("Other")
        }
    }
    
}
extension SetprofileVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if comesFrom == "Edit" {
            return arr_editAsset.count + 1
        }else{
            return arr_assets.count + 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "uploadimgcollcell", for: indexPath) as! uploadimgcollcell

        cell.userimg.layer.cornerRadius = 8
        
        if comesFrom == "Edit" {
            if indexPath.row == arr_editAsset.count {
                cell.userimg.image = UIImage(named: "Group 27152")
                cell.brncross.isHidden = true
            }else{
                let dict = arr_editAsset[indexPath.row]
                
                let addUrl = DataManager.getVal(dict["images"]) as? String ?? ""
                var strUrl = ""
                
                if addUrl != "" {
                    strUrl = "\(Config().baseImageUrl)\(addUrl)"
                }else{
                    strUrl = DataManager.getVal(dict["name"]) as? String ?? ""
                }
             
                do {
                    let d = try Data(contentsOf: URL(string: strUrl)!)
                        cell.userimg.image = UIImage(data: d)
                }catch{
                    print(error)
                }
                cell.brncross.isHidden = false
            }
        }else{
            if indexPath.row == arr_assets.count {
                cell.userimg.image = UIImage(named: "Group 27152")
                cell.brncross.isHidden = true
            }else{
                let asset = arr_assets[indexPath.row]
                let img = basicFunctions.getAssetThumbnail(asset: asset)
                cell.userimg.image = img
                cell.brncross.isHidden = false
            }
        }
        cell.brncross.tag = indexPath.row
        cell.brncross.addTarget(self, action: #selector(deleteAsset(_:)), for: .touchUpInside)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
        
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width/2.1, height: collectionView.frame.width/2.1);

       }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if comesFrom == "Edit"{
            if indexPath.row == arr_editAsset.count {
                addingPicssDp = "pics"
                
                let picker = AssetsPickerViewController()
                let config = AssetsPickerConfig()
                config.albumIsShowEmptyAlbum = false
                if comesFrom != "Edit"{
                    config.selectedAssets = self.arr_assets
                }else{
                    
                }

                let options = PHFetchOptions()
                options.predicate = NSPredicate(format: "mediaType = %d", PHAssetMediaType.image.rawValue)
                options.sortDescriptors = [NSSortDescriptor(key: "duration", ascending: true)]

                config.assetFetchOptions = [
                    .smartAlbum: options,
                    .album: options
                ]

                picker.pickerConfig = config
                picker.pickerDelegate = self
                present(picker, animated: true, completion: nil)
            }
        }else{
            if indexPath.row == arr_assets.count {
                addingPicssDp = "pics"
                
                let picker = AssetsPickerViewController()
                let config = AssetsPickerConfig()
                config.albumIsShowEmptyAlbum = false
                if comesFrom != "Edit"{
                    config.selectedAssets = self.arr_assets
                }else{
                }

                let options = PHFetchOptions()
                options.predicate = NSPredicate(format: "mediaType = %d", PHAssetMediaType.image.rawValue)
                options.sortDescriptors = [NSSortDescriptor(key: "duration", ascending: true)]

                config.assetFetchOptions = [
                    .smartAlbum: options,
                    .album: options
                ]

                picker.pickerConfig = config
                picker.pickerDelegate = self
                present(picker, animated: true, completion: nil)
            }
        }
    }
    
    
    @objc func deleteAsset(_ sender : UIButton){
       
        if comesFrom == "Edit" {
            if sender.tag < editAssetCount{
                let deleteAlert = UIAlertController(title: "Delete", message: "Are you sure you want to delete the image permanently?", preferredStyle: UIAlertController.Style.alert)

                deleteAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                    let dict = self.arr_editAsset[sender.tag]
                    let id = DataManager.getVal(dict["id"]) as? String ?? ""
                    self.api_deleteImage(val: id, indexForArray: sender.tag)
                    print("deleteFromWeb")
                }))

                deleteAlert.addAction(UIAlertAction(title: Bundle.main.localizedString(forKey: "Cancel", value: nil, table: "Localizable"), style: .cancel, handler: { (action: UIAlertAction!) in
                }))
                self.present(deleteAlert, animated: true, completion: nil)
                
            }else{
                self.arr_editAsset.remove(at: sender.tag)
                
                if arr_editAsset.count + 1 > 4{
                    constraint_height_collectionVw.constant = (collectionView.frame.width/2.1 * 3) + 20
                }
                else if arr_editAsset.count + 1 > 2{
                    constraint_height_collectionVw.constant = (collectionView.frame.width/2.1 * 2) + 20
                }else{
                    constraint_height_collectionVw.constant = (collectionView.frame.width/2.1 * 1) + 20
                }
                
                self.collectionView.reloadData()
                print("deleteFromAssetsGallery")
            }
        }else{
            self.arr_assets.remove(at: sender.tag)
            if arr_assets.count + 1 > 4{
                constraint_height_collectionVw.constant = (collectionView.frame.width/2.1 * 3) + 20
            }
            else if arr_assets.count + 1 > 2{
                constraint_height_collectionVw.constant = (collectionView.frame.width/2.1 * 2) + 20
            }else{
                constraint_height_collectionVw.constant = (collectionView.frame.width/2.1 * 1) + 20
            }
            self.collectionView.reloadData()
        }
        
    }
    
    @objc func api_deleteImage(val: String, indexForArray : Int){
        self.view.endEditing(true)
            
        basicFunctions.presentLoader()

         
        
        let parameterDictionary = NSMutableDictionary()
        parameterDictionary.setValue(Config().AppUserDefaults.value(forKey:"user_id") as? String ?? "", forKey: "user_id")
        parameterDictionary.setValue(Config().api_key, forKey: "api_key")
        parameterDictionary.setValue(val, forKey: "image_id")
        
        print(parameterDictionary)

        let methodName = "delete_image"
        
        DataManager.getAPIResponse(parameterDictionary , methodName: methodName, methodType: "POST"){(responseData,error)-> Void in
            let status  = DataManager.getVal(responseData?["status"]) as? String ?? ""
            let message  = DataManager.getVal(responseData?["message"]) as? String ?? ""

            if status == "1" {
                self.arr_editAsset.remove(at: indexForArray)
                self.editAssetCount -= 1
                self.view.makeToast(message)
                
                if self.arr_editAsset.count + 1 > 4{
                    self.constraint_height_collectionVw.constant = (self.collectionView.frame.width/2.1 * 3) + 20
                }
                else if self.arr_editAsset.count + 1 > 2{
                    self.constraint_height_collectionVw.constant = (self.collectionView.frame.width/2.1 * 2) + 20
                }else{
                    self.constraint_height_collectionVw.constant = (self.collectionView.frame.width/2.1 * 1) + 20
                }
                self.collectionView.reloadData()
            }
            else {
                self.view.makeToast(message)
            }
            basicFunctions.stopLoading()
        }
    }
}


extension SetprofileVC : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr_disFormat.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! DistanceFormatTableViewCell
        cell.lbl_title.text = arr_disFormat[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedDistanceFormat = arr_disFormat[indexPath.row]
        self.lbl_distanceFormat.text = self.selectedDistanceFormat
        
        tableView.isHidden = true
    }
}



extension SetprofileVC: AssetsPickerViewControllerDelegate {
    
    func assetsPickerCannotAccessPhotoLibrary(controller: AssetsPickerViewController) {}
    func assetsPickerDidCancel(controller: AssetsPickerViewController) {}
    func assetsPicker(controller: AssetsPickerViewController, didSelect asset: PHAsset, at indexPath: IndexPath) {}
    func assetsPicker(controller: AssetsPickerViewController, didDeselect asset: PHAsset, at indexPath: IndexPath) {}
    
    func assetsPicker(controller: AssetsPickerViewController, shouldDeselect asset: PHAsset, at indexPath: IndexPath) -> Bool {
        return true
    }
    
    func assetsPicker(controller: AssetsPickerViewController, shouldSelect asset: PHAsset, at indexPath: IndexPath) -> Bool {
       
        if addingPicssDp == "dp" {
            if controller.selectedAssets.count > 0 {
                controller.photoViewController.deselectAll()
            }
            return true
        }else{
            
             if comesFrom == "Edit"{
                 let totalAssets = self.arr_editAsset.count + controller.selectedAssets.count
                 if totalAssets >= 5 {
                     return false
                 }else{
                     return true
                 }
             }else{
                if controller.selectedAssets.count >= 5 {
                    return false
                }else{
                    return true
                }
             }
        }
    }
    
    func assetsPicker(controller: AssetsPickerViewController, selected assets: [PHAsset]) {
        
        if addingPicssDp == "dp"{
            profilePicAdded = true
            let img = basicFunctions.getAssetThumbnail(asset: assets[0])
            self.img_profilePic.image = img
        }else{
            
            if comesFrom == "Edit"{
                for i in 0..<assets.count {
                    
                    let options: PHContentEditingInputRequestOptions = PHContentEditingInputRequestOptions()
                        options.canHandleAdjustmentData = {(adjustmeta: PHAdjustmentData) -> Bool in
                            return true
                        }
                    assets[i].requestContentEditingInput(with: options, completionHandler: { (contentEditingInput, info) in
                       
                        let urlStr = contentEditingInput!.fullSizeImageURL?.absoluteString
                        let dict = ["name" :"\(urlStr ?? "")","gallery_id":"abc_abhilasha"]
                        self.arr_editAsset.append(dict)
                        
                        if self.arr_editAsset.count + 1 > 4 {
                            self.constraint_height_collectionVw.constant = (self.collectionView.frame.width/2.1 * 3) + 20
                        }
                        else if self.arr_editAsset.count + 1 > 2 {
                            self.constraint_height_collectionVw.constant = (self.collectionView.frame.width/2.1 * 2) + 20
                        }
                        else {
                            self.constraint_height_collectionVw.constant = (self.collectionView.frame.width/2.1 * 1) + 20
                        }
                        
                        self.collectionView.reloadData()
                    })
                }
            }else{
                arr_assets = assets
                if arr_assets.count + 1 > 4{
                    constraint_height_collectionVw.constant = (collectionView.frame.width/2.1 * 3) + 20
                }
                else if arr_assets.count + 1 > 2{
                    constraint_height_collectionVw.constant = (collectionView.frame.width/2.1 * 2) + 20
                }
                else {
                    constraint_height_collectionVw.constant = (collectionView.frame.width/2.1 * 1) + 20
                }
            }
            collectionView.reloadData()
        }
    }
}

extension SetprofileVC : UITextViewDelegate{
    //MARK:- Textview Delegates
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if txt_firstImpression.textColor == UIColor.lightGray {
            txt_firstImpression.text = ""
            txt_firstImpression.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if txt_firstImpression.text == "" {
            txt_firstImpression.text = "Share something that is unique and stands out. Something that makes users want to stop swiping and explore more about you!"
            txt_firstImpression.textColor = UIColor.lightGray
        }
    }
    
}
