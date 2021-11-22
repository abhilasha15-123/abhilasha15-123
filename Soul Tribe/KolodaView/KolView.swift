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

class KolView: UIView,UIScrollViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    

    @IBOutlet var contentView: UIView!
    @IBOutlet var menuoptionView: UIView!
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var imagePageControl: UIPageControl!
    @IBOutlet weak var firstImpressionLbl: UILabel!

    @IBOutlet weak var ageLbl: UILabel!
    @IBOutlet weak var cityBtn: UIButton!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var mainView1: UIView!
    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var hobbiesCollectionView: UICollectionView!
    @IBOutlet weak var menuOptionReportBtn: UIButton!
    @IBOutlet weak var menuOptionBlockUserBtn: UIButton!
    @IBOutlet weak var menuOptionViewProfileBtn: UIButton!
    @IBOutlet weak var ClickonOptionViewBtn: UIButton!
    @IBOutlet weak var bottomViewProfileBtn: UIButton!
    @IBOutlet weak var BtnLeftSwipe: UIButton!
    @IBOutlet weak var BtnRightSwipe: UIButton!
    
    var picturesArray = [String]()
    var hobbiesArray = [String]()
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
        menuoptionView.isHidden = true
        menuoptionView.layer.cornerRadius = 8
        
        contentView.frame = self.bounds
        contentView.layer.cornerRadius = 8
        mainView.layer.cornerRadius = 8
        mainView1.layer.cornerRadius = 8
        contentView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        
        let QuesAnsoLayOut = UICollectionViewFlowLayout()
//        QuesAnsoLayOut.itemSize = CGSize(width: screenWidth-55, height: 250)
        QuesAnsoLayOut.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//        QuesAnsoLayOut.minimumInteritemSpacing = 5
//        QuesAnsoLayOut.minimumLineSpacing = 5
        QuesAnsoLayOut.scrollDirection = .vertical
        
        let Questnib = UINib(nibName: "HeaderCollectionCell", bundle: nil)
        self.imageCollectionView.register(Questnib, forCellWithReuseIdentifier: "HeaderCollectionCell")
        self.imageCollectionView.collectionViewLayout = QuesAnsoLayOut
        self.imageCollectionView.delegate = self
        imageCollectionView.clipsToBounds = true
        self.imageCollectionView.dataSource = self
        self.imageCollectionView.isPagingEnabled = true
        
        
        let hobbiesLayOut = UICollectionViewFlowLayout()
//        QuesAnsoLayOut.itemSize = CGSize(width: screenWidth-55, height: 60)
        QuesAnsoLayOut.sectionInset = UIEdgeInsets(top: 10, left: 5, bottom: 0, right: 10)
//        QuesAnsoLayOut.minimumInteritemSpacing = 5
//        QuesAnsoLayOut.minimumLineSpacing = 5
//        QuesAnsoLayOut.scrollDirection = .horizontal
        
        let hobbiesNib = UINib(nibName: "HobbiesCollectionCell", bundle: nil)
        self.hobbiesCollectionView.register(hobbiesNib, forCellWithReuseIdentifier: "HobbiesCollectionCell")
        self.hobbiesCollectionView.collectionViewLayout = hobbiesLayOut
        self.hobbiesCollectionView.delegate = self
        hobbiesCollectionView.clipsToBounds = true
        self.hobbiesCollectionView.dataSource = self
        self.hobbiesCollectionView.isPagingEnabled = true
    
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
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if collectionView == self.imageCollectionView{
            self.imagePageControl.currentPage = indexPath.item
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == imageCollectionView {
            imagePageControl.numberOfPages = self.picturesArray.count
             imagePageControl.isHidden = !(self.picturesArray.count > 1)
             return picturesArray.count
        }else{
            return 5
        }
    }
    
    

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.hobbiesCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HobbiesCollectionCell", for: indexPath) as! HobbiesCollectionCell
            cell.tag = indexPath.row
            cell.ContentView.layer.cornerRadius = 8
            cell.hob_Title.text = self.hobbiesArray[indexPath.row]
            cell.hob_Img.image = UIImage(named: self.hobbiesArray[indexPath.row])
            cell.layer.cornerRadius = 8
            cell.clipsToBounds = true
    //        Config().setimage(name: DataManager.getVal(self.picturesArray[indexPath.row]) as? String ?? "", image: cell.imgView)
            
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeaderCollectionCell", for: indexPath) as! HeaderCollectionCell
            cell.tag = indexPath.row
            cell.clipsToBounds = true
            
    //        Config().setimage(name: DataManager.getVal(self.picturesArray[indexPath.row]) as? String ?? "", image: cell.imgView)
            cell.imgView.layer.cornerRadius = 8
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
         if collectionView == self.imageCollectionView{
            return CGSize(width: screenWidth-60, height: 350)
        }else if collectionView == self.hobbiesCollectionView{
            return CGSize(width: screenWidth/3-50, height: 30)
        }else{
            return CGSize(width: screenWidth-60, height: 190)
        }
    }

}

