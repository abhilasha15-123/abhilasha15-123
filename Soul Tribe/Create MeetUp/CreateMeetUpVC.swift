//
//  CreateMeetUpVC.swift
//  Soul Tribe
//
//  Created by Ashish Soni on 29/06/21.
//

import UIKit
import MapKit
import CoreLocation

class CreateMeetUpVC: UIViewController,UIPopoverPresentationControllerDelegate, CLLocationManagerDelegate {
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
    @IBOutlet weak var lblYoga: UILabel!
    @IBOutlet weak var lblZoomCall: UILabel!
    @IBOutlet weak var lblDinner: UILabel!
    @IBOutlet weak var lblHike: UILabel!
    @IBOutlet weak var lblPicnic: UILabel!
    @IBOutlet weak var lblNatureWalk: UILabel!
    @IBOutlet weak var lblOther: UILabel!
    @IBOutlet weak var lblMeetupTopic: UILabel!
    @IBOutlet weak var DatePickerView: UIView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var btnDone: UIButton!
    
    //MARK:- Variables

    var toolBar = UIToolbar()
    var meetUpVisibility = "Public"
    let locationManager = CLLocationManager()
    var longitude : Double = 0
    var latitude : Double = 0
    //MARK:- ViewDidLoad

    override func viewDidLoad() {
        super.viewDidLoad()
        ConfigureViewDidLoad()
        
        
    }
    //MARK:- ViewDidAppear

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
    }
    //MARK:- BackButton

    @IBAction func backBtnAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    //MARK:- btncreatemeet

    @IBAction func btncreatemeet(_ sender: Any) {
        print(imguser.image!)
        popupview.isHidden = false
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
    //MARK:- btnYoga

    @IBAction func btnYoga(_ sender: UIButton) {
        lblMeetupTopic.text = lblYoga.text
        lblMeetupTopic.textColor = .black
        meetUpTopicDropDownView.isHidden = true
        
    }
    //MARK:- btnZoomCall

    @IBAction func btnZoomCall(_ sender: UIButton) {
        lblMeetupTopic.text = lblZoomCall.text
        lblMeetupTopic.textColor = .black
        meetUpTopicDropDownView.isHidden = true
        
    }
    //MARK:- btnDinner

    @IBAction func btnDinner(_ sender: UIButton) {
        lblMeetupTopic.text = lblDinner.text
        lblMeetupTopic.textColor = .black
        meetUpTopicDropDownView.isHidden = true
        
    }
    //MARK:- btnHike

    @IBAction func btnHike(_ sender: Any) {
        lblMeetupTopic.text = lblHike.text
        lblMeetupTopic.textColor = .black
        meetUpTopicDropDownView.isHidden = true
        
    }
    //MARK:- btnNatureWalk

    @IBAction func btnNatureWalk(_ sender: Any) {
        lblMeetupTopic.text = lblNatureWalk.text
        lblMeetupTopic.textColor = .black
        meetUpTopicDropDownView.isHidden = true
        
    }
    //MARK:- btnPicnic

    @IBAction func btnPicnic(_ sender: Any) {
        lblMeetupTopic.text = lblPicnic.text
        lblMeetupTopic.textColor = .black
        meetUpTopicDropDownView.isHidden = true
        
    }
    //MARK:- btnOther

    @IBAction func btnOther(_ sender: Any) {
        lblMeetupTopic.text = lblOther.text
        lblMeetupTopic.textColor = .black
        meetUpTopicDropDownView.isHidden = true
        
    }
    //MARK:- BtnTopicDownSelected

    @objc func BtnTopicDownSelected(){
        if meetUpTopicDropDownView.isHidden == true {
            meetUpTopicDropDownView.isHidden = false
        }
        else{
            meetUpTopicDropDownView.isHidden = true
        }
    }
    //MARK:- btnPrivateSelected

    @objc func btnPrivateSelected(){
        btnprivate.isSelected = true
        btnpublic.isSelected = false
        meetUpVisibility = "Private"
        print(meetUpVisibility)
    }
    //MARK:- btnPublicSelected

    @objc func btnPublicSelected(){
        btnpublic.isSelected = true
        btnprivate.isSelected = false
        meetUpVisibility = "Public"
        print(meetUpVisibility)
        
    }
    @objc func btnDoneTappedForDateAndTimePicker(){
        DatePickerView.isHidden = true
    }
    //MARK:- btnDateSelected
    @objc func btnDateSelected() {
        if DatePickerView.isHidden == true{
            DatePickerView.isHidden = false
        }
        else {
        DatePickerView.isHidden = true
    }
    }
   

    @IBAction func DatePickerValueChanged(_ sender: UIDatePicker?) {
        if btndate.isSelected == true{
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
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
                print(time)
                txttime.text = time
                        }
        }
    }
    //MARK:- btnTimePicker
   
    @IBAction func ButoonTimeSelected(_ sender: UIButton) {
        datePicker.datePickerMode = .time
        DatePickerView.isHidden = false

    }
    
    //MARK:- LocationManager

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if locations.first != nil {
            let locValue:CLLocationCoordinate2D = manager.location!.coordinate
            longitude = locValue.longitude
            latitude = locValue.latitude
            print("locations = \(locValue.latitude) \(locValue.longitude)")
        }
        locationManager.stopUpdatingLocation()
    }
    //MARK:- ApiManager

    func getData(){
        
        self.view.endEditing(true)
        let paraDict = NSMutableDictionary()
        paraDict.setValue(Config().api_key, forKey: "api_key")
        paraDict.setValue("37", forKey: "user_id")
        paraDict.setValue("7", forKey: "mini_tribe_id")
        paraDict.setValue(lblMeetupTopic.text!, forKey: "meetup_topic")
        paraDict.setValue(txtdate.text!, forKey: "meetup_date")
        paraDict.setValue(txttime.text!, forKey: "meetup_time")
        paraDict.setValue(txtAM.text!, forKey: "meetup_period")
        paraDict.setValue(txtviewdiscription.text!, forKey: "meetup_description")
        paraDict.setValue(txtlocation.text!, forKey: "meetup_location")
        paraDict.setValue("7.88888", forKey: "meetup_latitude")
        paraDict.setValue("8.66666", forKey: "meetup_longitude")
        paraDict.setValue(self.meetUpVisibility, forKey: "meetup_visibility")
        paraDict.setValue("1", forKey: "invite_ids")
        paraDict.setValue( imguser.image!, forKey: "meetup_icon")
        paraDict.setValue("", forKey: "meetup_status")
        print(paraDict)
        let methodName = "create_mini_tribe_meetup"
        
        DataManager.getAPIResponse(paraDict , methodName: methodName, methodType: "POST"){(responseData,error)-> Void in
            let status  = DataManager.getVal(responseData?["status"]) as? String ?? ""
            let message  = DataManager.getVal(responseData?["message"]) as? String ?? ""
            print(message)
            if status == "1" {
                print(DataManager.getVal(responseData?["data"]) as? [String:Any] ?? [:])
            }
            else {
                print(message)
            }
            //         basicFunctions.stopLoading()
        }
    }
    //MARK:- ConfigureViewdidLoad

    func ConfigureViewDidLoad() {
        meetUpTopicDropDownView.isHidden = true
        btnpublic.isSelected = true
        btntopicdown.addTarget(self, action: #selector(BtnTopicDownSelected), for: .touchUpInside)
        btnprivate.addTarget(self, action: #selector(btnPrivateSelected), for: .touchUpInside)
        btnpublic.addTarget(self, action: #selector(btnPublicSelected), for: .touchUpInside)
        btndate.addTarget(self, action: #selector(btnDateSelected), for: .touchUpInside)
        btnDone.addTarget(self, action: #selector(btnDoneTappedForDateAndTimePicker), for: .touchUpInside)
        txtdate.isUserInteractionEnabled = false
        DatePickerView.isHidden = true
        popupview.isHidden = true
        innerpopview.layer.cornerRadius = 8
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
