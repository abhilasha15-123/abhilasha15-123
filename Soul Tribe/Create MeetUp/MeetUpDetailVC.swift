//
//  MeetUpDetailVC.swift
//  Soul Tribe
//
//  Created by Ashish Soni on 29/06/21.
//

import UIKit
import GoogleMaps
import OnlyPictures

class MeetUpDetailVC: UIViewController {
    //MARK:- IBOutlet
    
    @IBAction func btn_goingAction(_ sender: UIButton) {
        api_updateStatus(id: "1")
        
        btngoing.backgroundColor = UIColor(red: 0.05, green: 0.23, blue: 0.66, alpha: 0.2)
        btnmightgo.backgroundColor = UIColor.white
        btnnotgoing.backgroundColor = UIColor.white
    }
    
    
    @IBAction func btn_mightGoAction(_ sender: UIButton) {
        api_updateStatus(id: "3")
        
        btngoing.backgroundColor = UIColor.white
        btnmightgo.backgroundColor = UIColor(red: 0.05, green: 0.23, blue: 0.66, alpha: 0.2)
        btnnotgoing.backgroundColor = UIColor.white
    }
    @IBAction func btn_notGoingAction(_ sender: UIButton) {
        api_updateStatus(id: "2")
        btngoing.backgroundColor = UIColor.white
        btnmightgo.backgroundColor = UIColor.white
        btnnotgoing.backgroundColor = UIColor(red: 0.05, green: 0.23, blue: 0.66, alpha: 0.2)
    }
    
    @IBOutlet weak var constraint_width_onlyImages1: NSLayoutConstraint! // 100
    @IBOutlet weak var constraint_width_onlyImages2: NSLayoutConstraint!
    @IBOutlet weak var constraint_width_onlyImages3: NSLayoutConstraint!
    
    
    @IBOutlet weak var vw_map: GMSMapView!
    @IBOutlet weak var onlyImages3: OnlyHorizontalPictures!
    @IBOutlet weak var onlyImgaes1: OnlyHorizontalPictures!
    @IBOutlet weak var onlyImages2: OnlyHorizontalPictures!
    
    var meetupId = ""
    var miniTribeId = ""
    
    var arr_Going = [[String:Any]]()
    var arr_NotGoing = [[String:Any]]()
    var arr_MightGo = [[String:Any]]()
    
    @IBOutlet weak var img_userNew: UIImageView!
    @IBOutlet weak var btnback: UIButton!
    @IBOutlet weak var imguser: UIImageView!
    @IBOutlet weak var lblmeditation: UILabel!
    @IBOutlet weak var btnpublic: UIButton!
    @IBOutlet weak var lblcreated: UILabel!
    @IBOutlet weak var lbldate: UILabel!
    @IBOutlet weak var lbltime: UILabel!
    @IBOutlet weak var lbllocation: UILabel!
    @IBOutlet weak var lbldiscription: UILabel!
    @IBOutlet weak var btnraedmore: UIButton!
    @IBOutlet weak var btngoing: UIButton!
    @IBOutlet weak var btnmightgo: UIButton!
    @IBOutlet weak var btnnotgoing: UIButton!
    @IBOutlet weak var lblGoing: UILabel!
    @IBOutlet weak var lblNotGoing: UILabel!
    @IBOutlet weak var lblMightGo: UILabel!
    //MARK:- Variables
    var ApiDict = NSMutableDictionary()
    //MARK:- viewDidLoad

    override func viewDidLoad() {
        super.viewDidLoad()
        getdata()
        
        self.onlyImgaes1.dataSource = self
        self.onlyImages2.dataSource = self
        self.onlyImages3.dataSource = self

        self.onlyImgaes1.alignment = .left
        self.onlyImages2.alignment = .left
        self.onlyImages3.alignment = .left
        
        self.img_userNew.layer.cornerRadius = self.img_userNew.frame.size.width/2

        btngoing.layer.cornerRadius = 6
//        btngoing.layer.borderWidth = 0.7
//        btngoing.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)

        btnmightgo.layer.cornerRadius = 6
        btnmightgo.layer.borderWidth = 0.7
        btnmightgo.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        btnnotgoing.layer.cornerRadius = 6
        btnnotgoing.layer.borderWidth = 0.7
        btnnotgoing.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        // Do any additional setup after loading the view.
    }
    
    //MARK:- backBtnAction

