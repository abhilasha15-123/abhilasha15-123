//
//  basicFunctions.swift
//  Hyak
//
//  Created by mac-16 on 4/2/20.
//  Copyright © 2020 mac-16. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import Photos

class basicFunctions {

    class func resize(_ image: UIImage) -> UIImage {
  
        var actualHeight: Float = Float(image.size.height)
        var actualWidth: Float = Float(image.size.width)
        let maxHeight: Float = Float(UIScreen.main.bounds.height)
        let maxWidth: Float = Float(UIScreen.main.bounds.width)
        var imgRatio: Float = actualWidth / actualHeight
        let maxRatio: Float = maxWidth / maxHeight
        let compressionQuality: Float = 0.5
           //50 percent compression

        if actualHeight > maxHeight || actualWidth > maxWidth {
            if imgRatio < maxRatio {
                //adjust width according to maxHeight
                imgRatio = maxHeight / actualHeight
                actualWidth = imgRatio * actualWidth
                actualHeight = maxHeight
            }
            else if imgRatio > maxRatio {
                //adjust height according to maxWidth
                imgRatio = maxWidth / actualWidth
                actualHeight = imgRatio * actualHeight
                actualWidth = maxWidth
            }
               else {
                   actualHeight = maxHeight
                   actualWidth = maxWidth
               }
           }

            let rect = CGRect(x: 0.0, y: 0.0, width: CGFloat(actualWidth), height: CGFloat(actualHeight))
           UIGraphicsBeginImageContext(rect.size)
            image.draw(in: rect)
           let img = UIGraphicsGetImageFromCurrentImageContext()
            let imageData = img!.jpegData(compressionQuality: CGFloat(compressionQuality))
           UIGraphicsEndImageContext()
           return UIImage(data: imageData!)!
    }
    

    
    class func circularImage (_ imgVw: UIImageView) {
        imgVw.layer.borderWidth = 3
        imgVw.layer.masksToBounds = false
        imgVw.layer.borderColor = Config().AppThemeMainColor.cgColor
        imgVw.layer.cornerRadius = imgVw.frame.height / 2
        imgVw.contentMode = .scaleAspectFill
        imgVw.clipsToBounds = true
    }
    
    
    class func circularImageProfileScreenPic (_ imgVw: UIImageView) {
        imgVw.layer.borderWidth = 3
        imgVw.layer.masksToBounds = false
        imgVw.layer.borderColor = Config().AppThemeMainColor.cgColor
        imgVw.layer.cornerRadius = imgVw.frame.height / 2
        imgVw.contentMode = .scaleAspectFill
        imgVw.clipsToBounds = true
    }
    
    class func circularImageProfilePic (_ imgVw: UIImageView) {
          imgVw.layer.masksToBounds = false
          imgVw.layer.cornerRadius = imgVw.frame.height / 2
          imgVw.contentMode = .scaleAspectFill
          imgVw.clipsToBounds = true
    }
      
    
   class func convertIntoJSONString(arrayObject: [Any]) -> String? {

