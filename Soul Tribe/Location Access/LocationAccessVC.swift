//
//  LocationAccessVC.swift
//  Soul Tribe
//
//  Created by Ashish Soni on 29/06/21.
//

import UIKit
import CoreLocation
import GoogleMaps
import GooglePlaces

class LocationAccessVC: UIViewController,GMSAutocompleteViewControllerDelegate {
    @IBOutlet weak var btnconfirmlocation: UIButton!
    @IBOutlet weak var searchview: UIView!
    @IBOutlet weak var vw_map: GMSMapView!
    @IBOutlet weak var lbl_address: UILabel!
    
    
    @IBAction func btn_confirmLocationAction(_ sender: UIButton) {
        if self.lon != "" && self.lat != "" {
            
            basicFunctions.presentLoader()

            let parameterDictionary = NSMutableDictionary()
            parameterDictionary.setValue(userId, forKey: "user_id")
            parameterDictionary.setValue(Config().api_key, forKey: "api_key")
            parameterDictionary.setValue(lbl_address.text ?? "", forKey: "address")
            parameterDictionary.setValue(self.lat, forKey: "lat")
            parameterDictionary.setValue(self.lon, forKey: "lng")
            parameterDictionary.setValue(self.city, forKey: "city")
            parameterDictionary.setValue(self.state, forKey: "state")
            parameterDictionary.setValue(self.country, forKey: "country")
                        
            print(parameterDictionary)

            let methodName = "update_location"

            DataManager.getAPIResponse(parameterDictionary , methodName: methodName, methodType: "POST"){(responseData,error)-> Void in
                let status  = DataManager.getVal(responseData?["status"]) as! String
                let message  = DataManager.getVal(responseData?["message"]) as! String

                if status == "1" {
                    self.view.makeToast(message)

                    DispatchQueue.main.asyncAfter(deadline: .now()+1.5, execute: {
                        let vc = self.storyboard?.instantiateViewController(identifier: "SetprofileVC") as! SetprofileVC
                        self.navigationController?.pushViewController(vc, animated: true)
                    })
                }
                else {
                    self.view.makeToast(message, duration: 2.0, position: .bottom, title: nil, image: nil, style: ToastManager.shared.style, completion: nil)
                }
//                self.removeSpinner()
            basicFunctions.stopLoading()
            }
        }else{
            self.view.makeToast("Please select the location.")
        }
    }
    
    @IBAction func btn_currentLocation(_ sender: UIButton) {
        locationManager.startUpdatingLocation()
    }
    
    let locationManager = CLLocationManager()
    var userLocation : CLLocationCoordinate2D?
  
    var city = ""
    var country = ""
    var zipcode = ""
    var state = ""
    var area = ""
    var marker = GMSMarker()
    var lat = ""
    var lon = ""
    var userId = ""
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userId = DataManager.getVal(Config().AppUserDefaults.value(forKey:"user_id")) as? String ?? ""
        
        vw_map.delegate = self
        
        lbl_address.isUserInteractionEnabled = true

        let tap =  UITapGestureRecognizer(target: self, action: #selector(searchLocation))
        lbl_address.addGestureRecognizer(tap)
        
        
       // innerview.layer.cornerRadius = 8
        searchview.layer.cornerRadius = 5
        searchview.layer.borderWidth = 0.5
        searchview.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
       // btncreate.layer.cornerRadius = 5
        
        self.locationManager.requestAlwaysAuthorization()
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }

        // Do any additional setup after loading the view.
    }
  
    @IBAction func btnBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

    @objc func searchLocation(){
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        present(autocompleteController, animated: true, completion: nil)
    }
   

}


extension LocationAccessVC : CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last!.coordinate
        
        self.lat = String(location.latitude)
        self.lon = String(location.longitude)
        
        
        vw_map.camera = GMSCameraPosition(target: location, zoom: 15.0)
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
}


extension LocationAccessVC : GMSMapViewDelegate{

    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        marker.map = nil

        marker = GMSMarker(position: position.target)
        marker.snippet = "\(position.target)"
        marker.icon = UIImage(named: "pin")
        marker.map = vw_map
        
        
        self.lat = String(position.target.latitude)
        self.lon = String(position.target.longitude)
        
        userLocation = position.target
        getAddressFromLatLon(pdblLatitude: "\(position.target.latitude)", withLongitude: "\(position.target.longitude)")
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
                        self.area = pm.subLocality!
                    }
                    if pm.thoroughfare != nil {
                        //area
                        addressString = addressString + pm.thoroughfare! + ", "
                    }else{
                    }
                    if pm.locality != nil {
                        //city
                        addressString = addressString + pm.locality! + ", "
                        self.city = pm.locality!
                    }
                    else{
                    }
                   
                    if pm.administrativeArea != nil {
                        //city
                        addressString = addressString + pm.administrativeArea! + ", "
                        self.state = pm.administrativeArea!
                    }
                    else{
                    }
                    
                    
                    if pm.country != nil {
                        addressString = addressString + pm.country! + " "
                        self.country = pm.country!
                    }
                    else{
                    }
                        
                    if pm.postalCode != nil {
                        addressString = addressString + pm.postalCode!
                        self.zipcode = pm.postalCode!
                    }else{
                    }
                    print(addressString)
                    self.lbl_address.text = addressString
                }
            }else{
                print("Eroor aa rahi h location get karne me.")
            }
        })
    }
    
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {

        print("Pickup Place name: ", place.name!)
        print("late and long", place.coordinate.latitude)
        print("late and long", place.coordinate.longitude)
        
        self.lat = String(place.coordinate.latitude)
        self.lon = String(place.coordinate.longitude)

        vw_map.camera = GMSCameraPosition(latitude: place.coordinate.latitude, longitude: place.coordinate.longitude, zoom: 15.0)
        
        getAddressFromLatLon(pdblLatitude: self.lat, withLongitude: self.lon)

        dismiss(animated: true, completion: nil)
    }

    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print("Error: ", error.localizedDescription)
    }
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }

//    // Turn the network activity indicator on and off again.
//    func didRequestAutocompletePredictionsForResultsController(resultsController: GMSAutocompleteResultsViewController) {
//        UIApplication.shared.isNetworkActivityIndicatorVisible = true
//    }
//
//    func didUpdateAutocompletePredictionsForResultsController(resultsController: GMSAutocompleteResultsViewController) {
//        UIApplication.shared.isNetworkActivityIndicatorVisible = true
//    }
    
    
    
}

