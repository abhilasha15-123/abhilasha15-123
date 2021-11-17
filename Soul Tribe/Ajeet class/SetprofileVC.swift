//
//  SetprofileVC.swift
//  DemoNew
//
//  Created by mac-9 on 02/07/21.
//

import UIKit
class uploadimgcollcell: UICollectionViewCell{
    @IBOutlet weak var userimg: UIImageView!
    @IBOutlet weak var  brncross: UIButton!
}

class SetprofileVC: UIViewController {
    @IBOutlet weak var profileview: UIView!
    @IBOutlet weak var txtname: UITextField!
    @IBOutlet weak var txtsurname: UITextField!
    @IBOutlet weak var btnnext: UIButton!
    @IBOutlet weak var viewdob: UIView!
    @IBOutlet weak var txtage: UITextField!
    @IBOutlet weak var txtkm: UITextField!
    @IBOutlet weak var viewkm: UIView!
    @IBOutlet weak var viewdiscription: UIView!

    @IBOutlet weak var genderview1: UIView!
    @IBOutlet weak var genderview2: UIView!
    @IBOutlet weak var genderview3: UIView!
    @IBOutlet weak var genderview4: UIView!
    @IBOutlet weak var genderview5: UIView!
    @IBOutlet weak var genderview6: UIView!
    @IBOutlet weak var headerview: UIView!
    @IBOutlet weak var btngender1: UIButton!
    @IBOutlet weak var btnchk1: UIButton!
    @IBOutlet weak var btnchk2: UIButton!
    @IBOutlet weak var btnchk3: UIButton!
    @IBOutlet weak var btnchk4: UIButton!
    @IBOutlet weak var btnchk5: UIButton!
    @IBOutlet weak var btnchk6: UIButton!
    @IBOutlet weak var slider: UISlider!
    
    var imgarray = ["joshua.png","joshua.png","joshua.png","Group 27152.png"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerview.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        headerview.layer.shadowOpacity = 0.5
        headerview.layer.shadowOffset = .zero
        headerview.layer.shadowRadius = 5
        
        profileview.layer.cornerRadius = 60
        
        profileview.layer.borderWidth = 2
        profileview.layer.borderColor = #colorLiteral(red: 0.05098039216, green: 0.2274509804, blue: 0.662745098, alpha: 1)
        
        txtname.layer.cornerRadius = 5
        txtname.layer.borderWidth = 1
        txtname.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        txtsurname.layer.cornerRadius = 5
        txtsurname.layer.borderWidth = 1
        txtsurname.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        viewdob.layer.cornerRadius = 5
        viewdob.layer.borderWidth = 1
        viewdob.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        txtage.layer.cornerRadius = 5
        txtage.layer.borderWidth = 1
        txtage.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        
        txtkm.layer.cornerRadius = 5
        txtkm.layer.borderWidth = 1
        txtkm.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        viewkm.layer.cornerRadius = 5
        viewkm.layer.borderWidth = 1
        viewkm.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        viewdiscription.layer.cornerRadius = 5
        viewdiscription.layer.borderWidth = 1
        viewdiscription.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        genderview1.layer.cornerRadius = 5
        genderview1.layer.borderWidth = 1
        genderview1.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        genderview2.layer.cornerRadius = 5
        genderview2.layer.borderWidth = 1
        genderview2.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        genderview3.layer.cornerRadius = 5
        genderview3.layer.borderWidth = 1
        genderview3.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        genderview4.layer.cornerRadius = 5
        genderview4.layer.borderWidth = 1
        genderview4.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        genderview5.layer.cornerRadius = 5
        genderview5.layer.borderWidth = 1
        genderview5.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        genderview6.layer.cornerRadius = 5
        genderview6.layer.borderWidth = 1
        genderview6.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        
        btnnext.layer.cornerRadius = 8
        self.slider.setThumbImage(UIImage(named: "Group 27193"), for: .normal)

        
        
     //   slider.setThumbImage(UIImage "Ellipse 36", for: .no)
        ///slider.setThumbImage("Ellipse 36", for:State .normal)
       
        // Do any additional setup after loading the view.
    }
    @IBAction func btnnext(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(identifier: "SetProfilestep2VC") as! SetProfilestep2VC
        navigationController?.pushViewController(vc, animated: true)
        
    }
    @IBAction func btnBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)

    }

    @IBAction func btnfemale(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected{
            genderview1.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
            genderview1.layer.borderWidth = 1
            btnchk1.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
            
        }
        else{
            genderview1.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            genderview1.layer.borderWidth = 1
            btnchk1.setImage(UIImage(named: "black circle"), for: .normal)
        }
    }
    @IBAction func btnmale(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected{
            genderview2.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
            genderview2.layer.borderWidth = 1.5
            btnchk2.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
        }
        else{
            genderview2.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            genderview2.layer.borderWidth = 1
            btnchk2.setImage(UIImage(named: "black circle"), for: .normal)
        }
    }
    @IBAction func btntransgender(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected{
            genderview3.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
            genderview3.layer.borderWidth = 1.5
            btnchk3.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
        }
        else{
            genderview3.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            genderview3.layer.borderWidth = 1
            btnchk3.setImage(UIImage(named: "black circle"), for: .normal)
        }
    }
    @IBAction func btnfluidgender(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected{
            genderview4.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
            genderview4.layer.borderWidth = 1.5
            btnchk4.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
        }
        else{
            genderview4.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            genderview4.layer.borderWidth = 1
            btnchk4.setImage(UIImage(named: "black circle"), for: .normal)
        }
    }
    @IBAction func btnprefertosay(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected{
            genderview5.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
            genderview5.layer.borderWidth = 1.5
            btnchk5.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
        }
        else{
            genderview5.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            genderview5.layer.borderWidth = 1
            btnchk5.setImage(UIImage(named: "black circle"), for: .normal)
        }
    }
    
    @IBAction func btnothergender(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected{
            genderview6.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
            genderview6.layer.borderWidth = 1.5
            btnchk6.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
        }
        else{
            genderview6.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            genderview6.layer.borderWidth = 1
            btnchk6.setImage(UIImage(named: "black circle"), for: .normal)
        }
    }
    
}
extension SetprofileVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "uploadimgcollcell", for: indexPath) as! uploadimgcollcell
        cell.userimg.image = UIImage(named: imgarray[indexPath.row])
        cell.userimg.layer.cornerRadius = 8
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
        
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width/2.1, height: collectionView.frame.height/2.1);

       }
    
}
