//
//  NotificationsVC.swift
//  Soul Tribe
//
//  Created by Ashish Soni on 11/06/21.
//

import UIKit

class NotificationsCell: UITableViewCell{
    @IBOutlet weak var btnstatus: UIButton!

}
class NotificationsVC: UIViewController {
    var leftDrawerTransition:DrawerTransition!
    var left = LeftMenuViewController()
    @IBOutlet weak var headerview: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        // Do any additional setup after loading the view.
        headerview.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        headerview.layer.shadowOpacity = 0.5
        headerview.layer.shadowOffset = .zero
        headerview.layer.shadowRadius = 5

    }
    
    @IBAction func backbtnaction(_ sender:UIButton) {
        navigationController?.popViewController(animated: true)
        
        //self.slideMenuController()?.toggleLeft()
    }
    
    @IBAction func btngosetting(_ sender:UIButton) {
        let vc = self.storyboard?.instantiateViewController(identifier: "NotificationSettingVC") as! NotificationSettingVC
        navigationController?.pushViewController(vc, animated: true)
        
    }
}
extension NotificationsVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationsCell", for: indexPath) as! NotificationsCell
        cell.btnstatus.layer.cornerRadius = 3
        return cell
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
         return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            // handle delete (by removing the data from your array and updating the tableview)
        }
    }
    
}
