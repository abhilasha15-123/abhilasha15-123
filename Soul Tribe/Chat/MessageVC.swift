//
//  MessageVC.swift
//  Soul Tribe
//
//  Created by Ashish Soni on 29/06/21.
//

import UIKit
class MessageSend: UITableViewCell{
    @IBOutlet weak var imgSend: UIImageView!
    @IBOutlet weak var imgSendBg: UIImageView!
    @IBOutlet weak var lblMessageSend: UILabel!
    @IBOutlet weak var  lblSendTime: UILabel!

}
class MessageRec: UITableViewCell{
    @IBOutlet weak var  imgRec: UIImageView!
    @IBOutlet weak var  imgRecBg: UIImageView!
    @IBOutlet weak var lblMessageRec: UILabel!
    @IBOutlet weak var lblRecTime: UILabel!
}

class MessageVC: UIViewController {
    @IBOutlet weak var messageTableview: UITableView!
    @IBOutlet weak var headerview: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        messageTableview.tableFooterView = UIView()
        headerview.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        headerview.layer.shadowOpacity = 0.5
        headerview.layer.shadowOffset = .zero
        headerview.layer.shadowRadius = 5

        
        // Do any additional setup after loading the view.
    }
    @IBAction func backBtnAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)

    }
    
    
}

extension MessageVC: UITabBarDelegate,UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return 2
    }
       
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0
        {
            return 110
        }
        else{
            return 110
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0
        {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageSend", for: indexPath)as! MessageSend
        return cell
    }
    else
        
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MessageRec", for: indexPath)as! MessageRec
            return cell
            
        }
        }
    
}

