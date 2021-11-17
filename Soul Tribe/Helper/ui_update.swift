//
//  ui_update.swift
//  Hyak
//
//  Created by mac-16 on 3/19/20.
//  Copyright © 2020 mac-16. All rights reserved.
//

import Foundation
import UIKit

class ui_update {
    
   class func txtfield_bottomline (txtfield : UITextField){
        let bottomLine = CALayer()
        let width = CGFloat(1.0)
        let mycolor = UIColor(red: 1, green: 0.5, blue: 0, alpha: 0.3)
        bottomLine.frame = CGRect(origin: CGPoint(x: 0, y: txtfield.frame.size.height - width), size: CGSize(width: txtfield.frame.size.width, height: txtfield.frame.size.height))
        bottomLine.borderWidth = width
        bottomLine.borderColor = mycolor.cgColor
        txtfield.borderStyle = UITextField.BorderStyle.none
        txtfield.layer.addSublayer(bottomLine)
        txtfield.layer.masksToBounds = true
    }
    
    class func button_roundCorner (_ btn : UIButton){
        btn.layer.cornerRadius = 0.03 * btn.bounds.size.width
    }
    
    class func view_roundCorner (_ vw : UIView){
          vw.layer.cornerRadius = 0.03 * vw.bounds.size.width
           vw.layer.masksToBounds = true
    }
   
    class func dropShadow(vw: UIView) {
           vw.layer.shadowColor = UIColor(white: 0.0, alpha: 0.5).cgColor
           vw.layer.shadowOffset = CGSize(width: 3.0, height: 3.0)
           vw.layer.shadowOpacity = 1.0
           vw.layer.shadowRadius = 3.0
    }

    
    class func newBorderUpdated(vw: UIView){
        vw.backgroundColor = UIColor.white
        vw.layer.shadowColor = UIColor.lightGray.cgColor
        vw.layer.shadowOpacity = 1
        vw.layer.shadowOffset = CGSize.zero
        vw.layer.shadowRadius = 5
        vw.layer.masksToBounds = false
    }
    
    class func newTopViewShadow(vw: UIView){
        vw.backgroundColor = UIColor.lightGray.withAlphaComponent(0.1)
        vw.layer.shadowColor = UIColor.black.cgColor
        vw.layer.shadowOpacity = 1.0
        vw.layer.shadowOffset = CGSize(width: -1, height: -1)
        vw.layer.shadowRadius = 2
    }
    
    
    class func dropShadowCell(vw: UIView) {
        vw.layer.shadowColor = UIColor(white: 0.0, alpha: 0.3).cgColor
        vw.layer.shadowOpacity = 0.5
        vw.layer.shadowRadius = 2.0
        vw.layer.shadowOffset = CGSize(width: 0, height: 2.0)
    }

    
    class func passwordLengthCorrectionVisibility(txtfld : UITextField){
        if let textRange = txtfld.textRange(from: txtfld.beginningOfDocument, to: txtfld.endOfDocument) {
            txtfld.replace(textRange, withText: txtfld.text!)
        }
    }
    
    class func roundCorners(corners: UIRectCorner, radius: CGFloat, lbl : UILabel) {
        let path = UIBezierPath(roundedRect: lbl.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            lbl.layer.mask = mask
        }
    
    
    class func roundCornersVw(corners: UIRectCorner, radius: CGFloat, vw : UIView) {
        let path = UIBezierPath(roundedRect: vw.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            vw.layer.mask = mask
        }
    
}
