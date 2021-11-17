//
//  MessageListVC.swift
//  Soul Tribe
//
//  Created by Ashish Soni on 09/06/21.
//

import UIKit

class MessageListVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var messageListTableview: UITableView!
    @IBOutlet weak var searchview: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchview.layer.cornerRadius = 6
        searchview.layer.borderWidth = 1
        searchview.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)

        // Do any additional setup after loading the view.
    }
    
    @IBAction func requestbtn(_ sender: Any) {
        let controller1 = storyboard?.instantiateViewController(identifier: "MessageRequestVC") as! MessageRequestVC
        controller1.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        controller1.willMove(toParent: self)
        self.view.addSubview(controller1.view)
        self.addChild(controller1)
        controller1.didMove(toParent: self)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MessageListCell
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0
        {
            let controller = storyboard?.instantiateViewController(withIdentifier: "MessageVC") as! MessageVC

                self.navigationController?.pushViewController(controller, animated: true)
        }
        
        }
   
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
