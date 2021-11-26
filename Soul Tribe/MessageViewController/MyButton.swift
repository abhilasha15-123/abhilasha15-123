

import UIKit

class MyButton: UIButton {
    
    
    
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet {
            setBorderColor()
        }
    }
    func setBorderColor(){
        self.layer.borderColor = borderColor.cgColor
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            setBorderWidth()
        }
    }
    func setBorderWidth(){
        self.layer.borderWidth = borderWidth
    }
    
    @IBInspectable var cornerRadious: CGFloat = 0 {
        didSet {
            setCornerRadious()
        }
    }
    func setCornerRadious(){
        self.layer.cornerRadius = cornerRadious
    }
    
    
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
}
