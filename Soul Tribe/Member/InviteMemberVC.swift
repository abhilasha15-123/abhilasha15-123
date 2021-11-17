//
//  InviteMemberVC.swift
//  Soul Tribe
//
//  Created by Ashish Soni on 29/06/21.
//

import UIKit
class InviteMembercell: UITableViewCell{
    @IBOutlet weak var imgmember: UIImage!
    @IBOutlet weak var lblname: UILabel!
    @IBOutlet weak var btncheck: UIButton!

}
class InviteMemberVC: UIViewController {

    @IBOutlet weak var memberView: UIView!
    @IBOutlet weak var membertable: UITableView!
    @IBOutlet weak var cornorView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        cornorView.layer.cornerRadius = 6
        cornorView.layer.borderWidth = 1
        cornorView.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        memberView.layer.cornerRadius = 8

        // Do any additional setup after loading the view.
    }
    
    @IBAction func crossBtnAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func inviteBtnAction(_ sender: Any) {
    }
   
}
extension InviteMemberVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InviteMembercell", for: indexPath) as! InviteMembercell
        return cell
    }
    
    
}
