//
//  MatchListVC.swift
//  Soul Tribe
//
//  Created by Ashish Soni on 09/06/21.
//

import UIKit

class MatchListVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var searchview: UIView!
    @IBOutlet weak var matclistTableview: UITableView!
   
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
        matclistTableview.reloadData()
    }
    
    func api_call(){
        self.arr_data.removeAll()
        
        basicFunctions.presentLoader()

        let parameterDictionary = NSMutableDictionary()
        parameterDictionary.setValue(Config().AppUserDefaults.value(forKey:"user_id") as? String ?? "", forKey: "user_id")
        parameterDictionary.setValue("Soul Love", forKey: "vibe")
        parameterDictionary.setValue(Config().api_key, forKey: "api_key")
        print(parameterDictionary)

        let methodName = "get_matched_users_list"
        
        DataManager.getAPIResponse(parameterDictionary , methodName: methodName, methodType: "POST"){(responseData,error)-> Void in
            let status  = DataManager.getVal(responseData?["status"]) as! String
            let message  = DataManager.getVal(responseData?["message"]) as! String

            if status == "1" {
//                self.view.makeToast(message)
                self.arr_data = DataManager.getVal(responseData?["data"]) as? [[String:Any]] ?? []
                self.filteredArr = self.arr_data
            }
            else {
                self.view.makeToast(message, duration: 2.0, position: .bottom, title: nil, image: nil, style: ToastManager.shared.style, completion: nil)
            }
            
            self.matclistTableview.reloadData()
   
            basicFunctions.stopLoading()
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MatchListCell
        cell.cornorview.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        cell.cornorview.layer.shadowOpacity = 0.5
        cell.cornorview.layer.shadowOffset = .zero
        cell.cornorview.layer.shadowRadius = 5
        cell.cornorview.layer.cornerRadius = 12
        cell.img_profile.layer.cornerRadius = cell.img_profile.frame.size.width/2
        
        let dict = filteredArr[indexPath.row]
        
        cell.lbl_name.text = DataManager.getVal(dict["name"]) as? String ?? ""
       
        let urlStr = "\(Config().baseImageUrl)\(DataManager.getVal(dict["profile_image"]) as? String ?? "")"
        
        cell.img_profile.sd_setImage(with: URL(string: urlStr), completed: nil)
        return cell
    }
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 85
       }
    
    
}