        do {
            let jsonData: Data = try JSONSerialization.data(withJSONObject: arrayObject, options: [])
            if  let jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue) {
                return jsonString as String
            }
            
        } catch let error as NSError {
            print("Array convertIntoJSON - \(error.description)")
        }
        return nil
    }

    class func randomString(length: Int) -> String {
      let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
      return String((0..<length).map{ _ in letters.randomElement()! })
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
    
    class func presentLoader(){
          let SBMain = UIStoryboard.init(name: "Main", bundle: nil)
          let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        if let topController = keyWindow?.rootViewController?.children {
              let controller = topController.last
              let vc = SBMain.instantiateViewController(withIdentifier: "LoaderVC")as!LoaderVC
              controller?.present(vc, animated: false, completion: nil)
          }
      }
      
     class func stopLoading(){
          if let topController = UIApplication.shared.keyWindow?.rootViewController {
              if((topController.presentedViewController?.isKind(of: LoaderVC.self)) != nil){
                  let loaderVC = topController
                  loaderVC.dismiss(animated: false, completion: nil)
              }
          }
      }
    
    
    
   class func calcAge(birthday: String) -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "MM-dd-yy"
        let birthdayDate = dateFormatter.date(from:birthday) ?? Date()
        
        let calcAge = Calendar.current.dateComponents([.year], from: birthdayDate, to: Date())
        let age = calcAge.year
        return age ?? -1
    }
    
   class func combinedImage(img1 : UIImage, img2 : UIImage) -> UIImage {
        let bottomImage = img1
        let topImage = img2

        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: bottomImage.size.width, height: bottomImage.size.height), false, 0.0)

        bottomImage.draw(in: CGRect(x: 0, y: 0, width: bottomImage.size.width, height: bottomImage.size.height))
        topImage.draw(in: CGRect(x: bottomImage.size.width/2 - 30, y: bottomImage.size.height/2 - 30, width: 60, height: 60))

        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    class func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
  
   
    
    
    class func zeroDataAvailableView (str : String, tbl: UITableView) -> UIView{
        let lbl: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: tbl.bounds.size.width, height: tbl.bounds.size.height))
        lbl.text = str
        lbl.textAlignment = .center
        lbl.textColor = UIColor.lightGray
        lbl.font = UIFont(name: "Open Sans", size: 10)
        return lbl
    }
    
    class func zeroDataAvailableCollectionView (str : String, col: UICollectionView) -> UIView{
        let lbl: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: col.bounds.size.width, height: col.bounds.size.height))
        lbl.text = str
        lbl.textAlignment = .center
        lbl.textColor = UIColor.lightGray
        lbl.font = UIFont(name: "Open Sans", size: 10)
        return lbl
    }
    
    class func convertDateToString (dt : Date) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        
        return formatter.string(from: dt)
    }
    
    class func convertDateToDateNTimeString (dtStr : String) -> [String:String]{
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dt = dateFormatter.date(from:dtStr)!
        
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        
        let formatter2 = DateFormatter()
        formatter2.timeStyle = DateFormatter.Style.short
        formatter2.timeZone = .current
        
        let dt1 = formatter.string(from: dt)
        let tym = formatter2.string(from: dt)
        
        let dict = ["date": dt1,"time":tym]
        return dict
    }
}

extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
           let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
           self.leftView = paddingView
           self.leftViewMode = .always
       }
}

class CustomUITextField: UITextField {
   override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(UIResponderStandardEditActions.paste(_:)) {
            return false
        }
        return super.canPerformAction(action, withSender: sender)
   }
}


extension UIView {
    // Example use: myView.addBorder(toSide: .Left, withColor: UIColor.redColor().CGColor, andThickness: 1.0)

      enum ViewSide {
          case left, right, top, bottom
      }
      
      func addBorder(toSide side: ViewSide, withColor color: CGColor, andThickness thickness: CGFloat) {
          
          let border = CALayer()
          border.backgroundColor = color
          
          switch side {
          case .left: border.frame = CGRect(x: frame.minX, y: frame.minY, width: thickness, height: frame.height)
          case .right: border.frame = CGRect(x: frame.maxX, y: frame.minY, width: thickness, height: frame.height)
          case .top: border.frame = CGRect(x: frame.minX, y: frame.minY, width: frame.width, height: thickness)
          case .bottom: border.frame = CGRect(x: frame.minX, y: frame.maxY, width: frame.width, height: thickness)
          }
          
          layer.addSublayer(border)
      }
    
    
    func slideInFromRight(duration: TimeInterval = 0.7, completionDelegate: AnyObject? = nil) {
        // Create a CATransition animation
        let slideInFromRight = CATransition()
    
        // Customize the animation's properties
        slideInFromRight.type = CATransitionType.push
        slideInFromRight.subtype = CATransitionSubtype.fromRight
        slideInFromRight.duration = duration
        slideInFromRight.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        slideInFromRight.fillMode = CAMediaTimingFillMode.removed
   
        // Add the animation to the View's layer
        self.layer.add(slideInFromRight, forKey: "slideInFromRight")
    }
    
    
    func slideOut(duration: TimeInterval = 1.0, completionDelegate: AnyObject? = nil) {
        // Create a CATransition animation
        let slideOut = CATransition()
    
        // Customize the animation's properties
        slideOut.type = CATransitionType.fade
        slideOut.subtype = CATransitionSubtype.fromLeft
        slideOut.duration = duration
        slideOut.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        slideOut.fillMode = CAMediaTimingFillMode.removed
   
        // Add the animation to the View's layer
        self.layer.add(slideOut, forKey: "slideOut")
       }
    
}


public extension UIDevice {

    static let modelName: String = {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }

