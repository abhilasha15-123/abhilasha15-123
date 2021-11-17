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
    @IBOutlet var menuoptionView: UIView!
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var imagePageControl: UIPageControl!
    @IBOutlet weak var firstImpressionLbl: UILabel!
    @IBOutlet weak var hobbyView1: UIView!
    @IBOutlet weak var hobbyView2: UIView!
    @IBOutlet weak var hobbyView3: UIView!
    @IBOutlet weak var hobbyView4: UIView!
    @IBOutlet weak var hobbyView5: UIView!
    @IBOutlet weak var hobbyView6: UIView!
    @IBOutlet weak var hobbyImg1: UIImageView!
    @IBOutlet weak var hobbyImg2: UIImageView!
    @IBOutlet weak var hobbyImg3: UIImageView!
    @IBOutlet weak var hobbyImg4: UIImageView!
    @IBOutlet weak var hobbyImg5: UIImageView!
    @IBOutlet weak var hobbyImg6: UIImageView!
    @IBOutlet weak var hobbyLbl1: UILabel!
    @IBOutlet weak var hobbyLbl2: UILabel!
    @IBOutlet weak var hobbyLbl3: UILabel!
    @IBOutlet weak var hobbyLbl4: UILabel!
    @IBOutlet weak var hobbyLbl5: UILabel!
    @IBOutlet weak var hobbyLbl6: UILabel!
    @IBOutlet weak var cityBtn: UIButton!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var mainView1: UIView!
    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var menuOptionReportBtn: UIButton!
    @IBOutlet weak var menuOptionBlockUserBtn: UIButton!
    @IBOutlet weak var menuOptionViewProfileBtn: UIButton!
    @IBOutlet weak var ClickonOptionViewBtn: UIButton!
    @IBOutlet weak var bottomViewProfileBtn: UIButton!
    @IBOutlet weak var BtnLeftSwipe: UIButton!
    @IBOutlet weak var BtnRightSwipe: UIButton!
    
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
//        menuoptionView.isHidden = true
        menuoptionView.layer.cornerRadius = 8
        hobbyView1.layer.cornerRadius = 8
        hobbyView2.layer.cornerRadius = 8
        hobbyView3.layer.cornerRadius = 8
        hobbyView4.layer.cornerRadius = 8
        hobbyView5.layer.cornerRadius = 8
        hobbyView6.layer.cornerRadius = 8
        contentView.frame = self.bounds
        contentView.layer.cornerRadius = 8
        mainView.layer.cornerRadius = 8
        mainView1.layer.cornerRadius = 8
        contentView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
    
    }
    @IBAction func leftSwipeAction(_ sender: Any) {
    }
    @IBAction func rightSwipeAction(_ sender: Any) {
    }
    @IBAction func viewProfileAction(_ sender: Any) {
    }
    
    
    
    @IBAction func menuOptionAction(_ sender: Any) {
    }
    @IBAction func menuOptionreport(_ sender: Any) {
    }
    @IBAction func menuOptionBlock(_ sender: Any) {
    }
    @IBAction func menuOptionViewProfile(_ sender: Any) {
        
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

