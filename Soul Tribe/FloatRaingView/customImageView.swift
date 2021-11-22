


import  UIKit
import Foundation

@IBDesignable public class CustomImageView: UIImageView {
    
    
    @IBInspectable var cornerRadius: CGFloat = 0  {
        didSet {
            layer.cornerRadius = CGFloat(cornerRadius)
            clipsToBounds = true
        }
    }
    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    @IBInspectable var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
    
    
}
