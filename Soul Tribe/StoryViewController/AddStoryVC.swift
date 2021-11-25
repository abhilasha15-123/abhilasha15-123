//
//  AddStoryVC.swift
//  StoryDemo
//
//  Created by MAC-25 on 23/11/21.
//

import UIKit
import AssetsPickerViewController
import AssetsLibrary
import Photos
import AVKit
import AVFoundation
import JJFloatingActionButton

class colorCell: UICollectionViewCell{
    @IBOutlet weak var colorview:UIView!
    @IBOutlet weak var indexoneImg: UIImageView!
    @IBOutlet weak var colourBtn:UIButton!
}

class ImageCell: UICollectionViewCell {
    @IBOutlet weak var imageview:UIImageView!
    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var deleteBtn:UIButton!
}

class AddStoryVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    

    @IBOutlet weak var ShareTextView: UIView!
    @IBOutlet weak var typeTextView: UITextView!
    @IBOutlet weak var colourCollectionView: UICollectionView!
    @IBOutlet weak var shareBtn: UIButton!
    @IBOutlet weak var shareImageCameraView: UIView!
    
    @IBOutlet weak var cameraImg: UIImageView!
    @IBOutlet weak var cameraVideoView: UIView!
    @IBOutlet weak var shareImageBtn: UIButton!
    @IBOutlet weak var shareImageGalleryView: UIView!
    @IBOutlet weak var imageGalleryCollectionView: UICollectionView!
    @IBOutlet weak var shareImageGalleryBtn: UIButton!
    
    var selectedColor = String()
    var arr_assets = [PHAsset]()
    var videoarr_assets = [PHAsset]()
    @IBOutlet weak var shareBtnNEW: UIButton!
    var colorArray = ["#FFFFFF","#030303","#A0F27D","#16C79A","#F5972D","#A72FEC","#F66CBA","#242497"]
    var avpController = AVPlayerViewController()
    var player = AVPlayer()
    fileprivate let actionButton = JJFloatingActionButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        shareBtn.layer.cornerRadius =  8
        shareImageBtn.layer.cornerRadius =  8
        shareBtnNEW.layer.cornerRadius =  8
        shareImageGalleryBtn.layer.cornerRadius =  8
        self.ShareTextView.isHidden = false
        self.shareImageCameraView.isHidden = true
        self.shareImageGalleryView.isHidden = true
        let screenWidth = UIScreen.main.bounds.size.width
        let screenHeight = UIScreen.main.bounds.size.height
        let LiberaryLayOut = UICollectionViewFlowLayout()
        LiberaryLayOut.itemSize = CGSize(width: screenWidth/1.5, height: screenHeight/1.5)
        LiberaryLayOut.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        LiberaryLayOut.minimumInteritemSpacing = 5
        LiberaryLayOut.minimumLineSpacing = 0
        LiberaryLayOut.scrollDirection = .vertical
        imageGalleryCollectionView.collectionViewLayout = LiberaryLayOut
                actionButton.buttonColor = UIColor.orange
                   actionButton.addItem(title: "Add Images", image: UIImage(named: "insert-picture-icon")) { item in
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
                       self.present(picker, animated: true, completion: nil)
                   }
                   
                   actionButton.buttonColor = UIColor.orange
                   actionButton.addItem(title: "Add Videos", image: UIImage(named: "video-camera")) { item in
                       
                       let vc = self.storyboard?.instantiateViewController(withIdentifier: "UploadVideoVC") as! UploadVideoVC
                       self.present(vc, animated: true, completion: nil)
                   }
                   actionButton.items[1].buttonColor = UIColor(red: 179/255, green: 110/255, blue: 186/255, alpha: 1.0)
                   actionButton.items[0].buttonColor = UIColor(red: 250/255, green: 203/255, blue: 0/255, alpha: 1.0)
        
        // Do any additional setup after loading the view.
    }
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.colourCollectionView {
            return colorArray.count
        }else{
            return arr_assets.count
        }
    }
    
    @objc func colorChange(_ sender:UIButton){
        self.selectedColor =  colorArray[sender.tag]
        self.typeTextView.textColor = hexStringToUIColor(hex: self.selectedColor)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.colourCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! colorCell
            if indexPath.row == 0 {
                cell.indexoneImg.isHidden = false
                cell.colorview.backgroundColor = .clear
            }else{
                cell.indexoneImg.isHidden = true
                let color =  colorArray[indexPath.row]
                cell.colorview.backgroundColor = hexStringToUIColor(hex: color)
            }
            cell.colourBtn.tag = indexPath.row
            cell.colourBtn.addTarget(self, action: #selector(colorChange(_:)), for: .touchUpInside)
            cell.colorview.layer.cornerRadius = cell.colorview.frame.size.width/2
            cell.colorview.layer.cornerRadius = cell.colorview.frame.size.height/2
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ImageCell
            let asset = arr_assets[indexPath.row]
            if asset.mediaType == .image {
                cell.videoView.isHidden = true
                cell.imageview.isHidden = false
            }else if asset.mediaType == .video {
                cell.videoView.isHidden = false
                cell.imageview.isHidden = true
                
                let img = AddStoryVC.getAssetThumbnail(asset: asset)
//                self.player = AVPlayer(url: img)
//                self.avpController = AVPlayerViewController()
//                self.avpController.player = self.player
//                avpController.view.frame.size.width = cell.videoView.frame.size.width
//                avpController.view.frame.size.height = cell.videoView.frame.size.height
//                self.addChild(avpController)
//                cell.videoView.addSubview(avpController.view)
//                if(player.timeControlStatus == AVPlayer.TimeControlStatus.playing) {
//                    player.pause()
//                } else if(player.timeControlStatus == AVPlayer.TimeControlStatus.paused) {
//                    player.play()
//                }
            }else if asset.mediaType == .unknown {
                cell.videoView.isHidden = false
                cell.imageview.isHidden = false
            }
            cell.imageview.layer.cornerRadius = 8
            let img = AddStoryVC.getAssetThumbnail(asset: asset)
            cell.imageview.image = img
            cell.deleteBtn.tag = indexPath.row
            cell.deleteBtn.addTarget(self, action: #selector(deleteAsset(_:)), for: .touchUpInside)
            return cell
        }
    }
    
    @IBAction func AddCameraImgAction(_ sender: Any) {
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == imageGalleryCollectionView {
            return CGSize(width: imageGalleryCollectionView.frame.width/2.1, height: imageGalleryCollectionView.frame.width/2.1);
        }else{
           return CGSize(width: 50, height: 50)
        }
      

       }
    

    
    
    
    
    @objc func deleteAsset(_ sender : UIButton){
        self.arr_assets.remove(at: sender.tag)
        self.imageGalleryCollectionView.reloadData()
        
    }
    
    class func getAssetThumbnail(asset: PHAsset) -> UIImage {
           
           let manager = PHImageManager.default()
           let option = PHImageRequestOptions()
           var thumbnail = UIImage()
           option.isSynchronous = true
           manager.requestImage(for: asset, targetSize: CGSize(width: asset.pixelWidth, height: asset.pixelHeight), contentMode: .aspectFit, options: option, resultHandler: {(result, info)->Void in
               if let abc = result{
                   thumbnail = abc
               }
           })
           return thumbnail
       }
    
    
    func openCamera()
        {
            if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera))
            {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = UIImagePickerController.SourceType.camera
                imagePicker.mediaTypes = ["public.image", "public.movie"]
                imagePicker.allowsEditing = true
                self.present(imagePicker, animated: true, completion: nil)
            }
            else
            {
                let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    @IBAction func backBtnAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func shareTextBtnAction(_ sender: Any) {
                //post_stories
        
        let parameterDictionary = NSMutableDictionary()
     let userID = Config().AppUserDefaults.value(forKey:"user_id") as? String ?? ""
       parameterDictionary.setValue("tribe123", forKey: "api_key")
        parameterDictionary.setValue(userID, forKey: "user_id")
        parameterDictionary.setValue("", forKey: "stories")
        parameterDictionary.setValue("text", forKey: "type")
        parameterDictionary.setValue(self.selectedColor, forKey: "color_code")
        parameterDictionary.setValue(self.typeTextView.text, forKey: "message")
       print(parameterDictionary)
        let methodName = "post_stories"

        DataManager.getAPIResponse(parameterDictionary , methodName: methodName, methodType: "POST"){(responseData,error)-> Void in
            let status  = DataManager.getVal(responseData?["status"]) as? String ?? ""
            let message  = DataManager.getVal(responseData?["message"]) as? String ?? ""

            if status == "1" {
//                self.wholikeList = DataManager.getVal(responseData?["data"]) as! NSMutableArray
                self.navigationController?.popViewController(animated: true)
            }
            else {
//                 self.view.makeToast(message)
            }
        }
    }
    @IBAction func shareImageCameraBtnAction(_ sender: Any) {
       
    }
    
    @IBAction func shareImagegallryBtn(_ sender: Any) {
        self.view.endEditing(true)
        
        let parameterDictionary = NSMutableDictionary()
        let userID = Config().AppUserDefaults.value(forKey:"user_id") as? String ?? ""
        parameterDictionary.setValue("tribe123", forKey: "api_key")
        parameterDictionary.setValue(userID, forKey: "user_id")
//        parameterDictionary.setValue("", forKey: "stories")
        parameterDictionary.setValue("file", forKey: "type")
        parameterDictionary.setValue("", forKey: "color_code")
        parameterDictionary.setValue("", forKey: "message")
        
                        let arr_images = NSMutableArray()
        
                        for index in 0..<self.arr_assets.count{
                            let asset = arr_assets[index]
                            let img = basicFunctions.getAssetThumbnail(asset: asset)
                            let image1 = img.jpeg(.lowest)
                            
                            let dataDict = NSMutableDictionary()
                            
                            dataDict.setObject("stories", forKey: "keyName" as NSCopying)
                            dataDict.setObject(image1 ?? Data(), forKey: "MyData" as NSCopying)
                            dataDict.setObject("png", forKey: "ext" as NSCopying)
                            arr_images.add(dataDict)
                        }
                    print(parameterDictionary)

                    let  methodName = "post_stories"
                   
                    DataManager.getAPIResponseFileMultipleImageArray(parameterDictionary: parameterDictionary, methodName: methodName, DocimageArray: arr_images){ (responseData,error)-> Void in
                        
                        let status = DataManager.getVal(responseData?["status"]) as! String
                        let message = DataManager.getVal(responseData?["message"]) as! String
                         
                        if status == "1" {
                            self.view.makeToast(message)
                            DispatchQueue.main.asyncAfter(deadline: .now()+1.0, execute: {
                                self.navigationController?.popViewController(animated: true)
                            })
                        }
                        else {
                            self.view.makeToast(message)
                        }
//                        basicFunctions.stopLoading()
                    }
//        print(arr_assets)
//
//
//        let parameterDictionary = NSMutableDictionary()
//     let userID = Config().AppUserDefaults.value(forKey:"user_id") as? String ?? ""
//       parameterDictionary.setValue("tribe123", forKey: "api_key")
//        parameterDictionary.setValue(userID, forKey: "user_id")
//        parameterDictionary.setValue("", forKey: "stories")
//        parameterDictionary.setValue("file", forKey: "type")
//        parameterDictionary.setValue("", forKey: "color_code")
//        parameterDictionary.setValue("", forKey: "message")
//       print(parameterDictionary)
//        let methodName = "post_stories"
//
//        DataManager.getAPIResponse(parameterDictionary , methodName: methodName, methodType: "POST"){(responseData,error)-> Void in
//            let status  = DataManager.getVal(responseData?["status"]) as? String ?? ""
//            let message  = DataManager.getVal(responseData?["message"]) as? String ?? ""
//
//            if status == "1" {
////                self.wholikeList = DataManager.getVal(responseData?["data"]) as! NSMutableArray
//                self.navigationController?.popViewController(animated: true)
//            }
//            else {
////                 self.view.makeToast(message)
//            }
//        }
    }
    @IBAction func AddImage(_ sender: Any) {
         let picker = AssetsPickerViewController()
         let config = AssetsPickerConfig()
         config.albumIsShowEmptyAlbum = false
    
         let options = PHFetchOptions()
     //    options.predicate = NSPredicate(format: "mediaType = %d", PHAssetMediaType.image.rawValue)
         options.sortDescriptors = [NSSortDescriptor(key: "duration", ascending: true)]

         config.assetFetchOptions = [
             .smartAlbum: options,
             .album: options
         ]
        

         picker.pickerConfig = config
         picker.pickerDelegate = self
         present(picker, animated: true, completion: nil)
    }
    
    @IBAction func addtextBtnAction(_ sender: Any) {
        self.ShareTextView.isHidden = false
        self.shareImageCameraView.isHidden = true
        self.shareImageGalleryView.isHidden = true
        actionButton.isHidden = true
        
    }
    
    @IBAction func addImageCameraBtnAction(_ sender: Any) {
        self.ShareTextView.isHidden = true
        self.shareImageCameraView.isHidden = false
        self.shareImageGalleryView.isHidden = true
        actionButton.isHidden = true
        openCamera()
    }
    
    @IBAction func addImagegalleryBtnAction(_ sender: Any) {
        self.ShareTextView.isHidden = true
        self.shareImageCameraView.isHidden = true
        self.shareImageGalleryView.isHidden = false
        actionButton.isHidden = false
        actionButton.display(inView: self.view, bottomInset: 170, trailingInset: 20, safeAreaInset: 20)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension AddStoryVC: AssetsPickerViewControllerDelegate {
    
    func assetsPickerCannotAccessPhotoLibrary(controller: AssetsPickerViewController) {}
    func assetsPickerDidCancel(controller: AssetsPickerViewController) {}
    func assetsPicker(controller: AssetsPickerViewController, didSelect asset: PHAsset, at indexPath: IndexPath) {}
    func assetsPicker(controller: AssetsPickerViewController, didDeselect asset: PHAsset, at indexPath: IndexPath) {}
    
    func assetsPicker(controller: AssetsPickerViewController, shouldDeselect asset: PHAsset, at indexPath: IndexPath) -> Bool {
        return true
    }
    
    func assetsPicker(controller: AssetsPickerViewController, shouldSelect asset: PHAsset, at indexPath: IndexPath) -> Bool {
        
            if controller.selectedAssets.count >= 5 {
                return false
            }else{
                return true
            }
        
    }
    
    func assetsPicker(controller: AssetsPickerViewController, selected assets: [PHAsset]) {
        for i in 0..<assets.count {
            let asset = assets[i]
            if asset.mediaType == .image {
                
                arr_assets.append(asset)
            }else{
                videoarr_assets.append(asset)
            }
        }
        
        arr_assets = assets
        print(arr_assets)
        print(videoarr_assets)
        imageGalleryCollectionView.reloadData()
    }
}


extension AddStoryVC: UIImagePickerControllerDelegate,UINavigationControllerDelegate {

     func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if picker.mediaTypes == ["public.image"] {
            guard let image = info[.originalImage] as? UIImage else { return }
                        //Change aspect when not dummy image
            self.cameraImg.contentMode = .scaleAspectFill
            self.cameraImg.clipsToBounds = true
            self.cameraImg.image = image
            picker.dismiss(animated: true)
        }else{
            let videoURL = info[.mediaURL] as? NSURL
            print(videoURL)
            let asset = AVURLAsset(url: videoURL as! URL , options: nil)
                    let imgGenerator = AVAssetImageGenerator(asset: asset)
                    imgGenerator.appliesPreferredTrackTransform = true
            let cgImage = try! imgGenerator.copyCGImage(at: CMTimeMake(value: 0, timescale: 1), actualTime: nil)
                    let thumbnail = UIImage(cgImage: cgImage)
            self.player = AVPlayer(url: videoURL as! URL)
           self.avpController = AVPlayerViewController()
           self.avpController.player = self.player
           avpController.view.frame.size.width =  self.cameraVideoView.frame.size.width
           avpController.view.frame.size.height =  self.cameraVideoView.frame.size.height
           self.addChild(avpController)
           self.cameraVideoView.addSubview(avpController.view)
            cameraImg.image = thumbnail
            if(player.timeControlStatus == AVPlayer.TimeControlStatus.playing) {
                   player.pause()
               } else if(player.timeControlStatus == AVPlayer.TimeControlStatus.paused) {
                   player.play()
               }
            picker.dismiss(animated: true)
        }
       
    }
    
}



extension UIImage {
    enum JPEGQuality: CGFloat {
        case lowest  = 0
        case low     = 0.25
        case medium  = 0.5
        case high    = 0.75
        case highest = 1
    }

    /// Returns the data for the specified image in JPEG format.
    /// If the image object’s underlying image data has been purged, calling this function forces that data to be reloaded into memory.
    /// - returns: A data object containing the JPEG data, or nil if there was a problem generating the data. This function may return nil if the image has no data or if the underlying CGImageRef contains data in an unsupported bitmap format.
    func jpeg(_ jpegQuality: JPEGQuality) -> Data? {
        return jpegData(compressionQuality: jpegQuality.rawValue)
    }
}
        
