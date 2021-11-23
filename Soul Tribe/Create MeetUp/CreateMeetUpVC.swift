//
//  CreateMeetUpVC.swift
//  Soul Tribe
//
//  Created by Ashish Soni on 29/06/21.
//

import UIKit
import GoogleMaps
import GooglePlaces
import AssetsPickerViewController
import Photos
import OnlyPictures



class CreateMeetUpVC: UIViewController,UIPopoverPresentationControllerDelegate, UITextViewDelegate {
    
    @IBOutlet weak var img_userNee: UIImageView!
    @IBOutlet weak var onlyImages: OnlyHorizontalPictures!
    
    //MARK:- IBOutlets
    @IBOutlet weak var btnback: UIButton!
    @IBOutlet weak var imguser: UIImageView!
    @IBOutlet weak var btneditprofile: UIButton!
    @IBOutlet weak var viewtopic: UIView!
    @IBOutlet weak var btntopicdown: UIButton!
    @IBOutlet weak var viewdate: UIView!
    @IBOutlet weak var txtdate: UITextField!
    @IBOutlet weak var btndate: UIButton!
    @IBOutlet weak var txtviewdiscription: UITextView!
    @IBOutlet weak var viewprivat: UIView!
    @IBOutlet weak var viewpublic: UIView!
    @IBOutlet weak var btnprivate: UIButton!
    @IBOutlet weak var lblprivate: UILabel!
    @IBOutlet weak var btnpublic: UIButton!
    @IBOutlet weak var lblpublic: UILabel!
    @IBOutlet weak var btninvitemember: UIButton!
    @IBOutlet weak var btncreatemember: UIButton!
    @IBOutlet weak var viewtime: UIView!
    @IBOutlet weak var txttime: UITextField!
    @IBOutlet weak var viewAM: UIView!
    @IBOutlet weak var txtAM: UITextField!
    @IBOutlet weak var btnAM: UIButton!
    @IBOutlet weak var viewlocation: UIView!
    @IBOutlet weak var txtlocation: UITextField!
    @IBOutlet weak var btnlocation: UIButton!
    @IBOutlet weak var viewsharetribe: UIView!
    @IBOutlet weak var txttribe: UITextField!
    @IBOutlet weak var btnminitribe: UIButton!
    @IBOutlet weak var popupview: UIView!
    @IBOutlet weak var btncreatepop: UIButton!
    @IBOutlet weak var btnbackpop: UIButton!
    @IBOutlet weak var innerpopview: UIView!
    @IBOutlet weak var meetUpTopicDropDownView: UIView!
    @IBOutlet weak var txtMeetupTopic: UITextField!
    @IBOutlet weak var DatePickerView: UIView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var btnDone: UIButton!
    @IBOutlet weak var btnTime: UIButton!
    @IBOutlet weak var AmPmPicker: UIPickerView!
    @IBOutlet weak var MeetUpTopicPicker: UIPickerView!
    @IBOutlet weak var btnDoneForMeetUpTopic: UIButton!
    @IBOutlet weak var btnLocation: UIButton!
    @IBOutlet weak var miniTribePicker: UIPickerView!
    @IBOutlet weak var donebtnForMiniTribePicker: UIButton!
    @IBOutlet weak var miniTribeView: UIView!
    
    //MARK:- Variables
    var meetUpTopicArray = NSMutableArray()
    var apiTopicDict = NSMutableDictionary()
    var AmPmSelectionArray = ["AM","PM"]
    var meetUpVisibility = "2"
    var lat = ""
    var lon = ""
    let locationManager = CLLocationManager()
    var userLocation : CLLocationCoordinate2D?
    var MiniTribeArray = NSMutableArray()
    var NameArray = [String]()
    var IdArray = [Int]()
    var NameArrayTopic = [String]()
    var IdArrayTopic = [Int]()
    var apiMiniTribeDict = NSMutableDictionary()
    var mini_tribe_id:Int!
    var topic_id:Int!
    //MARK:- ViewDidLoad
    var idaar:String!
    var meetupSts:String!
    var arr_invitedMembers = [[String:Any]]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        onlyImages.alignment = .left
        
        self.imguser.layer.cornerRadius =  self.imguser.frame.size.width/2
        self.img_userNee.layer.cornerRadius =  self.img_userNee.frame.size.width/2
        ConfigureViewDidLoad()
        
