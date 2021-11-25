//
//  GroupTribeTabVC.swift
//  Soul Tribe
//
//  Created by Ashish Soni on 07/06/21.
//

import UIKit


class minitribeGroupOptions : UITableViewCell{
    @IBOutlet weak var lbl_option: UILabel!
}

class GroupTribeTabVC: UIViewController,UITableViewDelegate,UITableViewDataSource,SlideMenuControllerDelegate {
    
    @IBAction func btn_cancelAction(_ sender: UIButton) {
        if btn_cenacel.title(for: .normal) == "Cancel"{
            vw_confirmation.isHidden = true
        }else{
            api_call_acceptReject(status: "2")
        }
    }
    
    @IBAction func btn_requestAction(_ sender: UIButton) {
        
        if btn_request.title(for: .normal) == "Request"{
            basicFunctions.presentLoader()
           
            let paraDict = NSMutableDictionary()
            paraDict.setValue(Config().api_key, forKey: "api_key")
            paraDict.setValue(selectedRequestJoinUserId, forKey: "user_id")
            paraDict.setValue(selectedMiniTribeId, forKey: "mini_tribe_id")
            paraDict.setValue(Config().AppUserDefaults.value(forKey:"user_id") as? String ?? "", forKey: "join_request_user_id")
            
            print(paraDict)
            
            let methodName = "request_to_join_mini_tribe"
            DataManager.getAPIResponse(paraDict , methodName: methodName, methodType: "POST"){(responseData,error)-> Void in
                let status  = DataManager.getVal(responseData?["status"]) as? String ?? ""
                let message  = DataManager.getVal(responseData?["message"]) as? String ?? ""
                print(message)
                if status == "1" {
                    self.vw_confirmation.isHidden = true
                    self.view.makeToast(message)
                    DispatchQueue.main.asyncAfter(deadline: .now()+1.5, execute: {
                        self.api_call()
                    })
                }
                else {
                    self.vw_confirmation.isHidden = true
                    self.view.makeToast(message)
                }
            basicFunctions.stopLoading()
            }
        }else{
            api_call_acceptReject(status: "1")
        }
    }
    
    @IBAction func btn_closePopupAction(_ sender: UIButton) {
        self.vw_confirmation.isHidden = true
    }
    
    @IBOutlet weak var btn_closePopup: ResponsiveButton!
    @IBOutlet weak var lbl_subviewHeading: UILabel!
    @IBOutlet weak var btn_cenacel: UIButton!
    @IBOutlet weak var btn_request: UIButton!
    @IBOutlet weak var vw_confirmation: UIView!
    @IBOutlet weak var vw_subView: UIView!
    @IBOutlet weak var txt_search: UITextField!
    @IBOutlet weak var tribeListTableview: UITableView!
    @IBOutlet weak var searchview: UIView!
    @IBOutlet weak var tableView_OptionsMiniTribe: UITableView!
    
    var leftDrawerTransition:DrawerTransition!
    var left = LeftMenuViewController()
    
    var arr_data = [[String:Any]]()
    var filteredArr = [[String:Any]]()
    
    var arr_tribeOptions = ["Create Mini Tribe","My Mini Tribes","Mini Tribes"]
    
    var selectedMiniTribeId = ""
    var selectedRequestJoinUserId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        btn_cenacel.layer.cornerRadius = 6
        btn_request.layer.cornerRadius = 6
        vw_subView.layer.cornerRadius = 6
        
        btn_cenacel.layer.borderWidth = 1
        btn_cenacel.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        vw_confirmation.isHidden = true
        
        searchview.layer.cornerRadius = 6
        searchview.layer.borderWidth = 1
        searchview.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        setupLeftDrawer(self)
        
        tableView_OptionsMiniTribe.layer.cornerRadius = 6
        
        filteredArr = arr_data
        txt_search.addTarget(self, action: #selector(searchRecordsAsPerText(_ :)), for: .editingChanged)

        tableView_OptionsMiniTribe.delegate = self
        tableView_OptionsMiniTribe.dataSource = self
        tableView_OptionsMiniTribe.reloadData()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView_OptionsMiniTribe.isHidden = true
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
        tribeListTableview.reloadData()
    }
    
