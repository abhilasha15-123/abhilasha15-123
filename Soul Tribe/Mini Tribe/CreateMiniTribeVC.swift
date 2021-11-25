//
//  CreateMiniTribeVC.swift
//  Soul Tribe
//
//  Created by Ashish Soni on 29/06/21.
//

import UIKit
import OnlyPictures
import AssetsPickerViewController
import Photos

class CreateMiniTribeVC: UIViewController {

    @IBAction func btn_publicAction(_ sender: UIButton) {
        btnpublic.isSelected = !btnpublic.isSelected
        
        if btnpublic.isSelected == true{
            btnprivate.isSelected = false
            visibleStatus = "2"
        }else{
            btnprivate.isSelected = true
            visibleStatus = "1"
        }
       
        
    }
    @IBAction func btn_privateAction(_ sender: UIButton) {
        btnprivate.isSelected = !btnprivate.isSelected
        
        if btnprivate.isSelected == true{
            btnpublic.isSelected = false
            visibleStatus = "1"
        }else{
            btnpublic.isSelected = true
            visibleStatus = "2"
        }
    }
    
    
    
    var picSelected : Bool = false
    var idaar:String!
    var arr_invitedMembers = [[String:Any]]()
    var visibleStatus = "2"
    
    @IBOutlet weak var img_disp: UIImageView!
    @IBOutlet weak var Btnback: UIButton!
    @IBOutlet weak var btneditprofile: UIButton!
    @IBOutlet weak var txtname: UITextField!
    @IBOutlet weak var txtdiscription: UITextView!
    @IBOutlet weak var viewprivate: UIView!
    @IBOutlet weak var btnprivate: UIButton!
    @IBOutlet weak var viewpublic: UIView!
    @IBOutlet weak var btnpublic: UIButton!
    @IBOutlet weak var btninvitemember: UIButton!
    //@IBOutlet weak var imgmember: UIImageView!
    @IBOutlet weak var btncreatetribe: UIButton!
    @IBOutlet weak var onlyImages: OnlyHorizontalPictures!
    
    @IBAction func btn_createMiniTribeAction(_ sender: UIButton) {
        if ValidationClass().ValidateCreateMiniTribe(self){
           
            self.idaar = ""
            for dict in arr_invitedMembers{
                let id = DataManager.getVal(dict["id"]) as? String ?? ""
                self.idaar.append("\(id),")
            }
            if self.idaar != ""{
                self.idaar.removeLast()
            }
       
            
            basicFunctions.presentLoader()
            self.view.endEditing(true)
            let paraDict = NSMutableDictionary()
            paraDict.setValue(Config().api_key, forKey: "api_key")
            paraDict.setValue(Config().AppUserDefaults.value(forKey:"user_id") as? String ?? "", forKey: "user_id")
            paraDict.setValue(self.txtname.text ?? "" , forKey: "name")
            paraDict.setValue(self.txtdiscription.text ?? "", forKey: "about")
            paraDict.setValue(visibleStatus, forKey: "visibility_status")
            paraDict.setValue(self.idaar, forKey: "invite_ids")
  
            
            //For upload image
            let dataArr = NSMutableArray()
            let dataDict = NSMutableDictionary()
            dataDict.setObject("mini_tribe_image", forKey: "image" as NSCopying)
            dataDict.setObject(self.img_disp.image!.pngData()!, forKey: "imageData" as NSCopying)
            dataDict.setObject("png", forKey: "ext" as NSCopying)
            dataArr.add(dataDict)
            
            print(paraDict)
            
            
            let methodName = "create_mini_tribe"
            DataManager.getAPIResponseFileSingleImage(paraDict, methodName: methodName as NSString, dataArray: dataArr, success:{ (responseData,error)-> Void in
          //  DataManager.getAPIResponse(paraDict , methodName: methodName, methodType: "POST"){(responseData,error)-> Void in
                let status  = DataManager.getVal(responseData?["status"]) as? String ?? ""
                let message  = DataManager.getVal(responseData?["message"]) as? String ?? ""
                print(message)
                if status == "1" {
                    print(DataManager.getVal(responseData?["data"]) as? [String:Any] ?? [:])
                    self.view.makeToast(message)
                    DispatchQueue.main.asyncAfter(deadline: .now()+1.0, execute: {
                        self.navigationController?.popViewController(animated: true)
                    })
                }
                else {
                    print(message)
                }
                        basicFunctions.stopLoading()
            })
        }
    }
   