        onlyImages.dataSource = self
            
        NotificationCenter.default.addObserver(self, selector: #selector(self.currencyImagePer(_:)), name: NSNotification.Name("memberdata"), object: nil)
    }
    
    
    @objc func currencyImagePer(_ pNotification: Notification) {
        
        if let extractInfo = pNotification.userInfo {
            self.arr_invitedMembers = extractInfo["data"] as? [[String:Any]] ?? []
        }
        onlyImages.reloadData()
//        idaar = UserDefaults.standard.value(forKey: "InviteData") as? String
    }
    
    //MARK:- BackButton
    
    @IBAction func backBtnAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    //MARK:- btncreatemeet
    
    @IBAction func btncreatemeet(_ sender: Any) {
        if ValidationClass().ValidateCreateMeetup(self){
  
            if txtviewdiscription.text == " Write details about the meetup here.." {
                let titleTxt = "Please enter description of meetup."
                self.view.endEditing(true)
                self.viewtime.layer.borderColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
                self.view.makeToast(titleTxt)

            }else{
                popupview.isHidden = false
            }
        }
//        print(imguser.image!)
//
        //        let nextview = CreateMeetuppopupVC.intitiateFromNib()
        //        let model = BackModel()
        //        nextview.buttoncancelHandler = {
        //            model.closewithAnimation()
        //        }
        //
        //        nextview.buttonCreateHandler = {
        ////            let vc = self.storyboard?.instantiateViewController(withIdentifier: "CreateMeetuppopupVC") as! CreateMeetuppopupVC
        ////            self.navigationController?.pushViewController(vc, animated: true)
        ////            model.closewithAnimation()
        //        }
        //          model.showLogout(view: nextview)
    }
    //MARK:- btncreatepop
    
    @IBAction func btncreatepop(_ sender: Any) {
        getData()
        //        let vc = self.storyboard?.instantiateViewController(identifier: "GroupTribeTabVC") as! GroupTribeTabVC
        //        navigationController?.pushViewController(vc, animated: true)
    }
    //MARK:- btnbackpop
    
    @IBAction func btnbackpop(_ sender: Any) {
        popupview.isHidden = true
        
    }
    //MARK:- btninvitemember
    
