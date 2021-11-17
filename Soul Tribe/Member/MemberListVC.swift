//
//  MemberListVC.swift
//  Soul Tribe
//
//  Created by Ashish Soni on 29/06/21.
//

import UIKit
class MemberListCell: UITableViewCell{
    
}
class MemberListVC: UIViewController {

    @IBOutlet weak var searchview: UIView!
    @IBOutlet weak var membeeTableview: UITableView!
    @IBOutlet weak var headerview: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        searchview.layer.cornerRadius = 6
        searchview.layer.borderWidth = 1
        searchview.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func bachBtnAction(_ sender: Any) {
        self.slideMenuController()?.toggleLeft()

    }
       
}

extension MemberListVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemberListCell", for: indexPath) as! MemberListCell
        return cell
    }
    
    
}
