//
//  MeetUpInvitaionVC.swift
//  Soul Tribe
//
//  Created by Ashish Soni on 29/06/21.
//

import UIKit
class MeetUpInvitaioncell: UITableViewCell{
    
    @IBOutlet weak var imguser: UIImageView!
    @IBOutlet weak var lblname: UILabel!
    @IBOutlet weak var lblcreate: UILabel!
    @IBOutlet weak var btncircle: UIButton!
    @IBOutlet weak var lbldate: UILabel!
    @IBOutlet weak var lbltime: UILabel!
    @IBOutlet weak var lbllocation: UILabel!
    @IBOutlet weak var btngoing: UIButton!
    @IBOutlet weak var btnnotsure: UIButton!
    @IBOutlet weak var btnnotgoing: UIButton!
    @IBOutlet weak var lblgoing: UILabel!
    @IBOutlet weak var lblnotgoing: UILabel!
    @IBOutlet weak var lblmightgoing: UILabel!
    @IBOutlet weak var viewcornor: UIView!
}
class MeetUpInvitaionVC: UIViewController {
    @IBOutlet weak var btnback: UIView!
    @IBOutlet weak var headerview: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        headerview.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        headerview.layer.shadowOpacity = 0.5
        headerview.layer.shadowOffset = .zero
        headerview.layer.shadowRadius = 5
    }
    @IBAction func backBtnAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)

    }

    

}
extension MeetUpInvitaionVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MeetUpInvitaioncell", for: indexPath) as! MeetUpInvitaioncell
        cell.viewcornor.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        cell.viewcornor.layer.shadowOpacity = 0.5
        cell.viewcornor.layer.shadowOffset = .zero
        cell.viewcornor.layer.shadowRadius = 8
        cell.viewcornor.layer.cornerRadius = 10
        
        cell.btngoing.layer.cornerRadius = 5
        cell.btngoing.layer.borderWidth = 0.8
        cell.btngoing.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        cell.btnnotsure.layer.cornerRadius = 5
        cell.btnnotsure.layer.borderWidth = 0.8
        cell.btnnotsure.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        cell.btnnotgoing.layer.cornerRadius = 5
        cell.btnnotgoing.layer.borderWidth = 0.8
        cell.btnnotgoing.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)


        return cell
    }
    
    
}
