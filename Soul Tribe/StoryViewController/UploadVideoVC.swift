//
//  UploadVideoVC.swift
//  TuVozNow
//
//  Created by mac-14 on 10/04/20.
//  Copyright © 2020 zokoo. All rights reserved.
//

import UIKit
import Photos
import PhotosUI
import AVKit
import AVFoundation
class UploadVideoVC: UIViewController, PHPhotoLibraryChangeObserver {
    //MARK: Outlets
    @IBOutlet weak var CollectionVideo: UICollectionView!
    @IBOutlet weak var collectionBGView: UIView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var AddButton : UIButton!
    
    //MARK: Variables
    var photos: PHFetchResult<PHAsset>?
    
    var VideoURL = [URL]()
    var thumbnailImage = UIImage()
    var collectionArray = [PHAsset]() {
        didSet{
            DispatchQueue.main.async {
                self.CollectionVideo.reloadData()
            }
        }
    }
    
    //MARK: View Contoller Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        checkPermission()
        PHPhotoLibrary.shared().register(self)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.currencyImagePer(_:)), name: NSNotification.Name("CloseView"), object: nil)
        
    }
    
    @objc func currencyImagePer(_ pNotification: Notification?) {
        self.dismiss(animated: false, completion: nil)
    }
    
    func checkPermission(){
        if #available(iOS 14, *) {
            let status = PHPhotoLibrary.authorizationStatus(for: .readWrite)
            switch status {
            case .authorized:
                DispatchQueue.main.async {
                    self.AddButton.isHidden = true
                }
            case .denied, .restricted:
                DispatchQueue.main.async {
                    self.AddButton.isHidden = true
                }
            case .notDetermined:
                DispatchQueue.main.async {
                    self.AddButton.isHidden = true
                }
            case .limited:
                DispatchQueue.main.async {
                    self.AddButton.isHidden = false
                    self.descriptionLabel.text = LocalizedStringKeys.selectPhotoDescrition
                }
            default:
                DispatchQueue.main.async {
                    self.AddButton.isHidden = false
                    self.descriptionLabel.text = LocalizedStringKeys.selectPhotoDescrition
                }
            }
        } else {
            let status = PHPhotoLibrary.authorizationStatus()
            switch status {
            case .authorized:
                DispatchQueue.main.async {
                    self.AddButton.isHidden = true
                }
            case .denied, .restricted:
                DispatchQueue.main.async {
                    self.AddButton.isHidden = true
                }
            case .notDetermined:
                DispatchQueue.main.async {
                    self.AddButton.isHidden = true
                }
            case .limited:
                DispatchQueue.main.async {
                    self.AddButton.isHidden = false
                    self.descriptionLabel.text = LocalizedStringKeys.selectPhotoDescrition
                }
            default:
                DispatchQueue.main.async {
                    self.AddButton.isHidden = false
                    self.descriptionLabel.text = LocalizedStringKeys.selectPhotoDescrition
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NavigationBarDesign()
        CollectionVideo.register(UINib(nibName: NibIdentifiers.GalleryCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: CellIdentifiers.GalleryCollectionViewCell)
        CollectionVideo.delegate = self
        CollectionVideo.dataSource = self
        
        descriptionLabel.text = LocalizedStringKeys.selectPhotoDescrition
      //  descriptionLabel.setCostomFontSize(size: 18)
        GetAllVideo()
    }
    
    //MARK: Functions
    func NavigationBarDesign()  {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
//        //Left Button
//        let symbolView = UIImageView(image: UIImage(named: "APP_Symbol"))
//        symbolView.contentMode = .scaleAspectFit
//        self.navigationItem.leftBarButtonItems = [UIBarButtonItem(customView: symbolView)]
//
//
        
        
        navigationController?.navigationBar.barTintColor = UIColor.lightGray
        
              let btn1 = UIBarButtonItem()
//              let btn2 = UIBarButtonItem()
              
              btn1.title = "Back"
//              btn2.title = "Video"
              
              btn1.target = self
              btn1.action = #selector(backClickedHome)
              
//              btn1.target = self
//              btn1.action = #selector(blogClicked)
//
              
              self.navigationItem.leftBarButtonItems = [btn1]

      
        
        
        
        
        //Tab Bar
        self.tabBarController?.tabBar.isHidden = false
    }

    @objc func blogClicked(){
           print("hi")
         
           
       }
    
    
    @objc func backClickedHome(){
          print("hi")
          self.tabBarController?.selectedIndex = 0
         }


    
    func GetAllVideo() {
       // ShowLoaderOnView()
        let options = PHFetchOptions()
        options.sortDescriptors = [ NSSortDescriptor(key: "creationDate", ascending: false) ]
        options.predicate = NSPredicate(format: "mediaType = %d", PHAssetMediaType.video.rawValue)
        options.includeAssetSourceTypes = [.typeUserLibrary,.typeiTunesSynced, .typeCloudShared,]
        self.collectionArray.removeAll()
        self.VideoURL.removeAll()
        photos = PHAsset.fetchAssets(with: options)
        if photos?.count ?? 0 > 0  {
            for i in 0...(photos?.count ?? 1) - 1 {
                let asset = photos!.object(at: i)
                PHImageManager.default().requestAVAsset(forVideo: asset, options: nil) { (a, b, c) in
                    if let urlAsset = a as? AVURLAsset {
                        self.collectionArray.append(asset)
                        self.VideoURL.append(urlAsset.url)
                    }
                }
            }
            
            DispatchQueue.main.async {
                self.CollectionVideo.reloadData()
               // HideLoaderOnView()
            }
        }else{
          //  HideLoaderOnView()
            
            DispatchQueue.main.async {
                self.descriptionLabel.text = LocalizedStringKeys.noPhotosDescription
            }
            AddButton.isHidden = true
        }
    }

    
    func GetVideoDetails(index: Int) -> UploadVideoData {
        var imageData = Data()
        imageData = thumbnailImage.jpegData(compressionQuality: 1.0) ?? Data()
        let videoFileName = VideoURL[index].lastPathComponent
        let pathExtention = videoFileName.fileExtension()
        var videoType = ""
        switch pathExtention.lowercased() {
        case "mp4":
            videoType = MimeTypes.mp4
        case "ogx":
            videoType = MimeTypes.ogx
        case "oga":
            videoType = MimeTypes.oga
        case "ogv":
            videoType = MimeTypes.ogv
        case "ogg":
            videoType = MimeTypes.ogg
        case "webm":
            videoType = MimeTypes.webm
        case "mkv":
            videoType = MimeTypes.mkv
        case "wom":
            videoType = MimeTypes.wom
        case "mov":
            videoType = MimeTypes.mov
        default:
            print("VideoTypeNowAllowed")
        }
        
        return UploadVideoData(imageData: imageData, videoURL: VideoURL[index], imageType: MimeTypes.jpeg, videoType: videoType, title: "", description: "", countryName: "", isAnonymous: 0, myduration: "")
    }
    
    func getImage(asset: PHAsset) -> UIImage {
        var image = UIImage()
        let size = CGSize(width:200, height:200)
        PHImageManager.default().requestImage(for: asset, targetSize: size, contentMode: PHImageContentMode.aspectFit, options: nil) { (img, userInfo) -> Void in
            image = img ?? UIImage()
            print("Video selected")
        }
        return image
    }
    
    func getDuration(asset: PHAsset) -> TimeInterval {
        return asset.duration
    }
    
    
    @IBAction func closeButtonTapped(_ sender: UIButton){
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        if #available(iOS 14, *) {
            PHPhotoLibrary.shared().presentLimitedLibraryPicker(from: self)
        } else {
            // Fallback on earlier versions
        }
    }
    
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        print("libray change")
        GetAllVideo()
    }
    
    @objc func bellTapped(_ sender: UIBarButtonItem){
        print("Development is in progress.")
    }
    
    @objc func searchTapped(_ sender: UIBarButtonItem){
        print("Development is in progress.")
    }
}
//MARK: Collection View Extension
extension UploadVideoVC: UICollectionViewDelegate , UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // photos?.count ?? 0
        return collectionArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifiers.GalleryCollectionViewCell, for: indexPath) as! GalleryCollectionViewCell
        let asset = collectionArray[indexPath.row]
        let width: CGFloat = 200
        let height: CGFloat = 200
        let size = CGSize(width:width, height:height)
        
        PHImageManager.default().requestImage(for: asset, targetSize: size, contentMode: PHImageContentMode.aspectFit, options: nil) { (image, userInfo) -> Void in
            cell.imgThumbnail.image = image
            cell.backgroundColor = .black
            cell.timeLabel.backgroundColor = UIColor(white: 1, alpha: 0.5)
            cell.timeLabel.textAlignment = .right
            cell.timeLabel.textColor = .black
            cell.timeLabel.font = UIFont.boldSystemFont(ofSize: 13)
            cell.timeLabel.text = "\(String(format: "%02d:%02d",Int((asset.duration / 60)),Int(asset.duration) % 60))"
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let asset = collectionArray[indexPath.row]
        let size = CGSize(width:200, height:200)
        PHImageManager.default().requestImage(for: asset, targetSize: size, contentMode: PHImageContentMode.aspectFit, options: nil) { (image, userInfo) -> Void in
            self.thumbnailImage = image ?? UIImage()
        }
        let trimVC = self.storyboard?.instantiateViewController(withIdentifier: ViewContollerIdentifiers.TrimerViewController) as! TrimerViewController
        trimVC.videoDetails = GetVideoDetails(index: indexPath.row)
        trimVC.asset = collectionArray[indexPath.row]
        
        self.present(trimVC, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  21
        let collectionwidht = self.CollectionVideo.frame.width - padding
        return CGSize(width: collectionwidht/3, height: collectionwidht/3)
    }
}
