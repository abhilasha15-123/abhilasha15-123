//
//  AcceptedMeetUpVC.swift
//  Soul Tribe
//
//  Created by Ashish Soni on 29/06/21.
//

import UIKit
import FSCalendar
class AcceptedMeetUpVC: UIViewController {
    @IBOutlet weak var btnback: UIButton!
    @IBOutlet weak var viewdate: UIView!
    @IBOutlet weak var txtdate: UITextField!
    @IBOutlet weak var btndate: UIButton!
    @IBOutlet weak var viewcalendar: UIView!
    @IBOutlet weak var headerview: UIView!
    @IBOutlet weak var MeetupsTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        MeetupsTableView.delegate = self
        MeetupsTableView.dataSource = self
        getdata()
        viewdate.layer.cornerRadius = 5
        viewdate.layer.borderWidth = 1
        viewdate.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
       
        headerview.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        headerview.layer.shadowOpacity = 0.5
        headerview.layer.shadowOffset = .zero
        headerview.layer.shadowRadius = 5
        
        viewcalendar.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        viewcalendar.layer.shadowOpacity = 0.6
        viewcalendar.layer.shadowOffset = .zero
        viewcalendar.layer.shadowRadius = 6
        viewcalendar.layer.cornerRadius = 8

        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backBtnAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)

    }
    func getdata(){
        let paraDict = NSMutableDictionary()
        paraDict.setValue(Config().api_key, forKey: "api_key")
        paraDict.setValue("36", forKey: "user_id")
        paraDict.setValue("3", forKey: "mini_tribe_id")
        paraDict.setValue("1", forKey: "mini_tribe_meetup_id")
        
        let methodName = "get_accepted_or_own_meetup_list"
        DataManager.getAPIResponse(paraDict , methodName: methodName, methodType: "POST"){(responseData,error)-> Void in
             let status  = DataManager.getVal(responseData?["status"]) as? String ?? ""
             let message  = DataManager.getVal(responseData?["message"]) as? String ?? ""
                print(message)
             if status == "1" {
                print(DataManager.getVal(responseData?["data"]) as? [String:Any] ?? [:])
             }
             else {
                print(message)
             }
    }
    }
   

}
extension AcceptedMeetUpVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AcceptedMeetUpCell", for: indexPath) as! AcceptedMeetUpCell
        return cell
    }
    
    
}