        func mapToDevice(identifier: String) -> String { // swiftlint:disable:this cyclomatic_complexity
            #if os(iOS)
            switch identifier {
            case "iPod5,1":                                 return "iPod touch (5th generation)"
            case "iPod7,1":                                 return "iPod touch (6th generation)"
            case "iPod9,1":                                 return "iPod touch (7th generation)"
            case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
            case "iPhone4,1":                               return "iPhone 4s"
            case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
            case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
            case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
            case "iPhone7,2":                               return "iPhone 6"
            case "iPhone7,1":                               return "iPhone 6 Plus"
            case "iPhone8,1":                               return "iPhone 6s"
            case "iPhone8,2":                               return "iPhone 6s Plus"
            case "iPhone8,4":                               return "iPhone SE"
            case "iPhone9,1", "iPhone9,3":                  return "iPhone 7"
            case "iPhone9,2", "iPhone9,4":                  return "iPhone 7 Plus"
            case "iPhone10,1", "iPhone10,4":                return "iPhone 8"
            case "iPhone10,2", "iPhone10,5":                return "iPhone 8 Plus"
            case "iPhone10,3", "iPhone10,6":                return "iPhone X"
            case "iPhone11,2":                              return "iPhone XS"
            case "iPhone11,4", "iPhone11,6":                return "iPhone XS Max"
            case "iPhone11,8":                              return "iPhone XR"
            case "iPhone12,1":                              return "iPhone 11"
            case "iPhone12,3":                              return "iPhone 11 Pro"
            case "iPhone12,5":                              return "iPhone 11 Pro Max"
            case "iPhone12,8":                              return "iPhone SE (2nd generation)"
            case "iPhone13,1":                              return "iPhone 12 mini"
            case "iPhone13,2":                              return "iPhone 12"
            case "iPhone13,3":                              return "iPhone 12 Pro"
            case "iPhone13,4":                              return "iPhone 12 Pro Max"
            case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
            case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad (3rd generation)"
            case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad (4th generation)"
            case "iPad6,11", "iPad6,12":                    return "iPad (5th generation)"
            case "iPad7,5", "iPad7,6":                      return "iPad (6th generation)"
            case "iPad7,11", "iPad7,12":                    return "iPad (7th generation)"
            case "iPad11,6", "iPad11,7":                    return "iPad (8th generation)"
            case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
            case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
            case "iPad11,3", "iPad11,4":                    return "iPad Air (3rd generation)"
            case "iPad13,1", "iPad13,2":                    return "iPad Air (4th generation)"
            case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad mini"
            case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad mini 2"
            case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad mini 3"
            case "iPad5,1", "iPad5,2":                      return "iPad mini 4"
            case "iPad11,1", "iPad11,2":                    return "iPad mini (5th generation)"
            case "iPad6,3", "iPad6,4":                      return "iPad Pro (9.7-inch)"
            case "iPad7,3", "iPad7,4":                      return "iPad Pro (10.5-inch)"
            case "iPad8,1", "iPad8,2", "iPad8,3", "iPad8,4":return "iPad Pro (11-inch) (1st generation)"
            case "iPad8,9", "iPad8,10":                     return "iPad Pro (11-inch) (2nd generation)"
            case "iPad6,7", "iPad6,8":                      return "iPad Pro (12.9-inch) (1st generation)"
            case "iPad7,1", "iPad7,2":                      return "iPad Pro (12.9-inch) (2nd generation)"
            case "iPad8,5", "iPad8,6", "iPad8,7", "iPad8,8":return "iPad Pro (12.9-inch) (3rd generation)"
            case "iPad8,11", "iPad8,12":                    return "iPad Pro (12.9-inch) (4th generation)"
            case "AppleTV5,3":                              return "Apple TV"
            case "AppleTV6,2":                              return "Apple TV 4K"
            case "AudioAccessory1,1":                       return "HomePod"
            case "AudioAccessory5,1":                       return "HomePod mini"
            case "i386", "x86_64":                          return "Simulator \(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "iOS"))"
            default:                                        return identifier
            }
            #elseif os(tvOS)
            switch identifier {
            case "AppleTV5,3": return "Apple TV 4"
            case "AppleTV6,2": return "Apple TV 4K"
            case "i386", "x86_64": return "Simulator \(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "tvOS"))"
            default: return identifier
            }
            #endif
        }

        return mapToDevice(identifier: identifier)
    }()

}

extension UIColor {
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255

                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }

        return nil
    }
}

