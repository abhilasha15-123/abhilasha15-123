//
//  LocationAccessVC.swift
//  Soul Tribe
//
//  Created by Ashish Soni on 29/06/21.
//

import UIKit
import CoreLocation


class LocationAccessVC: UIViewController {
    @IBOutlet weak var btnconfirmlocation: UIButton!
    @IBOutlet weak var searchview: UIView!
//    @IBOutlet weak var vw_mapView: MKMapView!


    @IBAction func btn_currentLocation(_ sender: UIButton) {
        
    }
    
    
    let locationManager = CLLocationManager()
    var userLocation : CLLocationCoordinate2D?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    @IBAction func btnlocation(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(identifier: "SetprofileVC") as! SetprofileVC
        navigationController?.pushViewController(vc, animated: true)
       // self.view.addSubview(popupview)
        //popupview.isHidden = false
    }
    @IBAction func btnBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)

    }

   

}


extension LocationAccessVC : CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last!
//        vw_mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 15.0)
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
