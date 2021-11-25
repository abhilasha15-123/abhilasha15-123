//
//  MiniTribeJoinVC.swift
//  Soul Tribe
//
//  Created by Ashish Soni on 01/07/21.
//

import UIKit


class MiniTribeJointblcell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
   
    @IBOutlet weak var pgControl: UIPageControl!
    
    @IBOutlet weak var constraint_collView_height: NSLayoutConstraint! //250
    @IBOutlet weak var imguser: UIImageView!
    @IBOutlet weak var lblusername: UILabel!
    @IBOutlet weak var lbldate_time: UILabel!
    @IBOutlet weak var lbldiscription: UILabel!
    @IBOutlet weak var btnreadmore: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var lbl_commentCount: UILabel!
    @IBOutlet weak var lbl_likeCount: UILabel!
    
    var arr_imgData = [[String:Any]] ()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.delegate = self
        collectionView.dataSource = self
       
        let customLayout = UICollectionViewFlowLayout()
        customLayout.itemSize = CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        customLayout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        customLayout.minimumInteritemSpacing = 0
        customLayout.minimumLineSpacing = 0
        customLayout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = customLayout
        
        pgControl.hidesForSinglePage = true

        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arr_imgData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MiniTribeJoinCollCell", for: indexPath) as! MiniTribeJoinCollCell
        
        let dict = arr_imgData[indexPath.row]
        cell.userimgcoll.sd_setImage(with: URL(string: "\(Config().baseImageUrl)\(DataManager.getVal(dict["images"]) as? String ?? "")" ), completed: nil)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width-10, height: collectionView.frame.height-10)
    }
    
  
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if pgControl.currentPage == indexPath.row {
            guard let visible = collectionView.visibleCells.first else { return }
            guard let index = collectionView.indexPath(for: visible)?.row else { return }
            pgControl.currentPage = index
        }
    }
}



class MiniTribeJoinCollCell: UICollectionViewCell{
    
    @IBOutlet weak var userimgcoll: UIImageView!
   
}
class MiniTribeJoinVC: UIViewController {
    
    @IBOutlet weak var btn_closePopup: ResponsiveButton!
    @IBOutlet weak var lbl_subviewHeading: UILabel!
    @IBOutlet weak var btn_cenacel: UIButton!
    @IBOutlet weak var btn_request: UIButton!
    @IBOutlet weak var vw_confirmation: UIView!
    @IBOutlet weak var vw_subView: UIView!
    
    @IBAction func btn_cancelAction(_ sender: UIButton) {
        if btn_cenacel.title(for: .normal) == "Cancel"{
            vw_confirmation.isHidden = true
        }else{
            api_call_acceptReject(status: "2")
        }
    }
    
