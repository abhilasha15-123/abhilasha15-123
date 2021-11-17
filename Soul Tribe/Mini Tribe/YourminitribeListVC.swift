//
//  YourminitribeListVC.swift
//  Soul Tribe
//
//  Created by MAC-28 on 02/08/21.
//

import UIKit
class YourminitribeListcell: UITableViewCell{
    
}
class YourminitribeListVC: UIViewController {
    @IBOutlet weak var searchview: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        searchview.layer.cornerRadius = 6
        searchview.layer.borderWidth = 1
        searchview.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        // Do any additional setup after loading the view.
        
    }
    


}

extension YourminitribeListVC: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "YourminitribeListcell", for: indexPath) as! YourminitribeListcell
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}