    @IBAction func btninvitemember(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(identifier: "InviteMemberVC") as! InviteMemberVC
        //navigationController?.pushViewController(vc, animated: true)
        vc.modalTransitionStyle = .coverVertical
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true, completion: nil)
        
    }
    //MARK:- BtnTopicDownSelected
    
    @objc func BtnTopicDownSelected(){
        getMeetUpTopics()
        if meetUpTopicDropDownView.isHidden == true {
            meetUpTopicDropDownView.isHidden = false
            txtMeetupTopic.textColor = #colorLiteral(red: 0.6901960784, green: 0.6901960784, blue: 0.6901960784, alpha: 1)
        }
        else{
            meetUpTopicDropDownView.isHidden = true
        }
    }
    //MARK:- btnPrivateSelected
    
    @objc func btnPrivateSelected(){
        btnprivate.isSelected = true
        btnpublic.isSelected = false
        meetUpVisibility = "1"
        print(meetUpVisibility)
    }
    //MARK:- btnPublicSelected
    
    @objc func btnPublicSelected(){
        btnpublic.isSelected = true
        btnprivate.isSelected = false
        meetUpVisibility = "2"
        print(meetUpVisibility)
        
    }
    @objc func btnDoneTappedForDateAndTimePicker(){
        AmPmPicker.isHidden = true
        DatePickerView.isHidden = true
        btnTime.isSelected = false
        btndate.isSelected = false
        btnTime.isSelected = false
        
    }
    //MARK:- btnDateSelected
    @objc func btnDateSelected() {
        if DatePickerView.isHidden == true{
            datePicker.datePickerMode = .date
            btnTime.isSelected = false
            AmPmPicker.isHidden = true
            datePicker.isHidden = false
            btndate.isSelected = true
            DatePickerView.isHidden = false
        }
        else {
            datePicker.datePickerMode = .date
            btnTime.isSelected = false
            AmPmPicker.isHidden = true
            btndate.isSelected = true
            DatePickerView.isHidden = true
        }
    }
    @IBAction func uploadImageBtnAction(_ sender: Any) {
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
    
    //MARK:- DatePickerAction
    
    @IBAction func DatePickerValueChanged(_ sender: UIDatePicker?) {
        if btndate.isSelected == true{
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .none
            
            if let date = sender?.date {
                print("Picked the date \(dateFormatter.string(from: date))")
                txtdate.text = dateFormatter.string(from: date)
            }
        } else {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .none
            dateFormatter.timeStyle = .short
            
            if let time = sender?.date {
                print("Picked the date \(dateFormatter.string(from: time))")
                var time = dateFormatter.string(from: time)
                time = time.replacingOccurrences(of: "PM", with: "")
                time = time.replacingOccurrences(of: "AM", with: "")
                print(time)
                txttime.text = time
            }
        }
    }
    //MARK:- btnTimePicker
    
    @IBAction func ButoonTimeSelected(_ sender: UIButton) {
        datePicker.isHidden = false
        datePicker.datePickerMode = .time
        DatePickerView.isHidden = false
        AmPmPicker.isHidden = true
        
    }
    @objc func btnAMSelected(){
        DatePickerView.isHidden = false
        datePicker.isHidden = true
        AmPmPicker.isHidden = false
    }
    @objc func btnDoneSelectedForMeetUpTopic(){
        meetUpTopicDropDownView.isHidden = true
        txtMeetupTopic.textColor = .black
    }
    @objc func searchLocation(){
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        present(autocompleteController, animated: true, completion: nil)
    }
    @objc func CurrentLocation(){
        locationManager.startUpdatingLocation()
        
        print("\(lat) and \(lon)")
    }
    
    @objc func MiniTribeDoneButtonSelection() {
        miniTribeView.isHidden = true
        txttribe.textColor = .black
        if NameArray.count == 1 {
            txttribe.text = NameArray[0]
            mini_tribe_id = IdArray[0]
        }
    }
    @objc func btnminitribeSelection() {
        getMiniTribeData()
        if miniTribeView.isHidden == true {
            miniTribeView.isHidden = false
        } else {
            miniTribeView.isHidden = true
        }

    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if txtviewdiscription.text == " Write details about the meetup here.." {
            txtviewdiscription.text = ""
            txtviewdiscription.textColor = .black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if txtviewdiscription.text == "" {
            txtviewdiscription.text = " Write details about the meetup here.."
            txtviewdiscription.textColor = #colorLiteral(red: 0.7242062092, green: 0.7242915034, blue: 0.7241678834, alpha: 1)
        }
    }
    
    
    //MARK:- ApiManager
    func getMeetUpTopics(){
        let paraDict = NSMutableDictionary()
        paraDict.setValue(Config().api_key, forKey: "api_key")
        let methodName = "get_meetup_topics"
        
        DataManager.getAPIResponse(paraDict , methodName: methodName, methodType: "POST"){(responseData,error)-> Void in
            let status  = DataManager.getVal(responseData?["status"]) as? String ?? ""
            let message  = DataManager.getVal(responseData?["message"]) as? String ?? ""
            print(message)
            if status == "1" {
                print(DataManager.getVal(responseData?["data"]) as? [String:Any] ?? [:])
                let api_Dict = DataManager.getVal(responseData?["data"]) as? [String:Any] ?? [:]
                self.meetUpTopicArray = api_Dict["meetupTopic"] as? NSMutableArray ?? []
                for i in 0..<self.meetUpTopicArray.count {
                    var dict = NSDictionary()
                    dict = self.meetUpTopicArray.object(at: i) as! NSDictionary
                    let name = dict.value(forKey: "name") as? String
                    self.NameArrayTopic.append(name ?? "")
                    let Id = dict.value(forKey: "Id") as? Int
                    self.IdArrayTopic.append(Id ?? 0)
                }
                self.MeetUpTopicPicker.reloadAllComponents()
            }
            else {
                print(message)
            }
            //         basicFunctions.stopLoading()
        }
    }
    func getMiniTribeData(){
        let paraDict = NSMutableDictionary()
        paraDict.setValue(Config().api_key, forKey: "api_key")
        paraDict.setValue(Config().AppUserDefaults.value(forKey:"user_id") as? String ?? "", forKey: "user_id")
        let methodName = "get_my_mini_tribe"
        
        DataManager.getAPIResponse(paraDict , methodName: methodName, methodType: "POST"){(responseData,error)-> Void in
            let status  = DataManager.getVal(responseData?["status"]) as? String ?? ""
            let message  = DataManager.getVal(responseData?["message"]) as? String ?? ""
            print(message)
            if status == "1" {
                print(DataManager.getVal(responseData?["data"]) as? [String:Any] ?? [:])
                self.MiniTribeArray = DataManager.getVal(responseData?["data"]) as? NSMutableArray ?? []
                for i in 0..<self.MiniTribeArray.count {
                    var dict = NSDictionary()
                    dict = self.MiniTribeArray.object(at: i) as! NSDictionary
                    let name = dict.value(forKey: "name") as? String
                    self.NameArray.append(name ?? "")
                    let Id = dict.value(forKey: "Id") as? Int
                    self.IdArray.append(Id ?? 0)
                }
                self.MeetUpTopicPicker.reloadAllComponents()
                self.miniTribePicker.reloadAllComponents()
            }
            else {
                print(message)
            }
            //         basicFunctions.stopLoading()
        }
    }
    
    func getData(){
        
        self.idaar = ""
        for dict in arr_invitedMembers{
            let id = DataManager.getVal(dict["id"]) as? String ?? ""
            self.idaar.append("\(id),")
        }
        
        self.idaar.removeLast()
        
        
        basicFunctions.presentLoader()
        self.view.endEditing(true)
        let paraDict = NSMutableDictionary()
        paraDict.setValue(Config().api_key, forKey: "api_key")
        paraDict.setValue(Config().AppUserDefaults.value(forKey:"user_id") as? String ?? "", forKey: "user_id")
        paraDict.setValue(self.mini_tribe_id , forKey: "mini_tribe_id")
        paraDict.setValue(txtMeetupTopic.text!, forKey: "meetup_topic")
        paraDict.setValue(txtdate.text!, forKey: "meetup_date")
        paraDict.setValue(txttime.text!, forKey: "meetup_time")
        paraDict.setValue(txtAM.text!, forKey: "meetup_period")
        paraDict.setValue(txtviewdiscription.text!, forKey: "meetup_description")
        paraDict.setValue(txtlocation.text!, forKey: "meetup_location")
        paraDict.setValue(self.lat, forKey: "meetup_latitude")
        paraDict.setValue(self.lon, forKey: "meetup_longitude")
        paraDict.setValue(self.meetUpVisibility, forKey: "meetup_visibility")
        paraDict.setValue(self.idaar, forKey: "invite_ids")
//        paraDict.setValue( imguser.image!, forKey: "meetup_icon")
        paraDict.setValue("", forKey: "meetup_status")
        
        //For upload image
        let dataArr = NSMutableArray()
        let dataDict = NSMutableDictionary()
        dataDict.setObject("meetup_icon", forKey: "image" as NSCopying)
        dataDict.setObject(self.img_userNee.image!.pngData()!, forKey: "imageData" as NSCopying)
        dataDict.setObject("png", forKey: "ext" as NSCopying)
        dataArr.add(dataDict)
        
        print(paraDict)
        
        
        let methodName = "create_mini_tribe_meetup"
        DataManager.getAPIResponseFileSingleImage(paraDict, methodName: methodName as NSString, dataArray: dataArr, success:{ (responseData,error)-> Void in
      //  DataManager.getAPIResponse(paraDict , methodName: methodName, methodType: "POST"){(responseData,error)-> Void in
            let status  = DataManager.getVal(responseData?["status"]) as? String ?? ""
            let message  = DataManager.getVal(responseData?["message"]) as? String ?? ""
            print(message)
            if status == "1" {
                print(DataManager.getVal(responseData?["data"]) as? [String:Any] ?? [:])
                self.view.makeToast(message)
                DispatchQueue.main.asyncAfter(deadline: .now()+1.0, execute: {
                    self.navigationController?.popViewController(animated: true)
                })
            }
            else {
                print(message)
            }
                    basicFunctions.stopLoading()
        })
    }
    //MARK:- ConfigureViewdidLoad
    
    func ConfigureViewDidLoad() {
      
        //MARK:- ButtonAction :-
        btntopicdown.addTarget(self, action: #selector(BtnTopicDownSelected), for: .touchUpInside)
        btnprivate.addTarget(self, action: #selector(btnPrivateSelected), for: .touchUpInside)
        btnpublic.addTarget(self, action: #selector(btnPublicSelected), for: .touchUpInside)
        btndate.addTarget(self, action: #selector(btnDateSelected), for: .touchUpInside)
        btnDone.addTarget(self, action: #selector(btnDoneTappedForDateAndTimePicker), for: .touchUpInside)
        btnAM.addTarget(self, action: #selector(btnAMSelected), for: .touchUpInside)
        btnDoneForMeetUpTopic.addTarget(self, action: #selector(btnDoneSelectedForMeetUpTopic), for: .touchUpInside)
        btnLocation.addTarget(self, action: #selector(searchLocation), for: .touchUpInside)
        btnlocation.addTarget(self, action: #selector(CurrentLocation), for: .touchUpInside)
        donebtnForMiniTribePicker.addTarget(self, action: #selector(MiniTribeDoneButtonSelection), for: .touchUpInside)
        btnminitribe.addTarget(self, action: #selector(btnminitribeSelection), for: .touchUpInside)

        //MARK:- SetValues :-
        
        miniTribeView.isHidden = true
        txtviewdiscription.delegate = self
        meetUpTopicDropDownView.isHidden = true
        btnpublic.isSelected = true
        AmPmPicker.isHidden = true
        txtdate.isUserInteractionEnabled = false
        DatePickerView.isHidden = true
        popupview.isHidden = true
        innerpopview.layer.cornerRadius = 8
        configurePickerView()
   
        txtMeetupTopic.isUserInteractionEnabled = false
        
        self.locationManager.requestAlwaysAuthorization()
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
        self.meetUpTopicDropDownView.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        self.meetUpTopicDropDownView.layer.shadowOpacity = 0.5
        self.meetUpTopicDropDownView.layer.shadowOffset = .zero
        self.meetUpTopicDropDownView.layer.shadowRadius = 8
        self.meetUpTopicDropDownView.layer.cornerRadius = 10
        
        DatePickerView.layer.cornerRadius = 5
        DatePickerView.layer.cornerRadius = 5
        DatePickerView.layer.borderWidth = 1
        DatePickerView.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        btncreatepop.layer.cornerRadius = 5
        btnbackpop.layer.cornerRadius = 5
        btnbackpop.layer.borderWidth = 1
        btnbackpop.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        viewtopic.layer.cornerRadius = 5
        viewtopic.layer.borderWidth = 1
        viewtopic.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        viewdate.layer.cornerRadius = 5
        viewdate.layer.borderWidth = 1
        viewdate.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        viewtime.layer.cornerRadius = 5
        viewtime.layer.borderWidth = 1
        viewtime.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        viewAM.layer.cornerRadius = 5
        viewAM.layer.borderWidth = 1
        viewAM.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        viewtopic.layer.cornerRadius = 5
        viewtopic.layer.borderWidth = 1
        viewtopic.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        
        viewlocation.layer.cornerRadius = 5
        viewlocation.layer.borderWidth = 1
        viewlocation.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        viewprivat.layer.cornerRadius = 5
        viewprivat.layer.borderWidth = 1
        viewprivat.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        viewpublic.layer.cornerRadius = 5
        viewpublic.layer.borderWidth = 1
        viewpublic.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        viewsharetribe.layer.cornerRadius = 5
        viewsharetribe.layer.borderWidth = 1
        viewsharetribe.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        txtviewdiscription.layer.cornerRadius = 5
        txtviewdiscription.layer.borderWidth = 1
        txtviewdiscription.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        txtMeetupTopic.textColor = #colorLiteral(red: 0.6901960784, green: 0.6901960784, blue: 0.6901960784, alpha: 1)
        
        //        let nextview = CreateMeetuppopupVC.intitiateFromNib()
        //                       let model = BackModel()
        //                       nextview.buttonCreateHandler = {
        //                           model.closewithAnimation()
        //                       }
        //
        //                       nextview.buttoncancelHandler = {
        //                           let deafults = UserDefaults.standard
        //                           deafults.set("0", forKey: "Logoutstatus")
        //                           deafults.removeObject(forKey: "UserIDAutologin")
        //                           deafults.synchronize()
        //                           let vc = self.storyboard?.instantiateViewController(withIdentifier: "CreateMeetuppopupVC") as! CreateMeetuppopupVC
        //                           self.navigationController?.pushViewController(vc, animated: true)
        //                           model.closewithAnimation()
        //                       }
        
        // model.showLogout(view: nextview)
        
        // Do any additional setup after loading the view.
    }
    
    
}
extension CreateMeetUpVC : UIPickerViewDelegate, UIPickerViewDataSource {
    func configurePickerView(){
        MeetUpTopicPicker.delegate = self
        MeetUpTopicPicker.dataSource = self
        AmPmPicker.delegate = self
        AmPmPicker.dataSource = self
        miniTribePicker.delegate = self
        miniTribePicker.dataSource = self
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == MeetUpTopicPicker {
            return meetUpTopicArray.count
        }else if pickerView == AmPmPicker{
            return AmPmSelectionArray.count
        }else {
            return NameArray.count
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == AmPmPicker{
               return AmPmSelectionArray[row]
        }
        else if pickerView == MeetUpTopicPicker {
            return NameArrayTopic[row]
        }else {
           return NameArray[row]
           
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == MeetUpTopicPicker {
            txtMeetupTopic.text =  NameArrayTopic[row]
            topic_id = IdArrayTopic[row]
        }else if pickerView == AmPmPicker{
            txtAM.text = AmPmSelectionArray[row]
        } else {
            txttribe.text = NameArray[row]
            self.mini_tribe_id = IdArray[row]
        }
    }
    
    
}
extension CreateMeetUpVC : GMSAutocompleteViewControllerDelegate{
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        
        print("Pickup Place name: ", place.name!)
        print("late and long", place.coordinate.latitude)
        print("late and long", place.coordinate.longitude)
//        self.txtlocation.text = place.name ?? ""
        self.lat = String(place.coordinate.latitude)
        self.lon = String(place.coordinate.longitude)
        
        
        getAddressFromLatLon(pdblLatitude: self.lat, withLongitude: self.lon)
        
        //        vw_map.camera = GMSCameraPosition(latitude: place.coordinate.latitude, longitude: place.coordinate.longitude, zoom: 15.0)
        
        //        getAddressFromLatLon(pdblLatitude: self.lat, withLongitude: self.lon)
        
        dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print("Error: ", error.localizedDescription)
    }
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
}
extension CreateMeetUpVC : CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last!.coordinate
        
        self.lat = String(location.latitude)
        self.lon = String(location.longitude)
        
        getAddressFromLatLon(pdblLatitude: self.lat, withLongitude: self.lon)
        //        vw_map.camera = GMSCameraPosition(target: location, zoom: 15.0)
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
        
        if hasLocationPermission() == false {
            let alertController = UIAlertController(title: Bundle.main.localizedString(forKey: "LocationPermissionRequired", value: nil, table: "Localizable"), message: Bundle.main.localizedString(forKey: "Pleaseenablelocationpermissionsinsettings", value: nil, table: "Localizable"), preferredStyle: UIAlertController.Style.alert)
            
            let okAction = UIAlertAction(title: Bundle.main.localizedString(forKey: "Settings", value: nil, table: "Localizable"), style: .default, handler: {(cAlertAction) in
                UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
            })
            
            let cancelAction = UIAlertAction(title: Bundle.main.localizedString(forKey: "Cancel", value: nil, table: "Localizable"), style: .destructive, handler: nil)
            alertController.addAction(cancelAction)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func hasLocationPermission() -> Bool {
        var hasPermission = false
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined, .restricted, .denied:
                hasPermission = false
            case .authorizedAlways, .authorizedWhenInUse:
                hasPermission = true
            @unknown default:
                print ("error Occurred")
            }
        } else {
            hasPermission = false
        }
        return hasPermission
    }
    
    //MARK:- Get address from latitude and longitude
    func getAddressFromLatLon(pdblLatitude: String, withLongitude pdblLongitude: String){
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        let lat: Double = Double("\(pdblLatitude)")!
        let lon: Double = Double("\(pdblLongitude)")!
        let ceo: CLGeocoder = CLGeocoder()
        center.latitude = lat
        center.longitude = lon
        
        let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
        
        ceo.reverseGeocodeLocation(loc, completionHandler: {(placemarks, error) in
            if (error != nil){
                print("reverse geodcode fail: \(error!.localizedDescription)")
            }
            if placemarks != nil{
                let pm = placemarks! as [CLPlacemark]
                    
                if pm.count > 0 {
                    let pm = placemarks![0]
                    var addressString : String = ""
                    if pm.subLocality != nil {
                        addressString = addressString + pm.subLocality! + ", "
                    }
                    if pm.thoroughfare != nil {
                        //area
                        addressString = addressString + pm.thoroughfare! + ", "
                    }else{
                    }
                    if pm.locality != nil {
                        //city
                        addressString = addressString + pm.locality! + ", "
                    }
                    else{
                    }
                    if pm.country != nil {
                        addressString = addressString + pm.country! + " "
                    }
                    else{
                    }
                        
                    if pm.postalCode != nil {
                        addressString = addressString + pm.postalCode!
                    }else{
                    }
                    print(addressString)
                    self.txtlocation.text = addressString
                }
            }else{
                print("Eroor aa rahi h location get karne me.")
            }
        })
    }

    
}
extension CreateMeetUpVC: AssetsPickerViewControllerDelegate {
    
    func assetsPickerCannotAccessPhotoLibrary(controller: AssetsPickerViewController) {}
    func assetsPickerDidCancel(controller: AssetsPickerViewController) {}
    func assetsPicker(controller: AssetsPickerViewController, didSelect asset: PHAsset, at indexPath: IndexPath) {}
    func assetsPicker(controller: AssetsPickerViewController, didDeselect asset: PHAsset, at indexPath: IndexPath) {}
    
    func assetsPicker(controller: AssetsPickerViewController, shouldDeselect asset: PHAsset, at indexPath: IndexPath) -> Bool {
        return true
    }
    
    func assetsPicker(controller: AssetsPickerViewController, shouldSelect asset: PHAsset, at indexPath: IndexPath) -> Bool {

            if controller.selectedAssets.count > 0 {
                controller.photoViewController.deselectAll()
            }
            return true
        
    }
    
    func assetsPicker(controller: AssetsPickerViewController, selected assets: [PHAsset]) {
          //  profilePicAdded = true
            let img = basicFunctions.getAssetThumbnail(asset: assets[0])
            self.img_userNee.image = img
       
    }
}

extension CreateMeetUpVC: OnlyPicturesDataSource {

    // ---------------------------------------------------
    // returns the total no of pictures
    
    func numberOfPictures() -> Int {
        return arr_invitedMembers.count
    }
    
    // ---------------------------------------------------
    // returns the no of pictures should be visible in screen.
    // In above preview, Left & Right formats are example of visible pictures, if you want pictures to be shown without count, remove this function, it's optional.
    
    func visiblePictures() -> Int {
        return 4
    }
    
    
    // ---------------------------------------------------
    // return the images you want to show. If you have URL's for images, use next function instead of this.
    // use .defaultPicture property to set placeholder image. This only work with local images. for URL's images we provided imageView instance, it's your responsibility to assign placeholder image in it. Check next function.
    // onlyPictures.defaultPicture = #imageLiteral(resourceName: "defaultProfilePicture")
    
//    func pictureViews(index: Int) -> UIImage {
//
//        return pictures[index]
//    }
    
    
    // ---------------------------------------------------
    // If you do have URLs of images. Use below function to have UIImageView instance and index insted of 'pictureViews(index: Int) -> UIImage'
    // NOTE: It's your resposibility to assign any placeholder image till download & assignment completes.
    // I've used AlamofireImage here for image async downloading, assigning & caching, Use any library to allocate your image from url to imageView.
    
    func pictureViews(_ imageView: UIImageView, index: Int) {
    
        let dict = arr_invitedMembers[index]
        let urlStr = "\(Config().baseImageUrl)\(DataManager.getVal(dict["profile_image"]) as? String ?? "")"
       
        imageView.image = #imageLiteral(resourceName: "Ellipse 36")   // placeholder image
        imageView.sd_setImage(with: URL(string: urlStr), completed: nil)
        
    }
}
