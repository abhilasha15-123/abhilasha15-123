//
//  ViewController.swift
//  DemoNew
//
//  Created by mac-9 on 01/07/21.
//

import UIKit
class interestcollcell: UICollectionViewCell{
    @IBOutlet weak var  cellview: UIView!
    @IBOutlet weak var interestImage: UIImageView!
    @IBOutlet weak var interstedLbl: UILabel!
}
class discriptiontblcell: UITableViewCell{
    @IBOutlet weak var  imguser: UIImageView!

}
class ProfileController: UIViewController {
    @IBOutlet weak var viewcorner: UIView!
    @IBOutlet weak var borderview: UIView!
    @IBOutlet weak var imgprofile: UIImageView!
    @IBOutlet weak var btnback: UIButton!
    var interestImage = ["Fitness","Music","Shopping","Aliens","Art","Sport"]
    var interestTxt = ["Fitness","Music","Shopping","Aliens","Art","Sport"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewcorner.layer.cornerRadius = 10
        imgprofile.layer.cornerRadius = 27.5
        btnback.layer.cornerRadius = 5

        borderview.layer.cornerRadius = 10
        borderview.layer.borderWidth = 2
        borderview.layer.borderColor = #colorLiteral(red: 0.4235294118, green: 0.3882352941, blue: 1, alpha: 1)
        
        
        // Do any additional setup after loading the view.
    }
  //
    @IBAction func gotomsg(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(identifier: "MessageVC") as! MessageVC
        navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func btnback(_ sender: Any) {
        navigationController?.popViewController(animated: true)

    }

}

extension ProfileController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITableViewDelegate,UITableViewDataSource{
   
    //MARK: COLLECTION VIEW METHOD
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return interestTxt.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "interestcollcell", for: indexPath) as! interestcollcell
        cell.cellview.layer.cornerRadius = 5
        cell.cellview.layer.borderWidth = 1
        cell.cellview.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        cell.interestImage.image = UIImage(named: interestImage[indexPath.item])
        cell.interstedLbl.text = interestTxt[indexPath.item]
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 6
        
    }
    //UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width/4, height: collectionView.frame.height/2.2);

       }
    
    //MARK: TABLE VIEW METHOD
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "discriptiontblcell", for: indexPath) as! discriptiontblcell
        cell.imguser.layer.cornerRadius = 10
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 320
        
        
    }
}