    func api_call_acceptReject(status: String){
        basicFunctions.presentLoader()
        
        let paraDict = NSMutableDictionary()
        paraDict.setValue(Config().api_key, forKey: "api_key")
        paraDict.setValue(selectedRequestJoinUserId, forKey: "user_id")
        paraDict.setValue(selectedMiniTribeId, forKey: "mini_tribe_id")
        paraDict.setValue(Config().AppUserDefaults.value(forKey:"user_id") as? String ?? "", forKey: "invited_user_id")
        paraDict.setValue(status, forKey: "status")
        print(paraDict)
        
        let methodName = "accept_reject_invite_request_mini_tribe"
        DataManager.getAPIResponse(paraDict , methodName: methodName, methodType: "POST"){(responseData,error)-> Void in
            let status  = DataManager.getVal(responseData?["status"]) as? String ?? ""
            let message  = DataManager.getVal(responseData?["message"]) as? String ?? ""
            print(message)
            if status == "1" {
                self.vw_confirmation.isHidden = true
                self.view.makeToast(message)
                DispatchQueue.main.asyncAfter(deadline: .now()+1.5, execute: {
                    self.api_call()
                })
            }
            else {
                print(message)
            }
        basicFunctions.stopLoading()
        }
    }
    
    
    func api_call(){
        
        let paraDict = NSMutableDictionary()
        paraDict.setValue(Config().api_key, forKey: "api_key")
        paraDict.setValue(Config().AppUserDefaults.value(forKey:"user_id") as? String ?? "", forKey: "user_id")
            
        print(paraDict)
        
        let methodName = "get_mini_tribe"
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
            
        self.tribeListTableview.reloadData()
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tableView_OptionsMiniTribe{
            return arr_tribeOptions.count
        }else{
            return filteredArr.count
        }
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == tableView_OptionsMiniTribe{
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! minitribeGroupOptions
            cell.lbl_option.text = arr_tribeOptions[indexPath.row]
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! GroupTribeCell
            cell.mainview.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            cell.mainview.layer.shadowOpacity = 0.8
            cell.mainview.layer.shadowOffset = .zero
            cell.mainview.layer.shadowRadius = 8
            cell.mainview.layer.cornerRadius = 10
            
            cell.img_disp.layer.cornerRadius = cell.img_disp.frame.size.width/2
            cell.img_disp.contentMode = .scaleToFill
            
            let dict = filteredArr[indexPath.row]
            
            cell.img_disp.sd_setImage(with: URL(string: "\(Config().baseImageUrl)\(DataManager.getVal(dict["image"]) as? String ?? "")"), completed: nil)
            
            cell.lbl_name.text = DataManager.getVal(dict["name"]) as? String ?? ""
            cell.lbl_description.text = DataManager.getVal(dict["about"]) as? String ?? ""
            cell.btn_memberCount.setTitle("  \(DataManager.getVal(dict["members_count"]) as? String ?? "") Member", for: .normal)
            
            if DataManager.getVal(dict["tribe_status"]) as? String ?? "" == "join"{
                cell.btn_requestToJoin.setTitle("Request to Join", for: .normal)
            }
            else if DataManager.getVal(dict["tribe_status"]) as? String ?? "" == "requested"{
                cell.btn_requestToJoin.setTitle("Requested", for: .normal)
            }else if DataManager.getVal(dict["tribe_status"]) as? String ?? "" == "invited"{
                cell.btn_requestToJoin.setTitle("Invited", for: .normal)
            }else if DataManager.getVal(dict["tribe_status"]) as? String ?? "" == "joined"{
                cell.btn_requestToJoin.setTitle("Joined", for: .normal)
            }
           
            cell.btn_requestToJoin.tag = indexPath.row
            cell.btn_requestToJoin.addTarget(self, action: #selector(requestToJoinClicked(_:)), for: .touchUpInside)
            
            return cell
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == tableView_OptionsMiniTribe{
            if indexPath.row == 0{
                let vc = self.storyboard?.instantiateViewController(identifier: "CreateMiniTribeVC") as! CreateMiniTribeVC
                navigationController?.pushViewController(vc, animated: true)
            }else if indexPath.row == 1 {
                let vc = self.storyboard?.instantiateViewController(identifier: "YourminitribeListVC") as! YourminitribeListVC
                navigationController?.pushViewController(vc, animated: true)
            }else {
                
            }
        }else{
            let dict = arr_data[indexPath.row]
            if DataManager.getVal(dict["visibility_status"]) as? String ?? "" == "1" && (DataManager.getVal(dict["tribe_status"]) as? String ?? "" == "requested" || DataManager.getVal(dict["tribe_status"]) as? String ?? "" == "join"){
                let vc = self.storyboard?.instantiateViewController(identifier: "MiniTribeRequetedVC") as! MiniTribeRequetedVC
                vc.miniTribeId = DataManager.getVal(dict["id"]) as? String ?? ""
                navigationController?.pushViewController(vc, animated: true)
            }else {
                let vc = self.storyboard?.instantiateViewController(identifier: "MiniTribeJoinVC") as! MiniTribeJoinVC
                vc.miniTribeId = DataManager.getVal(dict["id"]) as? String ?? ""
                navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    @objc func requestToJoinClicked (_ sender : UIButton){
       
        let dict = filteredArr[sender.tag]
        selectedMiniTribeId = DataManager.getVal(dict["id"]) as? String ?? ""
        selectedRequestJoinUserId = DataManager.getVal(dict["user_id"]) as? String ?? ""
        
        if DataManager.getVal(dict["tribe_status"]) as? String ?? "" == "join"{
            lbl_subviewHeading.text = "Request to join this Mini Tribe"
            btn_request.setTitle("Request", for: .normal)
            btn_cenacel.setTitle("Cancel", for: .normal)
          
            vw_confirmation.isHidden = false
        }
        else if DataManager.getVal(dict["tribe_status"]) as? String ?? "" == "requested"{
        }else if DataManager.getVal(dict["tribe_status"]) as? String ?? "" == "invited"{
            lbl_subviewHeading.text = "Would you like to accept or reject this tribe request?"
            btn_request.setTitle("Accept", for: .normal)
            btn_cenacel.setTitle("Reject", for: .normal)
            
            vw_confirmation.isHidden = false
        }else if DataManager.getVal(dict["tribe_status"]) as? String ?? "" == "joined"{
        }
        
    }
    
    @IBAction func plusBtnAction(_ sender: Any) {
        tableView_OptionsMiniTribe.isHidden = !tableView_OptionsMiniTribe.isHidden
    }
    
    
    @IBAction func backBtnAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
   
    @IBAction func sideMenuBtnAction(_ sender: Any) {
        self.slideMenuController()?.toggleLeft()

  //      setSideMenu()
    }
    
    
    func setSideMenu() {
        self.leftDrawerTransition.presentDrawerViewController(animated: true)
    }
    
    
    //MARK: - Left drawer
    func setupLeftDrawer(_ controller: UIViewController) {
        
        self.leftDrawerTransition = DrawerTransition(target: controller, drawer: left)
        self.leftDrawerTransition.setPresentCompletion { print("left present...") }
        self.leftDrawerTransition.setDismissCompletion { print("left dismiss...") }
        self.leftDrawerTransition.edgeType = .left
        left.clickCellEvent { (indexpath) in
            
            //            if(indexpath.row == -1)
            //            {
            //                // NotificationCenter.default.post(name: Notification.Name("notifyMilesChange"), object: nil)
            //            }
            if(indexpath.row == 0){
               // let VC = self.storyboard?.instantiateViewController(withIdentifier: "TabBar") as! UITabBarController
               // self.navigationController?.pushViewController(VC, animated: true)
            }else if(indexpath.row == 1){
               // let vc = self.storyboard?.instantiateViewController(withIdentifier: "TermsConditionViewController") as! TermsConditionViewController
               // self.navigationController?.pushViewController(vc, animated: true)
            }else if(indexpath.row == 2) {
               // let vc = self.storyboard?.instantiateViewController(withIdentifier: "PrivacyPoliceVC") as! PrivacyPoliceVC
               // self.navigationController?.pushViewController(vc, animated: true)
            }
            else if indexpath.row == 3{
                //let vc = self.storyboard?.instantiateViewController(withIdentifier: "ContactUsViewController") as! ContactUsViewController
               // self.navigationController?.pushViewController(vc, animated: true)
            }else if indexpath.row == 4{
               // let vc = self.storyboard?.instantiateViewController(withIdentifier: "AboutUsViewController") as! AboutUsViewController
              //  self.navigationController?.pushViewController(vc, animated: true)
            }else if indexpath.row == 5{
                //let vc = self.storyboard?.instantiateViewController(withIdentifier: "FAQViewController") as! FAQViewController
                //self.navigationController?.pushViewController(vc, animated: true)
            }else{
                
//                let nextview = LogoutPopUp.intitiateFromNib()
//                let model = BackModel()
//
//                nextview.buttonYesHandler = {
//                    let deafults = UserDefaults.standard
//                    deafults.removeObject(forKey: "UserIDAutologin")
//                    deafults.set("0", forKey: "Logoutstatus")
//                    deafults.synchronize()
//
//                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
//                    self.navigationController?.pushViewController(vc, animated: true)
//                    model.closewithAnimation()
//                }
//
//                nextview.buttonNoHandler = {
//                    model.closewithAnimation()
//                }
                
               // model.showLogout(view: nextview)
            }
            self.leftDrawerTransition.dismissDrawerViewController()
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
