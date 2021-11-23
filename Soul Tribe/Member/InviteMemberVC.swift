//
//  InviteMemberVC.swift
//  Soul Tribe
//
//  Created by Ashish Soni on 29/06/21.
//

import UIKit
class InviteMembercell: UITableViewCell{
  
    @IBOutlet weak var lblname: UILabel!
    @IBOutlet weak var btncheck: UIButton!
    @IBOutlet weak var img_member: UIImageView!
}
class InviteMemberVC: UIViewController {

    @IBOutlet weak var txt_search: UITextField!
    @IBOutlet weak var memberView: UIView!
    @IBOutlet weak var membertable: UITableView!
    @IBOutlet weak var cornorView: UIView!

    var arrData = [[String:Any]]()
    var filteredData = [[String:Any]]()
    
    
    var arrSelectedIds = [[String:Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txt_search.addTarget(self, action: #selector(searchRecordsAsPerText(_ :)), for: .editingChanged)
        
        cornorView.layer.cornerRadius = 6
        cornorView.layer.borderWidth = 1
        cornorView.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        memberView.layer.cornerRadius = 8
        
        membertable.delegate = self
        membertable.dataSource = self
        membertable.reloadData()
        
        filteredData = arrData
        
        api_getData()
        
        

        // Do any additional setup after loading the view.
    }
    
    @objc func searchRecordsAsPerText(_ textfield:UITextField) {
        filteredData.removeAll()
        if txt_search.text?.count != 0 {
            for anyObject in arrData {
                let dict = DataManager.getVal(anyObject) as? [String:Any] ?? [:]
                let range = (DataManager.getVal(dict["name"]) as? String ?? "").lowercased().range(of: txt_search.text ?? "", options: .caseInsensitive, range: nil,   locale: nil)

                if range != nil { filteredData.append(dict) }
            }
        } else { filteredData = arrData }
        membertable.reloadData()
    }
    
    
    func api_getData(){
//        basicFunctions.presentLoader()
        
        let parameterDictionary = NSMutableDictionary()
        parameterDictionary.setValue(Config().AppUserDefaults.value(forKey:"user_id") as? String ?? "", forKey: "user_id")
        parameterDictionary.setValue(Config().api_key, forKey: "api_key")
        print(parameterDictionary)

        let methodName = "get_invite_users_list"

        DataManager.getAPIResponse(parameterDictionary , methodName: methodName, methodType: "POST"){(responseData,error)-> Void in
            let status  = DataManager.getVal(responseData?["status"]) as! String
            let message  = DataManager.getVal(responseData?["message"]) as! String

            if status == "1" {
                self.arrData = DataManager.getVal(responseData?["data"]) as? [[String:Any]] ?? []
                self.filteredData = self.arrData

            }
            else {
                self.view.makeToast(message, duration: 2.0, position: .bottom, title: nil, image: nil, style: ToastManager.shared.style, completion: nil)
            }
            self.membertable.reloadData()
        }
    }
    
    
    @IBAction func crossBtnAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func inviteBtnAction(_ sender: Any) {
       
        self.dismiss(animated: true, completion: {
            NotificationCenter.default.post(name: NSNotification.Name("memberdata"), object: nil, userInfo: ["data":self.arrSelectedIds])
        })
    }
}
extension InviteMemberVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InviteMembercell", for: indexPath) as! InviteMembercell
        cell.img_member.layer.cornerRadius = cell.img_member.frame.size.width/2
        cell.img_member.contentMode = .scaleToFill
        
        let dict = filteredData[indexPath.row]
        cell.img_member.sd_setImage(with: URL(string:  "\(Config().baseImageUrl)\(DataManager.getVal(dict["profile_image"]) as? String ?? "")"), completed: nil)
        cell.lblname.text = DataManager.getVal(dict["name"]) as? String ?? ""
        
        cell.btncheck.tag = indexPath.row
        cell.btncheck.addTarget(self, action: #selector(memberSelected(_:)), for: .touchUpInside)
        
        cell.btncheck.isSelected = false
        for tempDict in arrSelectedIds{
            if DataManager.getVal(tempDict["id"]) as? String ?? "" == DataManager.getVal(dict["id"]) as? String ?? ""{
                cell.btncheck.isSelected = true
                break
            }
        }
        
        return cell
    }
    
    @objc func memberSelected(_ sender:UIButton){
        let dict = filteredData[sender.tag]
        
        var shouldAdd = false
        
        for i in 0..<arrSelectedIds.count{
            let tempDict = arrSelectedIds[i]
            if DataManager.getVal(tempDict["id"]) as? String ?? "" == DataManager.getVal(dict["id"]) as? String ?? ""{
                arrSelectedIds.remove(at: i)
                shouldAdd = true
                break
            }
        }
        
        if shouldAdd == false{
            arrSelectedIds.append(dict)
        }
        membertable.reloadData()
    }
}
