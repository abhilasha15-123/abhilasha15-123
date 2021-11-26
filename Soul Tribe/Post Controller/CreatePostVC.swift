//
//  CreatePostVC.swift
//  Soul Tribe
//
//  Created by Ashish Soni on 29/06/21.
//

import UIKit
import AssetsPickerViewController
import Photos

class CreatePostcell: UICollectionViewCell{
    
    @IBOutlet weak var btn_close: UIButton!
    @IBOutlet weak var img_disp: UIImageView!
}


class CreatePostVC: UIViewController {
    @IBAction func btn_backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btn_addPicturesAction(_ sender: UIButton) {
      
        let picker = AssetsPickerViewController()
        let config = AssetsPickerConfig()
        config.albumIsShowEmptyAlbum = false
        config.selectedAssets = self.arr_assets
       

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
    @IBAction func btn_postAction(_ sender: UIButton) {
     
        self.view.endEditing(true)

        if ValidationClass().ValidateCreateMiniTribePost(self){

            basicFunctions.presentLoader()

            let parameterDictionary = NSMutableDictionary()

            parameterDictionary.setValue(Config().AppUserDefaults.value(forKey:"user_id") as? String ?? "", forKey: "user_id")
            
            parameterDictionary.setValue(Config().api_key, forKey: "api_key")
           
            parameterDictionary.setValue(self.miniTribeId, forKey: "mini_tribe_id")
            parameterDictionary.setValue(txt_perspective.text, forKey: "perspective")
           
            
            let arr_images = NSMutableArray()
            
                for index in 0..<self.arr_assets.count {
                    let asset = arr_assets[index]
                    let img = basicFunctions.getAssetThumbnail(asset: asset)
                        
                    let dataDict = NSMutableDictionary()
                        
                    dataDict.setObject("mini_tribe_post_image", forKey: "keyName" as NSCopying)
                    dataDict.setObject(img.pngData() ?? Data(), forKey: "MyData" as NSCopying)
                    dataDict.setObject("png", forKey: "ext" as NSCopying)
                    arr_images.add(dataDict)
                }
            
            
     
            print(parameterDictionary)
           
            let methodName = "create_mini_tribe_post"
            
            
            DataManager.getAPIResponseFileMultipleImageArray(parameterDictionary: parameterDictionary, methodName: methodName, DocimageArray: arr_images, success: { (responseData,error)-> Void in
                
                let status = DataManager.getVal(responseData?["status"]) as! String
                let message = DataManager.getVal(responseData?["message"]) as! String
                 
                if status == "1" {
                    self.view.makeToast(message)
                    DispatchQueue.main.asyncAfter(deadline: .now()+1.5, execute: {
                        self.navigationController?.popViewController(animated: true)
                    })
                }
                else {
                    self.view.makeToast(message)
                }
                basicFunctions.stopLoading()
        })
            
        }
        
    }
    
    
    @IBOutlet weak var constraint_height_colVw: NSLayoutConstraint! //125
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var txt_perspective: UITextView!
    @IBOutlet weak var lbl_name: UILabel!
    @IBOutlet weak var img_disp: UIImageView!
    @IBOutlet weak var btnback: UIButton!
    @IBOutlet weak var btnpost: UIButton!
    
    var userName = ""
    var user_Img = ""
    var arr_assets = [PHAsset]()
    
    var miniTribeId = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        img_disp.contentMode = .scaleToFill
        
        btnpost.layer.cornerRadius = 6
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.reloadData()
        
        constraint_height_colVw.constant = 0
        
        img_disp.layer.cornerRadius = img_disp.frame.size.width/2
        img_disp.sd_setImage(with: URL(string: "\(Config().baseImageUrl)\(user_Img)"), completed: nil)
        lbl_name.text = userName
        
        txt_perspective.delegate = self
        
        txt_perspective.textColor = UIColor.lightGray
        txt_perspective.text = "Share Your Perspective..."
    }
}

extension CreatePostVC : UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arr_assets.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CreatePostcell
        cell.img_disp.layer.cornerRadius = 6
        
        let asset = arr_assets[indexPath.row]
        let img = basicFunctions.getAssetThumbnail(asset: asset)
        cell.img_disp.image = img
        
        cell.btn_close.tag = indexPath.row
        cell.btn_close.addTarget(self, action: #selector(deleteAsset(_:)), for: .touchUpInside)
//        cell.brncross.isHidden = false

        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }

    @objc func deleteAsset(_ sender : UIButton){
       
        self.arr_assets.remove(at: sender.tag)
        if arr_assets.count > 0 {
            constraint_height_colVw.constant = 125
        }
        else {
            constraint_height_colVw.constant = 0
        }
        self.collectionView.reloadData()
    }
}



extension CreatePostVC: AssetsPickerViewControllerDelegate {
    
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
      
        arr_assets = assets
            if arr_assets.count > 0 {
                constraint_height_colVw.constant = 125
            }
            else {
                constraint_height_colVw.constant = 0
            }
        collectionView.reloadData()
    }
}


extension CreatePostVC : UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if textView.textColor == UIColor.lightGray {
            textView.text = ""
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if textView.text == "" {
            textView.text = "Share Your Perspective..."
            textView.textColor = UIColor.lightGray
        }
    }
}