    @IBAction func btn_inviteMembersAction(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(identifier: "InviteMemberVC") as! InviteMemberVC
        //navigationController?.pushViewController(vc, animated: true)
        vc.modalTransitionStyle = .coverVertical
        vc.modalPresentationStyle = .overFullScreen
        vc.comesFrom = "tribe"
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func btn_selectPictureAction(_ sender: UIButton) {
      
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
        present(picker, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        onlyImages.alignment = .right
    
        
        btnpublic.isSelected = true
        btnprivate.isSelected = false
        visibleStatus = "2"
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.currencyImagePer1(_:)), name: NSNotification.Name("memberdata1"), object: nil)
        
        img_disp.layer.cornerRadius = img_disp.frame.size.width/2
        img_disp.contentMode = .scaleToFill
        
        //Do any additional setup after loading the view.
        viewprivate.layer.cornerRadius = 5
        viewprivate.layer.borderWidth = 1
        viewprivate.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
      //imgmember.layer.cornerRadius = 50
        
        viewpublic.layer.cornerRadius = 5
        viewpublic.layer.borderWidth = 1
        viewpublic.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
     
        txtname.layer.cornerRadius = 5
        txtname.layer.borderWidth = 1
        txtname.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        txtdiscription.layer.cornerRadius = 5
        txtdiscription.layer.borderWidth = 1
        txtdiscription.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        

        txtdiscription.delegate = self
        txtdiscription.text = "Describe your Mini Tribe"
        txtdiscription.textColor = UIColor.lightGray
        
        txtdiscription.delegate = self
        onlyImages.dataSource = self
        onlyImages.reloadData()
    }
    
    @objc func currencyImagePer1(_ pNotification: Notification) {
        
        if let extractInfo = pNotification.userInfo {
            self.arr_invitedMembers = extractInfo["data"] as? [[String:Any]] ?? []
        }
        onlyImages.reloadData()
    }
    
    
    @IBAction func backBtnAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    

}



extension CreateMiniTribeVC: AssetsPickerViewControllerDelegate {
    
    func assetsPickerCannotAccessPhotoLibrary(controller: AssetsPickerViewController) {}
    func assetsPickerDidCancel(controller: AssetsPickerViewController) {}
    func assetsPicker(controller: AssetsPickerViewController, didSelect asset: PHAsset, at indexPath: IndexPath) {}
    func assetsPicker(controller: AssetsPickerViewController, didDeselect asset: PHAsset, at indexPath: IndexPath) {}
    
    func assetsPicker(controller: AssetsPickerViewController, shouldDeselect asset: PHAsset, at indexPath: IndexPath) -> Bool {
        return true
    }
    
    func assetsPicker(controller: AssetsPickerViewController, shouldSelect asset: PHAsset, at indexPath: IndexPath) -> Bool {
       
        if controller.selectedAssets.count > 0 {
            controller.photoViewController.deselectAll()
        }
        return true
    }
    
    func assetsPicker(controller: AssetsPickerViewController, selected assets: [PHAsset]) {
       
        let img = basicFunctions.getAssetThumbnail(asset: assets[0])
        self.img_disp.image = img
        picSelected = true
    }
}


extension CreateMiniTribeVC : UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        if txtdiscription.text == "Describe your Mini Tribe" {
            txtdiscription.text = ""
            txtdiscription.textColor = .black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if txtdiscription.text == "" {
            txtdiscription.text = "Describe your Mini Tribe"
            txtdiscription.textColor = #colorLiteral(red: 0.7242062092, green: 0.7242915034, blue: 0.7241678834, alpha: 1)
        }
    }
}


extension CreateMiniTribeVC: OnlyPicturesDataSource {

    // ---------------------------------------------------
    // returns the total no of pictures
    
    func numberOfPictures() -> Int {
        return arr_invitedMembers.count
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
    
        let dict = arr_invitedMembers[index]
        let urlStr = "\(Config().baseImageUrl)\(DataManager.getVal(dict["profile_image"]) as? String ?? "")"
       
        imageView.image = #imageLiteral(resourceName: "Ellipse 36")   // placeholder image
        imageView.sd_setImage(with: URL(string: urlStr), completed: nil)
    }
}
