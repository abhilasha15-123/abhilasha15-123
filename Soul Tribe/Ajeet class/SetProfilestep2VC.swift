//
//  SetProfilestep2VC.swift
//  DemoNew
//
//  Created by mac-9 on 02/07/21.
//

import UIKit
class SetProfilestep2cell: UICollectionViewCell{
    @IBOutlet weak var intrestview: UIView!
    @IBOutlet weak var imginterest: UIImageView!
    @IBOutlet weak var lblname: UILabel!

}
class SetProfilestep2VC: UIViewController {
    @IBOutlet weak var soulview: UIView!
    @IBOutlet weak var tribeview: UIView!
    @IBOutlet weak var minitribeview: UIView!
    @IBOutlet weak var btnback: UIButton!
    @IBOutlet weak var btnnext: UIButton!
    @IBOutlet weak var religionview: UIView!
    @IBOutlet weak var firstview: UIView!
    @IBOutlet weak var secondview: UIView!
    @IBOutlet weak var thirdview: UIView!
    @IBOutlet weak var forthview: UIView!
    @IBOutlet weak var headerview: UIView!
    @IBOutlet weak var btnimg: UIButton!
    @IBOutlet weak var btnimg2: UIButton!
    @IBOutlet weak var btnimg3: UIButton!
    @IBOutlet weak var interestcollection: UICollectionView!
    
    var selectedIndex = Int()
    var interestImage = ["Fitness","Music","Shopping","Aliens","Art","Sport","Fitness","Music","Shopping","Aliens"]
    var interestTxt = ["Fitness","Music","Shopping","Aliens","Art","Sport","Fitness","Music","Shopping","Aliens"]
    var selectedarray = NSMutableArray()
    override func viewDidLoad() {
        super.viewDidLoad()
        headerview.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        headerview.layer.shadowOpacity = 0.5
        headerview.layer.shadowOffset = .zero
        headerview.layer.shadowRadius = 5
        
        
        soulview.layer.cornerRadius = 5
        soulview.layer.borderWidth = 1
        soulview.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        tribeview.layer.cornerRadius = 5
        tribeview.layer.borderWidth = 1
        tribeview.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        minitribeview.layer.cornerRadius = 5
        minitribeview.layer.borderWidth = 1
        minitribeview.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        btnback.layer.cornerRadius = 5
        btnback.layer.borderWidth = 1
        btnback.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        btnnext.layer.cornerRadius = 5
        btnnext.layer.borderWidth = 1
        btnnext.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        religionview.layer.cornerRadius = 5
        religionview.layer.borderWidth = 1
        religionview.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        firstview.layer.cornerRadius = 5
        firstview.layer.borderWidth = 1
        firstview.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        secondview.layer.cornerRadius = 5
        secondview.layer.borderWidth = 1
        secondview.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        thirdview.layer.cornerRadius = 5
        thirdview.layer.borderWidth = 1
        thirdview.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        forthview.layer.cornerRadius = 5
        forthview.layer.borderWidth = 1
        forthview.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        // Do any additional setup after loading the view.
    }
    @IBAction func btnnext(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(identifier: "SetProfilestep3VC") as! SetProfilestep3VC
        navigationController?.pushViewController(vc, animated: true)
        
    }
    @IBAction func btnBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)

    }

    @IBAction func btnsoullove(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected{
            soulview.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
            soulview.layer.borderWidth = 1
            btnimg.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)

        }
        else{
            soulview.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            soulview.layer.borderWidth = 1
            btnimg.setImage(UIImage(named: "black circle"), for: .normal)
            
        }
    }
    @IBAction func btntribe(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected{
            tribeview.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
            tribeview.layer.borderWidth = 1
            btnimg2.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
        }
        
        else{
            tribeview.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            tribeview.layer.borderWidth = 1
            btnimg2.setImage(UIImage(named: "black circle"), for: .normal)
        }
    }
    @IBAction func btnminitribe(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected{
            minitribeview.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
            minitribeview.layer.borderWidth = 1
            btnimg3.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
        }
        else{
            minitribeview.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            minitribeview.layer.borderWidth = 1
            btnimg3.setImage(UIImage(named: "black circle"), for: .normal)
        }
    }
    
}
extension SetProfilestep2VC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return interestImage.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
   let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SetProfilestep2cell", for: indexPath) as! SetProfilestep2cell
        
        if selectedarray.contains(indexPath.row)
            {
            cell.backgroundColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 0.3977995614)
            cell.layer.borderWidth = 1
            cell.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
            cell.layer.cornerRadius = 8
            }
            else 
            {
                cell.backgroundColor = UIColor.white
//              cell.layer.borderWidth = 0.8
                cell.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
            }

        cell.imginterest.image = UIImage(named: interestImage[indexPath.item])
        cell.lblname.text = interestTxt[indexPath.item]
        cell.intrestview.layer.cornerRadius = 6
        cell.intrestview.layer.borderWidth = 0.6
        cell.intrestview.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        if selectedarray.contains(indexPath.row){
            selectedarray.remove(indexPath.row)

        }
        else{
            selectedarray.add(indexPath.row)
            
        }
        selectedIndex = indexPath.row

        self.interestcollection.reloadData()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
        
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width/2.1 , height: collectionView.frame.height/7);

       }
   
}
