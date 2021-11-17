//
//  customview.swift
//  Soul Tribe
//
//  Created by MAC-28 on 26/07/21.
//


import UIKit

class RectangularDashedView: UIView {
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    @IBInspectable var dashWidth: CGFloat = 0
    @IBInspectable var dashColor: UIColor = .clear
    @IBInspectable var dashLength: CGFloat = 0
    @IBInspectable var betweenDashesSpace: CGFloat = 0
    
    var dashBorder: CAShapeLayer?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        dashBorder?.removeFromSuperlayer()
        let dashBorder = CAShapeLayer()
        dashBorder.lineWidth = dashWidth
        dashBorder.strokeColor = dashColor.cgColor
        dashBorder.lineDashPattern = [dashLength, betweenDashesSpace] as [NSNumber]
        dashBorder.frame = bounds
        dashBorder.fillColor = nil
        if cornerRadius > 0 {
            dashBorder.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
        } else {
            dashBorder.path = UIBezierPath(rect: bounds).cgPath
        }
        layer.addSublayer(dashBorder)
        self.dashBorder = dashBorder
    }
    
        
        func round(corners: UIRectCorner, cornerRadius: Double) {
            
            let size = CGSize(width: cornerRadius, height: cornerRadius)
            let bezierPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: size)
            let shapeLayer = CAShapeLayer()
            shapeLayer.frame = self.bounds
            shapeLayer.path = bezierPath.cgPath
            self.layer.mask = shapeLayer
        }
}

