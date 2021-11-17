//
//  TribefullDeatilsVC.swift
//  Soul Tribe
//
//  Created by MAC-28 on 22/07/21.
//

import UIKit
class Tribefulltblcell: UITableViewCell{
    @IBOutlet weak var txtseach1: UITextField!
}

class Tribefullcollcell: UICollectionViewCell{
    
}
class TribefullDeatilsVC: UIViewController {
    @IBOutlet weak var searchview: UIView!
    @IBOutlet weak var txtsearch: UITextField!


    override func viewDidLoad() {
        super.viewDidLoad()
        searchview.layer.cornerRadius = 6
        searchview.layer.borderWidth = 1
        searchview.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        txtsearch.layer.cornerRadius = 5
        
        // Do any additional setup after loading the view.
    }
    @IBAction func btninvite(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(identifier: "InviatationsVC") as! InviatationsVC
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
}
extension TribefullDeatilsVC: UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Tribefulltblcell", for: indexPath) as! Tribefulltblcell
        cell.txtseach1.layer.cornerRadius = 6

        return cell
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Tribefullcollcell", for: indexPath) as! Tribefullcollcell
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height);
        }
}
