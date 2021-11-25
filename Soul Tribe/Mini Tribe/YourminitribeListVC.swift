//
//  YourminitribeListVC.swift
//  Soul Tribe
//
//  Created by MAC-28 on 02/08/21.
//

import UIKit
class YourminitribeListcell: UITableViewCell{
    
//    @IBOutlet weak var btn_status: UIButton!
    @IBOutlet weak var lbl_membersCount: UIButton!
    @IBOutlet weak var lbl_name: UILabel!
    @IBOutlet weak var img_disp: UIImageView!
}

class YourminitribeListVC: UIViewController {
    @IBOutlet weak var searchview: UIView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var txt_search: UITextField!
    @IBOutlet weak var tableview: UITableView!
    
    
    var arr_data = [[String:Any]]()
    var filteredArr = [[String:Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchview.layer.cornerRadius = 6
        searchview.layer.borderWidth = 1
        searchview.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        tableview.delegate = self
        tableview.dataSource = self
        
        txt_search.addTarget(self, action: #selector(searchRecordsAsPerText(_ :)), for: .editingChanged)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        api_call()
    }
    
    @objc func searchRecordsAsPerText(_ textfield:UITextField) {
        filteredArr.removeAll()
        if txt_search.text?.count != 0 {
            for anyObject in arr_data {
                let dict = DataManager.getVal(anyObject) as? [String:Any] ?? [:]
                let range = (DataManager.getVal(dict["name"]) as? String ?? "").lowercased().range(of: txt_search.text ?? "", options: .caseInsensitive, range: nil,   locale: nil)

                if range != nil { filteredArr.append(dict) }
            }
        } else { filteredArr = arr_data }
        tableview.reloadData()
    }
    
    func api_call(){
        let paraDict = NSMutableDictionary()
        paraDict.setValue(Config().api_key, forKey: "api_key")
        paraDict.setValue(Config().AppUserDefaults.value(forKey:"user_id") as? String ?? "", forKey: "user_id")
            
        print(paraDict)
        
        let methodName = "get_my_mini_tribe"
        DataManager.getAPIResponse(paraDict , methodName: methodName, methodType: "POST"){(responseData,error)-> Void in
            let status  = DataManager.getVal(responseData?["status"]) as? String ?? ""
            let message  = DataManager.getVal(responseData?["message"]) as? String ?? ""
            print(message)
            if status == "1" {
                self.arr_data = DataManager.getVal(responseData?["data"]) as? [[String:Any]] ?? []
                self.filteredArr = self.arr_data
            }
            else {
                print(message)
            }
            
        self.tableview.reloadData()
        }
    }
}

extension YourminitribeListVC: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "YourminitribeListcell", for: indexPath) as! YourminitribeListcell
        
        cell.img_disp.layer.cornerRadius = cell.img_disp.frame.size.width/2
        cell.img_disp.contentMode = .scaleToFill
        
        let dict = filteredArr[indexPath.row]
        cell.lbl_name.text = DataManager.getVal(dict["name"]) as? String ?? ""
        cell.lbl_membersCount.setTitle("\(DataManager.getVal(dict["members_count"]) as? String ?? "") Members", for: .normal)
        cell.img_disp.sd_setImage(with: URL(string: "\(Config().baseImageUrl)\(DataManager.getVal(dict["image"]) as? String ?? "")"), completed: nil)
//        cell.btn_status.layer.cornerRadius = cell.btn_status.frame.size.width/2
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
}
