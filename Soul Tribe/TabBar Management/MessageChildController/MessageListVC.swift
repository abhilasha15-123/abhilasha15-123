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
    @IBOutlet weak var txt_search: UITextField!
    
    var ChatroomID = String()
    var chatUSerImageUrl = String()
    var comeVIbeType = String()
    var senderID = String()
    var arr_data = [[String:Any]]()
    var requestListDisplay = false
    
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
        api_call(vibe: SELECT_VIBE)
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
        messageListTableview.reloadData()
    }
    
    func api_call(vibe: String){
        self.arr_data.removeAll()
        
        basicFunctions.presentLoader()

        let parameterDictionary = NSMutableDictionary()
        parameterDictionary.setValue(Config().AppUserDefaults.value(forKey:"user_id") as? String ?? "", forKey: "user_id")
        parameterDictionary.setValue(vibe, forKey: "vibe")
        parameterDictionary.setValue(Config().api_key, forKey: "api_key")
        print(parameterDictionary)

        let methodName = "get_messages_users_list"
        
        DataManager.getAPIResponse(parameterDictionary , methodName: methodName, methodType: "POST"){(responseData,error)-> Void in
            let status  = DataManager.getVal(responseData?["status"]) as! String
            let message  = DataManager.getVal(responseData?["message"]) as! String

            if status == "1" {
//                self.view.makeToast(message)
                let dict = DataManager.getVal(responseData?["data"]) as? [String:Any] ?? [:]
                self.arr_data = DataManager.getVal(dict["messages"]) as? [[String:Any]] ?? []
                self.filteredArr = self.arr_data
            }
            else {
                self.view.makeToast("Please select vibe", duration: 2.0, position: .bottom, title: nil, image: nil, style: ToastManager.shared.style, completion: nil)
            }
            
            self.messageListTableview.reloadData()
   
            basicFunctions.stopLoading()
        }
    }
    @objc func ShowStoryBtn(_ sender: UIButton) {
        let dict = self.filteredArr[sender.tag]
        self.senderID = DataManager.getVal(dict["id"]) as? String ?? ""
        let snapsCount = DataManager.getVal(dict["snaps_count"]) as? String ?? ""
        if snapsCount == "0" {
            self.view.makeToast("Story not found")
        }else{
            let controller1 = SB_instaStory.instantiateViewController(identifier: "PresentStoryViewController") as! PresentStoryViewController
            controller1.comeUserID = self.senderID
            self.navigationController?.present(controller1, animated: true, completion: nil)
        }
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
        return filteredArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MessageListCell
        cell.cornorview.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        cell.cornorview.layer.shadowOpacity = 0.4
        cell.cornorview.layer.shadowOffset = .zero
        cell.cornorview.layer.shadowRadius = 4
        cell.cornorview.layer.cornerRadius = 12
        
        cell.img_profile.layer.cornerRadius = cell.img_profile.frame.size.width/2
        
        let dict = filteredArr[indexPath.row]
        self.ChatroomID = DataManager.getVal(dict["room"]) as? String ?? ""
        cell.lbl_name.text = DataManager.getVal(dict["name"]) as? String ?? ""
        cell.lbl_time.text = DataManager.getVal(dict["date_time"]) as? String ?? ""
        cell.lbl_msg.text = DataManager.getVal(dict["message"]) as? String ?? ""
        self.senderID = DataManager.getVal(dict["id"]) as? String ?? ""
        self.chatUSerImageUrl = "\(Config().baseImageUrl)\(DataManager.getVal(dict["profile_image"]) as? String ?? "")"
        cell.img_profile.sd_setImage(with: URL(string: self.chatUSerImageUrl), completed: nil)
        cell.showStoryBtn.tag = indexPath.row
        cell.showStoryBtn.addTarget(self, action: #selector(ShowStoryBtn), for: .touchUpInside)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if indexPath.row == 0{
        let dict = filteredArr[indexPath.row]
        self.senderID = DataManager.getVal(dict["id"]) as? String ?? ""
        self.ChatroomID = DataManager.getVal(dict["room"]) as? String ?? ""
        let userName = DataManager.getVal(dict["name"]) as? String ?? ""
        let profileImage = "\(Config().baseImageUrl)\(DataManager.getVal(dict["profile_image"]) as? String ?? "")"
            let controller = storyboard?.instantiateViewController(withIdentifier: "MessageVC") as! MessageVC
        controller.Come_chatUser_ID = self.senderID
        controller.Come_userName = userName
        controller.come_RoomID = self.ChatroomID
        controller.Come_user_profile_image = profileImage
        self.navigationController?.pushViewController(controller, animated: true)
//        }
    }
}