    @IBAction func btn_requestAction(_ sender: UIButton) {
        
        if btn_request.title(for: .normal) == "Request" {
            basicFunctions.presentLoader()
            
            let paraDict = NSMutableDictionary()
            paraDict.setValue(Config().api_key, forKey: "api_key")
            paraDict.setValue(selectedRequestJoinUserId, forKey: "user_id")
            paraDict.setValue(miniTribeId, forKey: "mini_tribe_id")
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
                        self.api_getData()
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
    
    
    @IBAction func btn_joinAction(_ sender: UIButton) {
        miniTribeId = DataManager.getVal(dictData["id"]) as? String ?? ""
        selectedRequestJoinUserId = DataManager.getVal(dictData["user_id"]) as? String ?? ""
        
        if DataManager.getVal(dictData["tribe_status"]) as? String ?? "" == "join"{
            lbl_subviewHeading.text = "Request to join this Mini Tribe"
            btn_request.setTitle("Request", for: .normal)
            btn_cenacel.setTitle("Cancel", for: .normal)
          
            vw_confirmation.isHidden = false
        }
        else if DataManager.getVal(dictData["tribe_status"]) as? String ?? "" == "requested"{
        }else if DataManager.getVal(dictData["tribe_status"]) as? String ?? "" == "invited"{
            lbl_subviewHeading.text = "Would you like to accept or reject this tribe request?"
            btn_request.setTitle("Accept", for: .normal)
            btn_cenacel.setTitle("Reject", for: .normal)
            
            vw_confirmation.isHidden = false
        }else if DataManager.getVal(dictData["tribe_status"]) as? String ?? "" == "joined"{
        }
        
    }
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lbl_visibility: UILabel!
    @IBOutlet weak var lbl_name: UILabel!
    @IBOutlet weak var btnback: UIButton!
    @IBOutlet weak var imgprofile: UIImageView!
    @IBOutlet weak var lblmember: UILabel!
    @IBOutlet weak var btnjoin: UIButton!
    @IBOutlet weak var lbldiscription: UILabel!

    var miniTribeId = ""
    var selectedRequestJoinUserId = ""
    var dictData = [String:Any]()
    
    var arr_dataTable = [[String:Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        btn_cenacel.layer.cornerRadius = 6
        btn_request.layer.cornerRadius = 6
        vw_subView.layer.cornerRadius = 6
        
        btn_cenacel.layer.borderWidth = 1
        btn_cenacel.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        vw_confirmation.isHidden = true
        
        imgprofile.layer.cornerRadius = imgprofile.frame.size.width/2
        imgprofile.contentMode = .scaleToFill
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        api_getData()
    }
    
    @IBAction func backBtnAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    func api_call_acceptReject(status: String){
        basicFunctions.presentLoader()

        let paraDict = NSMutableDictionary()
        paraDict.setValue(Config().api_key, forKey: "api_key")
        paraDict.setValue(selectedRequestJoinUserId, forKey: "user_id")
        paraDict.setValue(miniTribeId, forKey: "mini_tribe_id")
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
                    self.api_getData()
                })
            }
            else {
                print(message)
            }
        basicFunctions.stopLoading()
        }
    }
    
    
    func api_getData(){
        
        let paraDict = NSMutableDictionary()
        paraDict.setValue(Config().api_key, forKey: "api_key")
        paraDict.setValue(Config().AppUserDefaults.value(forKey:"user_id") as? String ?? "", forKey: "user_id")
        paraDict.setValue(miniTribeId, forKey: "mini_tribe_id")
        
        print(paraDict)
        
        let methodName = "get_detail_mini_tribe"
        DataManager.getAPIResponse(paraDict , methodName: methodName, methodType: "POST"){(responseData,error)-> Void in
            let status  = DataManager.getVal(responseData?["status"]) as? String ?? ""
            let message  = DataManager.getVal(responseData?["message"]) as? String ?? ""
            print(message)
            if status == "1" {
                self.dictData = DataManager.getVal(responseData?["data"]) as? [String:Any] ?? [:]
                self.setupData()
            }
            else {
                print(message)
            }
      
        }
    }
    
    func setupData(){
        imgprofile.sd_setImage(with: URL(string: "\(Config().baseImageUrl)\(DataManager.getVal(self.dictData["image"]) as? String ?? "")"), completed: nil)
        
        self.lbl_name.text = DataManager.getVal(self.dictData["name"]) as? String ?? ""
        self.lblmember.text = "\(DataManager.getVal(self.dictData["members_count"]) as? String ?? "") members"
        self.lbldiscription.text = DataManager.getVal(self.dictData["about"]) as? String ?? ""
        
        let statusVisi = DataManager.getVal(self.dictData["visibility_status"]) as? String ?? ""
            
        if statusVisi == "2"{
            self.lbl_visibility.text = "Public"
        }else{
            self.lbl_visibility.text = "Private"
        }
        
        if statusVisi == "1"{
            tableView.isHidden = true
        }else{
            tableView.isHidden = false
        }
        
        
        if DataManager.getVal(self.dictData["tribe_status"]) as? String ?? "" == "join"{
            btnjoin.setTitle("Request to Join", for: .normal)
        }
        else if DataManager.getVal(self.dictData["tribe_status"]) as? String ?? "" == "requested"{
            btnjoin.setTitle("Requested", for: .normal)
        }else if DataManager.getVal(self.dictData["tribe_status"]) as? String ?? "" == "invited"{
            btnjoin.setTitle("Invited", for: .normal)
        }else if DataManager.getVal(self.dictData["tribe_status"]) as? String ?? "" == "joined"{
            btnjoin.setTitle("Joined", for: .normal)
        }
        
        arr_dataTable = DataManager.getVal(self.dictData["miniTribePostData"]) as? [[String:Any]] ?? []
        tableView.reloadData()
    }

}

extension MiniTribeJoinVC: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr_dataTable.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MiniTribeJointblcell", for: indexPath) as! MiniTribeJointblcell
        cell.imguser.layer.cornerRadius = cell.imguser.frame.size.width/2
        cell.imguser.contentMode = .scaleToFill
        
        let dict = arr_dataTable[indexPath.row]
        
        cell.imguser.sd_setImage(with: URL(string: "\(Config().baseImageUrl)\(DataManager.getVal(dict["user_image"]) as? String ?? "")"), completed: nil)
        cell.lblusername.text = DataManager.getVal(dict["user_name"]) as? String ?? ""
        cell.lbldiscription.text = DataManager.getVal(dict["meetup_description"]) as? String ?? ""
        cell.lbl_likeCount.text = DataManager.getVal(dict["minitribePostLikeCount"]) as? String ?? ""
        cell.lbl_commentCount.text = DataManager.getVal(dict["minitribePostCommentCount"]) as? String ?? ""
        cell.lbldate_time.text = DataManager.getVal(dict["date_time"]) as? String ?? ""
        
        cell.arr_imgData = DataManager.getVal(dict["images"]) as? [[String:Any]] ?? []
        cell.pgControl.numberOfPages = cell.arr_imgData.count
        
        if cell.arr_imgData.count > 0 {
            cell.constraint_collView_height.constant = 250
        }else{
            cell.constraint_collView_height.constant = 0
        }

        
    
        cell.collectionView.reloadData()
        return cell
    }
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 6
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MiniTribeJoinCollCell", for: indexPath) as! MiniTribeJoinCollCell
//        return cell
//    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//
//            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height/2);
//        }
}