    @IBAction func backBtnAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)

    }
    //MARK:- ApiManager

    func api_updateStatus(id:String){
        
        basicFunctions.presentLoader()
        self.view.endEditing(true)
        
        let paraDict = NSMutableDictionary()
        paraDict.setValue(Config().api_key, forKey: "api_key")
        paraDict.setValue(Config().AppUserDefaults.value(forKey:"user_id") as? String ?? "", forKey: "user_id")
        paraDict.setValue(self.miniTribeId , forKey: "mini_tribe_id")
        paraDict.setValue(self.meetupId , forKey: "mini_tribe_meetup_id")
        paraDict.setValue(id, forKey: "status")
        paraDict.setValue("meetup", forKey: "type")
 
        let methodName = "meetup_status_change"
        DataManager.getAPIResponse(paraDict , methodName: methodName, methodType: "POST"){(responseData,error)-> Void in
             let status  = DataManager.getVal(responseData?["status"]) as? String ?? ""
             let message  = DataManager.getVal(responseData?["message"]) as? String ?? ""
                print(message)
             if status == "1" {
                self.getdata()
             }
             else {
                print(message)
             }
            basicFunctions.stopLoading()
        }
    }
    
    func getdata(){
        let userID = Config().AppUserDefaults.value(forKey:"user_id") as? String ?? ""
        let paraDict = NSMutableDictionary()
        paraDict.setValue(Config().api_key, forKey: "api_key")

        paraDict.setValue(userID, forKey: "user_id")
        paraDict.setValue("3", forKey: "mini_tribe_id")
        paraDict.setValue("1", forKey: "mini_tribe_meetup_id")

        paraDict.setValue(Config().AppUserDefaults.value(forKey:"user_id") as? String ?? "", forKey: "user_id")
        paraDict.setValue(miniTribeId, forKey: "mini_tribe_id")
        paraDict.setValue(meetupId, forKey: "mini_tribe_meetup_id")
        
        print (paraDict)

        
        let methodName = "get_detail_mini_tribe_meetup"
        DataManager.getAPIResponse(paraDict , methodName: methodName, methodType: "POST"){(responseData,error)-> Void in
             let status  = DataManager.getVal(responseData?["status"]) as? String ?? ""
             let message  = DataManager.getVal(responseData?["message"]) as? String ?? ""
                print(message)
             if status == "1" {
                print(DataManager.getVal(responseData?["data"]) as? [String:Any] ?? [:])
                self.ApiDict = DataManager.getVal(responseData?["data"]) as? NSMutableDictionary ?? [:]
                
                self.img_userNew.sd_setImage(with: URL(string: "\(Config().baseImageUrl)\(DataManager.getVal(self.ApiDict["meetup_image"]) as? String ?? "")"), completed: nil)
                
                let visibility = DataManager.getVal(self.ApiDict["meetup_visibility"]) as? String ?? ""
                    
                if visibility == "2"{
                    self.btnpublic.setTitle("Public", for: .normal)
                }else{
                    self.btnpublic.setTitle("Private", for: .normal)
                }
                
                let lat = DataManager.getVal(self.ApiDict["meetup_latitude"]) as? String ?? ""
                let lon = DataManager.getVal(self.ApiDict["meetup_longitude"]) as? String ?? ""
                
                self.vw_map.camera = GMSCameraPosition(latitude: CLLocationDegrees(lat) ?? 0.0, longitude: CLLocationDegrees(lon) ?? 0.0, zoom: 15.0)
                let marker = GMSMarker(position: CLLocationCoordinate2D(latitude: CLLocationDegrees(lat) ?? 0.0, longitude: CLLocationDegrees(lon) ?? 0.0))
                marker.map = self.vw_map
                
                
                self.lbldate.text = self.ApiDict["meetup_date"] as? String ?? ""
                self.lbltime.text = self.ApiDict["meetup_time"] as? String ?? ""
                self.lbllocation.text = self.ApiDict["meetup_location"] as? String ?? ""
                self.lbldiscription.text = self.ApiDict["meetup_description"] as? String ?? ""
                self.lblcreated.text = "Created By \(self.ApiDict["name"] as? String ?? "")"
                self.lblGoing.text = "\(self.ApiDict["meetup_going_members"] as? Int ?? 0) People Are Going"
                self.lblNotGoing.text = "\(self.ApiDict["meetup_not_going_members"] as? Int ?? 0) People Are Not Going"
                self.lblMightGo.text = "\(self.ApiDict["meetup_might_go_members"] as? Int ?? 0) People Might Go"
                
                self.arr_Going = DataManager.getVal(self.ApiDict["meetup_going_members_list"]) as? [[String:Any]] ?? []
                self.arr_MightGo = DataManager.getVal(self.ApiDict["meetup_might_go_list"]) as? [[String:Any]] ?? []
                self.arr_NotGoing = DataManager.getVal(self.ApiDict["meetup_not_going_members_list"]) as? [[String:Any]] ?? []
                
                if self.arr_Going.count > 0 {
                    self.constraint_width_onlyImages1.constant = 100
                }else{
                    self.constraint_width_onlyImages1.constant = 0
                }
                
                if self.arr_NotGoing.count > 0 {
                    self.constraint_width_onlyImages2.constant = 100
                }else{
                    self.constraint_width_onlyImages2.constant = 0
                }
                
                
                if self.arr_MightGo.count > 0 {
                    self.constraint_width_onlyImages3.constant = 100
                }else{
                    self.constraint_width_onlyImages3.constant = 0
                }
                
                self.onlyImages3.reloadData()
                self.onlyImgaes1.reloadData()
                self.onlyImages2.reloadData()
             }
             else {
                print(message)
             }
    }
    }

}



extension MeetUpDetailVC: OnlyPicturesDataSource {

    // ---------------------------------------------------
    // returns the total no of pictures
    
    func numberOfPictures() -> Int {
        return arr_Going.count
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
    
        let dict = arr_Going[index]
        let urlStr = "\(Config().baseImageUrl)\(DataManager.getVal(dict["profile_image"]) as? String ?? "")"
       
        imageView.image = #imageLiteral(resourceName: "Ellipse 36")   // placeholder image
        imageView.sd_setImage(with: URL(string: urlStr), completed: nil)
        
    }
}
