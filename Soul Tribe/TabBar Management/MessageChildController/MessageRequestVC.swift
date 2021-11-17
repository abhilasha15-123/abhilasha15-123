//
//  MessageRequestVC.swift
//  Soul Tribe
//
//  Created by MAC-28 on 15/07/21.
//

import UIKit
class MessageRequestCell: UITableViewCell{
    @IBOutlet weak var cornorview: UIView!

}
class MessageRequestVC: UIViewController {
    @IBOutlet weak var searchview: UIView!
    @IBOutlet weak var Messagerequesttbl: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        searchview.layer.cornerRadius = 6
        searchview.layer.borderWidth = 1
        searchview.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        // Do any additional setup after loading the view.
    }
    @IBAction func btngotomessage(_ sender: Any) {
        let controller1 = storyboard?.instantiateViewController(identifier: "MessageListVC") as! MessageListVC
        controller1.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        controller1.willMove(toParent: self)
        self.view.addSubview(controller1.view)
        self.addChild(controller1)
        controller1.didMove(toParent: self)
    }
  
}
extension MessageRequestVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageRequestCell", for: indexPath) as! MessageRequestCell
        cell.cornorview.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        cell.cornorview.layer.shadowOpacity = 0.4
        cell.cornorview.layer.shadowOffset = .zero
        cell.cornorview.layer.shadowRadius = 4
        cell.cornorview.layer.cornerRadius = 12
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 85
       }
}
