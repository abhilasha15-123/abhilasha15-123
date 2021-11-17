//
//  ExploreMeetUpVC.swift
//  Soul Tribe
//
//  Created by Ashish Soni on 29/06/21.
//

import UIKit


class ExploreMeetUpVC: UIViewController {

    @IBOutlet weak var btnback: UIButton!
    @IBOutlet weak var searchbar: UIView!
    @IBOutlet weak var headerview: UIView!
    @IBOutlet weak var exploreMeetupTableView: UITableView!
    
//MARK:- variables
    var ApiData = NSMutableArray()
    var ApiDict = NSMutableDictionary()
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        searchbar.layer.cornerRadius = 6
        searchbar.layer.borderWidth = 1
        searchbar.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        headerview.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        headerview.layer.shadowOpacity = 0.5
        headerview.layer.shadowOffset = .zero
        headerview.layer.shadowRadius = 5
        // Do any additional setup after loading the view.
    }
    @IBAction func backBtnAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)

    }

    @IBAction func btngotodetails(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(identifier: "MeetUpDetailVC") as! MeetUpDetailVC
        navigationController?.pushViewController(vc, animated: true)

    }
    func getData(){
        let paraDict = NSMutableDictionary()
        paraDict.setValue(Config().api_key, forKey: "api_key")
        paraDict.setValue("37", forKey: "user_id")
        paraDict.setValue("7.88888", forKey: "latitude")
        paraDict.setValue("8.66666", forKey: "longitude")
        
        let methodName = "get_mini_tribe_meetup_list"
        DataManager.getAPIResponse(paraDict , methodName: methodName, methodType: "POST"){(responseData,error)-> Void in
             let status  = DataManager.getVal(responseData?["status"]) as? String ?? ""
             let message  = DataManager.getVal(responseData?["message"]) as? String ?? ""
                print(message)
             if status == "1" {
                print(DataManager.getVal(responseData?["data"]) as? [String:Any] ?? [:])
                self.ApiData = DataManager.getVal(responseData?["data"]) as? NSMutableArray ?? []
                
//                print("apidict is \(self.ApiDict)")
//                print("apidata is \(self.ApiData)")
                self.exploreMeetupTableView.reloadData()
                
             }
             else {
                print(message)
             }
    }
    }
    

}
extension ExploreMeetUpVC: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(ApiData.count)
        return ApiData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExploreMeetUpcell", for: indexPath) as! ExploreMeetUpcell
        cell.viewcornor.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        cell.viewcornor.layer.shadowOpacity = 0.4
        cell.viewcornor.layer.shadowOffset = .zero
        cell.viewcornor.layer.shadowRadius = 8
        cell.viewcornor.layer.cornerRadius = 10
        let apidata = ApiData[indexPath.row]
        ApiDict = apidata as? NSMutableDictionary ?? [:]
        print("apidata is \(ApiDict)")
        cell.lbldate.text = ApiDict["meetup_date"] as? String ?? ""
        cell.lbllocation.text = ApiDict["meetup_location"] as? String ?? ""
        cell.lbltime.text = ApiDict["meetup_time"] as? String ?? ""
        cell.lbldetails.text = ApiDict["meetup_description"] as? String ?? ""
//        cell.lblname.text = ApiDict[""] as? String ?? ""
        cell.lblgoing.text = "\(ApiDict["meetup_going_members"] as? Int ?? 1) People Are Going"
        
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 265
    }
    
}
