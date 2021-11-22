//
//  MessageRequestVC.swift
//  Soul Tribe
//
//  Created by MAC-28 on 15/07/21.
//

import UIKit
class MessageRequestCell: UITableViewCell{
    @IBOutlet weak var cornorview: UIView!
    @IBOutlet weak var lbl_time: UILabel!
    @IBOutlet weak var lbl_msg: UILabel!
    @IBOutlet weak var lbl_name: UILabel!
    @IBOutlet weak var img_profile: UIImageView!
}

class MessageRequestVC: UIViewController {
    @IBOutlet weak var searchview: UIView!
    @IBOutlet weak var Messagerequesttbl: UITableView!
    
    @IBOutlet weak var txt_search: UITextField!
    
    var arr_data = [[String:Any]]()
    var filteredArr = [[String:Any]]()
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        filteredArr = arr_data
        txt_search.addTarget(self, action: #selector(searchRecordsAsPerText(_ :)), for: .editingChanged)
        
        searchview.layer.cornerRadius = 6
        searchview.layer.borderWidth = 1
        searchview.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
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
        Messagerequesttbl.reloadData()
    }
    
    func api_call(){
        self.arr_data.removeAll()
        
        basicFunctions.presentLoader()

        let parameterDictionary = NSMutableDictionary()
        parameterDictionary.setValue(Config().AppUserDefaults.value(forKey:"user_id") as? String ?? "", forKey: "user_id")
        parameterDictionary.setValue("Soul Love", forKey: "vibe")
        parameterDictionary.setValue(Config().api_key, forKey: "api_key")
        print(parameterDictionary)

        let methodName = "get_messages_users_list"
        
        DataManager.getAPIResponse(parameterDictionary , methodName: methodName, methodType: "POST"){(responseData,error)-> Void in
            let status  = DataManager.getVal(responseData?["status"]) as! String
            let message  = DataManager.getVal(responseData?["message"]) as! String

            if status == "1" {
//                self.view.makeToast(message)
                let dict = DataManager.getVal(responseData?["data"]) as? [String:Any] ?? [:]
                self.arr_data = DataManager.getVal(dict["messages_request"]) as? [[String:Any]] ?? []
                self.filteredArr = self.arr_data
            }
            else {
                self.view.makeToast(message, duration: 2.0, position: .bottom, title: nil, image: nil, style: ToastManager.shared.style, completion: nil)
            }
            
            self.Messagerequesttbl.reloadData()
   
            basicFunctions.stopLoading()
        }
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
        return filteredArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageRequestCell", for: indexPath) as! MessageRequestCell
        cell.cornorview.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        cell.cornorview.layer.shadowOpacity = 0.4
        cell.cornorview.layer.shadowOffset = .zero
        cell.cornorview.layer.shadowRadius = 4
        cell.cornorview.layer.cornerRadius = 12
        cell.img_profile.layer.cornerRadius = cell.img_profile.frame.size.width/2
        
        let dict = filteredArr[indexPath.row]
        
        cell.lbl_name.text = DataManager.getVal(dict["name"]) as? String ?? ""
        cell.lbl_time.text = DataManager.getVal(dict["date_time"]) as? String ?? ""
        cell.lbl_msg.text = DataManager.getVal(dict["message"]) as? String ?? ""
        
        let urlStr = "\(Config().baseImageUrl)\(DataManager.getVal(dict["profile_image"]) as? String ?? "")"
        
        cell.img_profile.sd_setImage(with: URL(string: urlStr), completed: nil)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 85
       }
}
