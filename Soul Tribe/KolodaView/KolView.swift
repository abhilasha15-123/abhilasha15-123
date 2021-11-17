//
//  myView.swift
//  Koloda_Example
//
//  Created by mac-14 on 15/03/21.
//  Copyright © 2021 CocoaPods. All rights reserved.
////abhilasha

import UIKit
import AVKit
import AVFoundation
import CoreLocation

class KolView: UIView,UIScrollViewDelegate {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var Verifiedimg: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var imagePageControl: UIPageControl!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var mainView1: UIView!
    var picturesArray = [String]()
    var videosArray = [String]()
    var titlesArray = [[String: Any]]()
    var memberStatus = String()
    var quesAnsArray = [[String:Any]]()
    var height1 = CGFloat()
    var player = AVPlayer()
    var avpController = AVPlayerViewController()
    
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    
    override init(frame: CGRect) {
        super.init(frame : frame)
        commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder : aDecoder)
        commonInit()
    }
    private func commonInit() {
        Bundle.main.loadNibNamed("KolView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.layer.cornerRadius = 8
        mainView.layer.cornerRadius = 8
        mainView1.layer.cornerRadius = 8
        contentView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
    
    }
    //MARK:- get address from latlong
//    func getAddressFromLatLon(pdblLatitude: String, withLongitude pdblLongitude: String) {
//            var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
//            let lat: Double = Double("\(pdblLatitude)")!
//            let lon: Double = Double("\(pdblLongitude)")!
//            let ceo: CLGeocoder = CLGeocoder()
//            center.latitude = lat
//            center.longitude = lon
//
//            let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
//            ceo.reverseGeocodeLocation(loc, completionHandler:
//                {(placemarks, error) in
//                    if (error != nil)
//                    {
//                        print("reverse geodcode fail: \(error!.localizedDescription)")
//                    }
//                    let pm = placemarks! as [CLPlacemark]
//                    if pm.count > 0 {
//                        let pm = placemarks![0]
//                        print(pm.country as Any)
//                        print(pm.locality as Any)
//                        self.cityLbl.text = pm.locality
//                        if self.cityLbl.text == "" {
//                            self.cityLbl.isHidden = true
//                        }else{
//                            self.cityLbl.isHidden = false
//                        }
//                        print(pm.subLocality as Any)
//                        print(pm.thoroughfare as Any)
//                        print(pm.postalCode as Any)
//                        print(pm.subThoroughfare as Any)
//                        var addressString : String = ""
//                        if pm.subLocality != nil {
//                            addressString = addressString + pm.subLocality! + ", "
//                        }
//                        if pm.thoroughfare != nil {
//                            addressString = addressString + pm.thoroughfare! + ", "
//                        }
//                        if pm.locality != nil {
//                            addressString = addressString + pm.locality! + ", "
//                        }
//                        if pm.country != nil {
//                            addressString = addressString + pm.country! + ", "
//                        }
//                        if pm.postalCode != nil {
//                            addressString = addressString + pm.postalCode! + " "
//                        }
//
//
//                        print(addressString)
//                  }
//            })
//
//        }

}

