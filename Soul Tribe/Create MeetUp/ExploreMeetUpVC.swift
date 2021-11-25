//
//  ExploreMeetUpVC.swift
//  Soul Tribe
//
//  Created by Ashish Soni on 29/06/21.
//

import UIKit
import GoogleMaps
import GooglePlaces
import OnlyPictures

class ExploreMeetUpVC: UIViewController {
    
  
    @IBAction func btn_getCurrentLocationAction(_ sender: UIButton) {
        locationManager.startUpdatingLocation()
    }
    
    //MARK:- IBOutlets
    let locationManager = CLLocationManager()
    var userLocation : CLLocationCoordinate2D?
    var lat = ""
    var lon = ""
    
    @IBOutlet weak var vw_noListAvailable: UIView!
    @IBOutlet weak var txt_search: UITextField!
    @IBOutlet weak var btnback: UIButton!
    @IBOutlet weak var searchbar: UIView!
    @IBOutlet weak var headerview: UIView!
    @IBOutlet weak var exploreMeetupTableView: UITableView!
    
//MARK:- variables
    var ApiData = NSMutableArray()
    var ApiDict = NSMutableDictionary()
    //MARK:- viewDidLoad

    override func viewDidLoad() {
        super.viewDidLoad()
       
        txt_search.delegate = self
        
        self.locationManager.requestAlwaysAuthorization()
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
        
        vw_noListAvailable.isHidden = true
        
        searchbar.layer.cornerRadius = 6
        searchbar.layer.borderWidth = 1
        searchbar.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        headerview.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        headerview.layer.shadowOpacity = 0.5
        headerview.layer.shadowOffset = .zero
        headerview.layer.shadowRadius = 5
        
        // Do any additional setup after loading the view.
    }
    
    
    //MARK:- backBtnAction

    @IBAction func backBtnAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)

    }
    //MARK:- btngotodetails

   
    //MARK:- ApiManager

    func getData(){
        basicFunctions.presentLoader()
        
        let paraDict = NSMutableDictionary()
        paraDict.setValue(Config().api_key, forKey: "api_key")
        paraDict.setValue(Config().AppUserDefaults.value(forKey:"user_id") as? String ?? "", forKey: "user_id")
        paraDict.setValue(self.lat, forKey: "latitude")
        paraDict.setValue(self.lon, forKey: "longitude")
        
        print(paraDict)
        
        let methodName = "get_mini_tribe_meetup_list"
        DataManager.getAPIResponse(paraDict , methodName: methodName, methodType: "POST"){(responseData,error)-> Void in
             let status  = DataManager.getVal(responseData?["status"]) as? String ?? ""
             let message  = DataManager.getVal(responseData?["message"]) as? String ?? ""
                print(message)
             if status == "1" {
                print(DataManager.getVal(responseData?["data"]) as? [String:Any] ?? [:])
                self.ApiData = DataManager.getVal(responseData?["data"]) as? NSMutableArray ?? []
                
//                print("apidict is \(self.ApiDict)")
//                print("apidata is \(self.ApiData)")
               
                
             }
             else {
                print(message)
             }
            self.exploreMeetupTableView.reloadData()
            
            if self.ApiData.count > 0 {
                self.vw_noListAvailable.isHidden = true
                self.exploreMeetupTableView.isHidden = false
            }else{
                self.vw_noListAvailable.isHidden = false
                self.exploreMeetupTableView.isHidden = true
            }
            
            basicFunctions.stopLoading()
    }
    }
    

}
//MARK:- extension

extension ExploreMeetUpVC: UITableViewDataSource,UITableViewDelegate{
    //MARK:- TableViewDataSourceMethods

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(ApiData.count)
        return ApiData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExploreMeetUpcell", for: indexPath) as! ExploreMeetUpcell
        cell.viewcornor.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        cell.viewcornor.layer.shadowOpacity = 0.4
        cell.viewcornor.layer.shadowOffset = .zero
        cell.viewcornor.layer.shadowRadius = 8
        cell.viewcornor.layer.cornerRadius = 10
       
        cell.imguser.layer.cornerRadius = cell.imguser.frame.size.width/2
        
        let apidata = ApiData[indexPath.row]
        ApiDict = apidata as? NSMutableDictionary ?? [:]
        print("apidata is \(ApiDict)")
        cell.lbldate.text = ApiDict["meetup_date"] as? String ?? ""
        cell.lbllocation.text = ApiDict["meetup_location"] as? String ?? ""
        cell.lbltime.text = ApiDict["meetup_time"] as? String ?? ""
        cell.lbldetails.text = ApiDict["meetup_description"] as? String ?? ""
//        cell.lblname.text = ApiDict[""] as? String ?? ""
        cell.lblgoing.text = "\(ApiDict["meetup_going_members"] as? Int ?? 1) People Are Going"
        cell.arr_goingMembers = DataManager.getVal(ApiDict["meetup_going_members_list"]) as? [[String:Any]] ?? []
        
        if cell.arr_goingMembers.count > 0 {
            cell.constraint_width_peopleList.constant = 100
        }else{
            cell.constraint_width_peopleList.constant = 0
        }
        
        cell.imguser.sd_setImage(with: URL(string: "\(Config().baseImageUrl)\(DataManager.getVal(ApiDict["meetup_image"]) as? String ?? "")"), completed: nil)
        
        cell.onlyImages.reloadData()
        
        
        return cell
    }
    //MARK:- DelegateMethods

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
        
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let apidata = ApiData[indexPath.row]
        ApiDict = apidata as? NSMutableDictionary ?? [:]
      
        let vc = self.storyboard?.instantiateViewController(identifier: "MeetUpDetailVC") as! MeetUpDetailVC
        vc.meetupId = DataManager.getVal(ApiDict["id"]) as? String ?? ""
        vc.miniTribeId = DataManager.getVal(ApiDict["mini_tribe_id"]) as? String ?? ""
        navigationController?.pushViewController(vc, animated: true)
    }
}


extension ExploreMeetUpVC : CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last!.coordinate
        
        self.lat = String(location.latitude)
        self.lon = String(location.longitude)
        
        getData()
        
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
                    self.txt_search.text = addressString
                }
            }else{
                print("Eroor aa rahi h location get karne me.")
            }
        })
    }
}

extension ExploreMeetUpVC : UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        txt_search.text = ""
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        present(autocompleteController, animated: true, completion: nil)
    }
}



extension ExploreMeetUpVC : GMSAutocompleteViewControllerDelegate{
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        
        print("Pickup Place name: ", place.name!)
        print("late and long", place.coordinate.latitude)
        print("late and long", place.coordinate.longitude)
//        self.txtlocation.text = place.name ?? ""
        self.lat = String(place.coordinate.latitude)
        self.lon = String(place.coordinate.longitude)
        getData()
        
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

