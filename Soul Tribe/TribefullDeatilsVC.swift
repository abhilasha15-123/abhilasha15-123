//
//  TribefullDeatilsVC.swift
//  Soul Tribe
//
//  Created by MAC-28 on 22/07/21.
//

import UIKit
class Tribefulltblcell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
   
    
    @IBOutlet weak var lbl_line: UILabel!
    @IBOutlet weak var constraint_top_vwCommentMake: NSLayoutConstraint!
    @IBOutlet weak var lbl_lastCommentUsername: UILabel!
    @IBOutlet weak var img_lastCommentUser: UIImageView!
    
    @IBOutlet weak var lbl_lastCommentUserComment: UILabel!
    @IBOutlet weak var vw_lastMsg: UIView!
    
    @IBOutlet weak var btn_sendComment: UIButton!
    
    @IBOutlet weak var img_user: UIImageView!    
    @IBOutlet weak var txt_comment: UITextField!
    @IBOutlet weak var img_comment_user: UIImageView!
    @IBOutlet weak var vw_comment: UIView!
    @IBOutlet weak var btn_shareMain: UIButton!
    @IBOutlet weak var btn_commentMain: UIButton!
    @IBOutlet weak var lbl_likeMain: UILabel!
    @IBOutlet weak var btn_likeMain: UIButton!
    @IBOutlet weak var lbl_commentCount: UILabel!
    @IBOutlet weak var btn_comment: UIButton!
    @IBOutlet weak var lbl_likeCount: UILabel!
    @IBOutlet weak var btn_like: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var lbl_description: UILabel!
    @IBOutlet weak var lbl_dateTime: UILabel!
    @IBOutlet weak var lbl_name: UILabel!
    
    
    @IBOutlet weak var pgControl: UIPageControl!
    @IBOutlet weak var constraint_height_collectionVw: NSLayoutConstraint!
    
    
    var arr_imgs = [[String:Any]]()
    
    override func awakeFromNib() {
        
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
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arr_imgs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Tribefullcollcell", for: indexPath) as! Tribefullcollcell
        
        let dict = arr_imgs[indexPath.row]
        cell.img_disp.sd_setImage(with: URL(string: "\(Config().baseImageUrl)\(DataManager.getVal(dict["images"]) as? String ?? "")"), completed: nil)
        
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

class Tribefullcollcell: UICollectionViewCell{
    
    @IBOutlet weak var img_disp: UIImageView!
}
class TribefullDeatilsVC: UIViewController {
    @IBOutlet weak var searchview: UIView!
  
    @IBOutlet weak var img_disp: UIImageView!
    @IBOutlet weak var tableview: UITableView!
   
    
    @IBAction func btn_createMeetupAction(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(identifier: "CreateMeetUpVC") as! CreateMeetUpVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBOutlet weak var txt_shareYourPerspective: UITextField!
    @IBOutlet weak var txt_search: UITextField!
    @IBOutlet weak var lbl_heading: UIButton!
    
    @IBAction func btn_backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btn_sharePerspective(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(identifier: "CreatePostVC") as! CreatePostVC
        vc.user_Img = DataManager.getVal(dict["image"]) as? String ?? ""
        vc.userName = DataManager.getVal(dict["name"]) as? String ?? ""
        vc.miniTribeId = DataManager.getVal(dict["id"]) as? String ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    var miniTribeId = ""
    var dict : [String:Any] = [:]
    var arr_postData = [[String:Any]]()
    var filteredData = [[String:Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txt_search.addTarget(self, action: #selector(searchRecordsAsPerText(_ :)), for: .editingChanged)
        
        
        searchview.layer.cornerRadius = 6
        searchview.layer.borderWidth = 1
        searchview.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        txt_shareYourPerspective.layer.cornerRadius = 5
        
        filteredData = arr_postData
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        api_call()
    }
    
    @IBAction func btninvite(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(identifier: "InviatationsVC") as! InviatationsVC
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @objc func searchRecordsAsPerText(_ textfield:UITextField) {
        filteredData.removeAll()
        if txt_search.text?.count != 0 {
            for anyObject in arr_postData {
                let dict = DataManager.getVal(anyObject) as? [String:Any] ?? [:]
                let range = (DataManager.getVal(dict["user_name"]) as? String ?? "").lowercased().range(of: txt_search.text ?? "", options: .caseInsensitive, range: nil,   locale: nil)

                if range != nil { filteredData.append(dict) }
            }
        } else { filteredData = arr_postData }
        tableview.reloadData()
    }
    
    func api_call(){
        basicFunctions.presentLoader()
        let paraDict = NSMutableDictionary()
        paraDict.setValue(Config().api_key, forKey: "api_key")
        paraDict.setValue("25", forKey: "user_id")
        paraDict.setValue(Config().AppUserDefaults.value(forKey:"user_id") as? String ?? "", forKey: "user_id")
        paraDict.setValue(miniTribeId, forKey: "mini_tribe_id")
        print(paraDict)

        let methodName = "get_detail_my_mini_tribe"
        DataManager.getAPIResponse(paraDict , methodName: methodName, methodType: "POST"){(responseData,error)-> Void in
            let status  = DataManager.getVal(responseData?["status"]) as? String ?? ""
            let message  = DataManager.getVal(responseData?["message"]) as? String ?? ""
            print(message)
            if status == "1" {
                self.dict = DataManager.getVal(responseData?["data"]) as? [String:Any] ?? [:]
                self.setupData()
            }
            else {
                self.view.makeToast(message)
            }
            
        self.tableview.reloadData()
        basicFunctions.stopLoading()
        }
    }
    
    func setupData(){
        self.img_disp.sd_setImage(with: URL(string:  "\(Config().baseImageUrl)\(DataManager.getVal(dict["image"]) as? String ?? "")"), completed: nil)
        self.img_disp.layer.cornerRadius = self.img_disp.frame.size.width/2
        self.lbl_heading.setTitle(DataManager.getVal(dict["name"]) as? String ?? "", for: .normal)
        self.arr_postData = DataManager.getVal(dict["miniTribePostData"]) as? [[String:Any]] ?? []
        self.filteredData = self.arr_postData
//        self.tableview.reloadData()
    }
}


extension TribefullDeatilsVC: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Tribefulltblcell", for: indexPath) as! Tribefulltblcell
        cell.txt_comment.layer.cornerRadius = 6
        cell.img_user.layer.cornerRadius = cell.img_user.frame.size.width/2
        cell.img_lastCommentUser.layer.cornerRadius = cell.img_lastCommentUser.frame.size.width/2
        cell.vw_lastMsg.layer.cornerRadius = 6
        
        let dict = filteredData[indexPath.row]
        cell.img_user.sd_setImage(with: URL(string: "\(Config().baseImageUrl)\(DataManager.getVal(dict["user_image"]) as? String ?? "")"), completed: nil)
       
        cell.lbl_name.text = DataManager.getVal(dict["user_name"]) as? String ?? ""
        cell.lbl_dateTime.text = DataManager.getVal(dict["date_time"]) as? String ?? ""
        cell.lbl_description.text = DataManager.getVal(dict["perspective"]) as? String ?? ""
        cell.lbl_likeCount.text = DataManager.getVal(dict["minitribePostLikeCount"]) as? String ?? ""
        cell.lbl_commentCount.text = DataManager.getVal(dict["minitribePostCommentCount"]) as? String ?? ""
        
        cell.txt_comment.text = ""

        let lastMsgPresent = DataManager.getVal(dict["last_comment"]) as? String ?? ""

        if lastMsgPresent == "" {
            cell.vw_lastMsg.isHidden = true
            cell.lbl_line.isHidden = true
            cell.constraint_top_vwCommentMake.constant = -90
            cell.lbl_lastCommentUsername.text = ""
            cell.lbl_lastCommentUserComment.text = ""
        }else{
            cell.vw_lastMsg.isHidden = false
            cell.lbl_line.isHidden = false
            cell.constraint_top_vwCommentMake.constant = 10

            cell.img_lastCommentUser.sd_setImage(with: URL(string: "\(Config().baseImageUrl)\(DataManager.getVal(dict["last_user_profile_image"]) as? String ?? "")"), completed: nil)
            cell.lbl_lastCommentUsername.text = DataManager.getVal(dict["last_user_name"]) as? String ?? ""
            cell.lbl_lastCommentUserComment.text = DataManager.getVal(dict["last_comment"]) as? String ?? ""
        }

        cell.btn_likeMain.tag = indexPath.row
        cell.btn_commentMain.tag = indexPath.row
        cell.btn_shareMain.tag = indexPath.row
        cell.btn_sendComment.tag = indexPath.row
        
        let isLiked = DataManager.getVal(dict["liked_status"]) as? String ?? ""
            
        if isLiked == "1"{
            cell.btn_likeMain.isSelected = true
            cell.lbl_likeMain.text = "Liked"
            cell.lbl_likeMain.textColor = UIColor.systemIndigo
           
        }else{
            cell.lbl_likeMain.text = "Like"
            cell.btn_likeMain.isSelected = false
            cell.lbl_likeMain.textColor = UIColor.lightGray.withAlphaComponent(0.6)
        }
        
        cell.btn_likeMain.addTarget(self, action: #selector(likeClicked(_:)), for: .touchUpInside)
        cell.btn_shareMain.addTarget(self, action: #selector(shareClicked(_:)), for: .touchUpInside)
        cell.btn_sendComment.addTarget(self, action: #selector(commentClicked(_:)), for: .touchUpInside)
        
        cell.arr_imgs = DataManager.getVal(dict["images"]) as? [[String:Any]] ?? []
        cell.pgControl.numberOfPages = cell.arr_imgs.count
        
        if cell.arr_imgs.count > 0 {
            cell.constraint_height_collectionVw.constant = 250
        }else{
            cell.constraint_height_collectionVw.constant = 0
        }

        cell.collectionView.reloadData()
        
        return cell
    }
    
    
    @objc func likeClicked(_ sender: UIButton){
        
        let dict = filteredData[sender.tag]
       
        let paraDict = NSMutableDictionary()
        paraDict.setValue(Config().api_key, forKey: "api_key")
        paraDict.setValue(DataManager.getVal(dict["id"]) as? String ?? "", forKey: "mini_tribe_post_id")
       paraDict.setValue(Config().AppUserDefaults.value(forKey:"user_id") as? String ?? "", forKey: "user_id")

      //  paraDict.setValue("25", forKey: "user_id")

        print(paraDict)
            
        let methodName = "create_mini_tribe_like"
        DataManager.getAPIResponse(paraDict , methodName: methodName, methodType: "POST"){(responseData,error)-> Void in
            let status  = DataManager.getVal(responseData?["status"]) as? String ?? ""
            let message  = DataManager.getVal(responseData?["message"]) as? String ?? ""
            print(message)
            if status == "1" {
                self.api_call()
            }
            else {
                self.view.makeToast(message)
            }
        }
    }
    
    @objc func commentClicked(_ sender: UIButton){
        self.view.endEditing(true)
        let dict = filteredData[sender.tag]
        let cell = tableview.cellForRow(at: IndexPath(row: sender.tag, section: 0)) as! Tribefulltblcell
      
        let paraDict = NSMutableDictionary()
        paraDict.setValue(Config().api_key, forKey: "api_key")
        paraDict.setValue(cell.txt_comment.text ?? "", forKey: "comment")
        paraDict.setValue(DataManager.getVal(dict["id"]) as? String ?? "", forKey: "mini_tribe_post_id")
       paraDict.setValue(Config().AppUserDefaults.value(forKey:"user_id") as? String ?? "", forKey: "user_id")

      //  paraDict.setValue("25", forKey: "user_id")

        print(paraDict)
            
        let methodName = "create_mini_tribe_comment"
        DataManager.getAPIResponse(paraDict , methodName: methodName, methodType: "POST"){(responseData,error)-> Void in
            let status  = DataManager.getVal(responseData?["status"]) as? String ?? ""
            let message  = DataManager.getVal(responseData?["message"]) as? String ?? ""
            print(message)
            if status == "1" {
                self.api_call()
            }
            else {
                self.view.makeToast(message)
            }
        }
    }
    
    @objc func shareClicked(_ sender: UIButton){
        
    }
}
