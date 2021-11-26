//
//  MessageVC.swift
//  Soul Tribe
//
//  Created by Ashish Soni on 29/06/21.
//

import UIKit
import SocketIO
import IQKeyboardManagerSwift
import SDWebImage
import Agrume
import MobileCoreServices

class MessageSend: UITableViewCell{
    @IBOutlet weak var imgSend: UIImageView!
    @IBOutlet weak var imgSendBg: UIImageView!
    @IBOutlet weak var lblMessageSend: UILabel!
    @IBOutlet weak var  lblSendTime: UILabel!

}
class MessageRec: UITableViewCell{
    @IBOutlet weak var  imgRec: UIImageView!
    @IBOutlet weak var  imgRecBg: UIImageView!
    @IBOutlet weak var lblMessageRec: UILabel!
    @IBOutlet weak var lblRecTime: UILabel!
}

class MessageVC: UIViewController,UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    
    
    @IBOutlet weak var HeaderView: MyView!
    @IBOutlet weak var UserImgView: MyImageView!
    @IBOutlet weak var UserNameLbl: UILabel!
    @IBOutlet weak var OnlineOfflineLbl: MyLabel!
    @IBOutlet weak var StatusLbl: UILabel!
    @IBOutlet weak var ChatTblView: UITableView!
    @IBOutlet weak var MessageTxtField: UITextField!
    
    @IBOutlet weak var BgScrollView: UIScrollView!
    @IBOutlet weak var AttachmentButton: ResponsiveButton!
    @IBOutlet weak var AttachmentWidthConstraint: NSLayoutConstraint!//30
    @IBOutlet weak var MainScrollBackView: UIView!
    @IBOutlet weak var SendImage: UIImageView!
    @IBOutlet weak var chatUserImageBtn: UIButton!
    
    @IBOutlet weak var BottomView: MyView!
    @IBOutlet weak var BottomSpaceConstraint: NSLayoutConstraint!
    @IBOutlet weak var BottomViewHeightConstraint: NSLayoutConstraint!//60
    
    var Come_chatUser_ID = String()
    var loginUser_ID = String()
    var MessageListArray = NSMutableArray()
    var ChatReceiverID = String()
    var businessId = String()
    var message_type = String()
    var image_array = [Any]()
    var file_extantion = String()
    var Come_user_profile_image = String()
    var newuserprofileid = String()
    var timer = Timer()
    var Come_userName = String()
    var provider_business_id = String()
    var mes:String!
    var mes1:String!
    var come_RoomID = String()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        print(businessId)
        self.timer.invalidate()
        
        IQKeyboardManager.shared.enableAutoToolbar = false
        
        SocketIoManager.one_to_one_sharedInstance.socket.connect(timeoutAfter: 2.0) {
            print("time _ out")
            SocketIoManager.one_to_one_sharedInstance.establishConnection()
            SocketIoManager.one_to_one_sharedInstance.connectToServerWithRoom(nickname: "joinUserRoom")
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        var dict = [String: Any]()
        dict = ["room": self.come_RoomID,"userid": self.loginUser_ID]
        print(dict)
        SocketIoManager.one_to_one_sharedInstance.socket.emit("login", dict)
        SocketIoManager.one_to_one_sharedInstance.socket.connect()
        SocketIoManager.one_to_one_sharedInstance.establishConnection()
        SocketIoManager.one_to_one_sharedInstance.connectToServerWithRoom(nickname: "joinUserRoom")
        
    }
    override func viewDidDisappear(_ animated: Bool) {
        IQKeyboardManager.shared.enableAutoToolbar = true
        self.timer.invalidate()
        var dict = [String: Any]()
        dict = ["room": self.come_RoomID,"userid": self.loginUser_ID]
        print(dict)
        SocketIoManager.one_to_one_sharedInstance.socket.emit("logout", dict)
        SocketIoManager.one_to_one_sharedInstance.socket.disconnect()
        SocketIoManager.one_to_one_sharedInstance.removeAllHandlers()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.UserNameLbl.text = self.Come_userName
        UserImgView.sd_setImage(with: URL(string: self.Come_user_profile_image), completed: nil)
        UserImgView.cornerRadious = UserImgView.frame.height/2
        loginUser_ID = Config().AppUserDefaults.value(forKey:"user_id") as? String ?? ""
        
//        headerview.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
//        headerview.layer.shadowOpacity = 0.5
//        headerview.layer.shadowOffset = .zero
//        headerview.layer.shadowRadius = 5

        
        self.StatusLbl.text = mes
        self.OnlineOfflineLbl.isHidden = false
        
        
        let Sender_nibClass = UINib(nibName: "SenderTableCell", bundle: nil)
        self.ChatTblView.register(Sender_nibClass, forCellReuseIdentifier: "SenderTableCell")
        
        let Reciver_nibClass = UINib(nibName: "ReciverTableCell", bundle: nil)
        self.ChatTblView.register(Reciver_nibClass, forCellReuseIdentifier: "ReciverTableCell")
        
        let ReciverImage_nibClass = UINib(nibName: "ReciverImageTableCell", bundle: nil)
        self.ChatTblView.register(ReciverImage_nibClass, forCellReuseIdentifier: "ReciverImageTableCell")
        
        let SenderImage_nibClass = UINib(nibName: "SenderImageTableCell", bundle: nil)
        self.ChatTblView.register(SenderImage_nibClass, forCellReuseIdentifier: "SenderImageTableCell")
        
        self.ChatTblView.rowHeight = UITableView.automaticDimension
        self.ChatTblView.dataSource = self
        self.ChatTblView.delegate = self
        
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                print("iPhone 5 or 5S or 5C")
                self.BottomSpaceConstraint.constant = 0
            case 1334:
                print("iPhone 6/6S/7/8")
                self.BottomSpaceConstraint.constant = 0
            case 1920, 2208:
                print("iPhone 6+/6S+/7+/8+")
                self.BottomSpaceConstraint.constant = 0
            case 2436:
                print("iPhone X/XS/11 Pro")
                self.BottomSpaceConstraint.constant = 30
            case 2688:
                print("iPhone XS Max/11 Pro Max")
                self.BottomSpaceConstraint.constant = 30
            case 1792:
                print("iPhone XR/ 11 ")
                self.BottomSpaceConstraint.constant = 30
            default:
                print("Unknown")
                self.BottomSpaceConstraint.constant = 30
            }
        }
        
        //        if DataManager.isConnectedToNetwork() == true{
        //            self.UserChat_API()
        //        }else{
        //            self.MessageListArray = DataManager.getVal(Config().AppUserDefaults.value(forKey: "ChatList")) as? [Any] ?? []
        //        }
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.new_showChatMessage(_:)), name: NSNotification.Name(rawValue: "new_message_coming"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.showChatMessage(_:)), name: NSNotification.Name(rawValue: "notificationNameStudent"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground), name: UIApplication.willTerminateNotification, object: nil)
        self.ChatTblView.keyboardDismissMode = .onDrag
        
                DispatchQueue.global(qos: .background).async {
                    DispatchQueue.main.async {
                        self.timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(self.ChatAPI), userInfo: nil, repeats: true)
                    }
                }
        self.UserChat_API()
        
        // Do any additional setup after loading the view.
    }
    
    @objc func willEnterForeground(notification: NSNotification) {
        var dict = [String: Any]()
        dict = ["role": "1","profile": self.loginUser_ID,"room": self.come_RoomID]
        print(dict)
        SocketIoManager.one_to_one_sharedInstance.socket.emit("logout", dict)
        SocketIoManager.one_to_one_sharedInstance.socket.disconnect()
    }
    
    //MARK:- keyboard Delegates
      @objc func showChatMessage(_ notification: NSNotification) {
          var dict = NSMutableArray()
          dict = notification.object as? NSMutableArray ?? []
          self.MessageListArray.removeAllObjects()
          
          self.MessageListArray.addObjects(from: dict as? [Any] ?? [])
//          self.MessageListArray.addObjects(from: dict as? [Any] ?? [])
          ChatTblView.reloadData()
          
          if self.MessageListArray.count > 0 {
              self.ChatTblView.scrollToRow(at: IndexPath(row: self.MessageListArray.count - 1, section: 0), at: .top, animated: false)
          }
      }
    
    @objc func new_showChatMessage(_ notification: NSNotification) {
        print("new message aaya")
        var dict = NSMutableDictionary()
        dict = notification.object as! NSMutableDictionary
        print(dict)
        
        self.MessageListArray.add(dict)
        self.ChatTblView.reloadData()
        self.scrollToBottom()
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "new_message_coming"), object: dict)
    }
    
    @objc func ChatAPI(){
        
//        self.userChatStatus_API1(user_profileid: self.newuserprofileid)
    }
    
    func UserChat_API(){
        //self.pleaseWait()
       // self.HeaderView.showLoader()//
      //  self.MainScrollBackView.showLoader()

        let Dict = NSMutableDictionary()
        Dict.setValue(DataManager.getVal(self.loginUser_ID), forKey: "user_id")
//        Dict.setValue(DataManager.getVal(""), forKey: "messgae")
        Dict.setValue(DataManager.getVal(Config().api_key), forKey: "api_key")
        Dict.setValue(DataManager.getVal(self.come_RoomID), forKey: "room")
        Dict.setValue(DataManager.getVal(SELECT_VIBE), forKey: "vibe")

        print(Dict)
        let methodName = "get_old_messages_list"

        DataManager.getAPIResponse(Dict,methodName: methodName, methodType: "POST") { (responseData,error) -> Void in

            DispatchQueue.main.async(execute: {

                let status = DataManager.getVal(responseData?.object(forKey: "status")) as? String ?? ""

                if status == "1" {
                    let dict = DataManager.getVal(responseData?.object(forKey: "data")) as! NSDictionary
                    self.MessageListArray = DataManager.getVal(dict["messages"]) as! NSMutableArray
                    Config().AppUserDefaults.setValue(self.MessageListArray, forKey: "ChatList")

                    self.ChatTblView.reloadData()
                    self.ChatTblView.backgroundView = nil
                    if self.MessageListArray.count != 0{
                        self.scrollToBottom()
                    }
                }

                //self.clearAllNotice()

            })
        }
    }
    
//    func userChatStatus_API1(user_profileid: String){
//        let Dict = NSMutableDictionary()
//        Dict.setValue(DataManager.getVal(""), forKey: "userid")
//        Dict.setValue(DataManager.getVal(""), forKey: "userkey")
//        Dict.setValue(DataManager.getVal(""), forKey: "user_profile_id")
//        Dict.setValue(DataManager.getVal(""), forKey: "status")
//
//        let methodName = "userChatStatus"
//
//        DataManager.getAPIResponse(Dict,methodName: methodName, methodType: "POST") { (responseData,error) -> Void in
//
//            let status = DataManager.getVal(responseData?.object(forKey: "status")) as? String ?? ""
//            //let message = DataManager.getVal(responseData?.object(forKey: "message")) as? String ?? ""
//
//            if status == "1" {
//                if let dict = DataManager.getVal(responseData?.object(forKey: "values")) as? NSDictionary{
//                    let chat_status = DataManager.getVal(dict["chat_status"]) as? String ?? ""
//                    if chat_status == "1"{
//                        self.StatusLbl.text = self.mes
//                        self.OnlineOfflineLbl.isHidden = false
//                    }else{
//                        self.StatusLbl.text = self.mes1
//                        self.OnlineOfflineLbl.isHidden = true
//                    }
//                }
//            }
//        }
//    }
    
//    func userChatStatus_API(user_profileid: String){
//
//       // self.pleaseWait()
//
//        let Dict = NSMutableDictionary()
//        Dict.setValue(DataManager.getVal(self.loginUser_ID), forKey: "userid")
//        Dict.setValue(DataManager.getVal(Config().api_key), forKey: "api_key")
//        Dict.setValue(DataManager.getVal(""), forKey: "user_profile_id")
//        Dict.setValue(DataManager.getVal(""), forKey: "status")
//
//        let methodName = "userChatStatus"
//
//        DataManager.getAPIResponse(Dict,methodName: methodName, methodType: "POST") { (responseData,error) -> Void in
//
//            let status = DataManager.getVal(responseData?.object(forKey: "status")) as? String ?? ""
//            let message = DataManager.getVal(responseData?.object(forKey: "message")) as? String ?? ""
//
//            if status == "1" {
//                if let dict = DataManager.getVal(responseData?.object(forKey: "values")) as? NSDictionary{
//                    let chat_status = DataManager.getVal(dict["chat_status"]) as? String ?? ""
//                    if chat_status == "1"{
//                        self.StatusLbl.text = self.mes
//                        self.OnlineOfflineLbl.isHidden = false
//                    }else{
//                        self.StatusLbl.text = self.mes1
//                        self.OnlineOfflineLbl.isHidden = true
//                    }
//                }
//            }else{
//               // Config().error(message: message)
//            }
//          //  self.clearAllNotice()
//        }
//    }
    
    @objc func ReportButtonAction(sender: UIButton){
        
        var mes:String!
        var mes1:String!
        var mes2:String!
        var mes3:String!
        var mes4:String!
      
        mes  = "Delete"
        mes1 = "Cancel"
        mes2 = "Please Select"
        mes3 = "Block"
        mes4 = "Block & Delete"
               
            let actionSheetController = UIAlertController(title: mes2, message: "", preferredStyle: .actionSheet)
            
            let cancelAction = UIAlertAction(title: mes1, style: .cancel) { action -> Void in
            }
            actionSheetController.addAction(cancelAction)
            
            let takePictureAction = UIAlertAction(title: mes, style: .default) { action -> Void in
                self.ChatMessageDeleteAPI(room: self.come_RoomID)
            }
            actionSheetController.addAction(takePictureAction)
            
            let BlockAction = UIAlertAction(title: mes3, style: .destructive) { action -> Void in
                self.BlockAPI()
            }
            actionSheetController.addAction(BlockAction)
            
            let BlockanddeleteAction = UIAlertAction(title: mes4, style: .destructive) { action -> Void in
                self.BlockAndDeleteAPI()
            }
            actionSheetController.addAction(BlockanddeleteAction)
            actionSheetController.popoverPresentationController?.sourceView = sender as UIView
            
            self.present(actionSheetController, animated: true, completion: nil)
        
    }
    
    @IBAction func MediaButtonAction(_ sender: ResponsiveButton) {
        
        var mes:String!
        var mes1:String!
        var mes2:String!
        var mes3:String!
        var mes4:String!
        
            mes = "Document/File"
            mes1 = "Photo Library"
            mes2 = "Choose your source"
            mes3 = "Camera"
            mes4 = "Cancel"

        let Picker = UIImagePickerController()
        Picker.delegate = self
        
        let actionSheet = UIAlertController(title: nil, message: mes2, preferredStyle: UIAlertController.Style.actionSheet)
        actionSheet.modalPresentationStyle = .popover
        actionSheet.addAction(UIAlertAction(title: mes3, style: .default, handler: {(action:UIAlertAction) in
            
            Picker.sourceType = .camera
            self.present(Picker, animated: true, completion: nil)
        }))
        
        actionSheet.addAction(UIAlertAction(title: mes1, style: .default, handler: {(action:UIAlertAction) in
            
            Picker.sourceType = .photoLibrary
            self.present(Picker, animated: true, completion: nil)
        }))
        actionSheet.addAction(UIAlertAction(title: mes, style: .default, handler: {(action:UIAlertAction) in
            let importMenu = UIDocumentMenuViewController(documentTypes: [String(kUTTypePDF),String(kUTTypeText),String(kUTTypeContent),String(kUTTypeItem),String(kUTTypeData)], in: .import)
            importMenu.delegate = self
            importMenu.modalPresentationStyle = .formSheet
            self.present(importMenu, animated: true, completion: nil)
            
        }))
        if let popoverPresentationController = actionSheet.popoverPresentationController {
            popoverPresentationController.sourceView = self.view
            popoverPresentationController.sourceRect = sender.bounds
        }
        actionSheet.addAction(UIAlertAction(title: mes4, style: .cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
        
    }
    
    @IBAction func optionBlockReport(_ sender: UIButton) {
        var mes:String!
        var mes1:String!
        var mes2:String!
        
        mes  = "Delete"
        mes1 = "Cancel"
        mes2 = "Block"
               
            let actionSheetController = UIAlertController(title: "select", message: "", preferredStyle: .actionSheet)
            
            let cancelAction = UIAlertAction(title: mes1, style: .cancel) { action -> Void in
                
            }
            actionSheetController.addAction(cancelAction)
            
        let DeleteAction = UIAlertAction(title: mes, style: .default) { action -> Void in
                
                self.ChatMessageDeleteAPI(room: self.come_RoomID)
            }
            actionSheetController.addAction(DeleteAction)
        let blockAction = UIAlertAction(title: mes2, style: .default) { action -> Void in
//                self.ChatMessageDeleteAPI(room: self.come_RoomID)
        }
        actionSheetController.addAction(blockAction)
            
//            let BlockAction = UIAlertAction(title: mes3, style: .destructive) { action -> Void in
//                self.BlockAPI()
//            }
//            actionSheetController.addAction(BlockAction)
            
//            let BlockanddeleteAction = UIAlertAction(title: mes4, style: .destructive) { action -> Void in
//                self.BlockAndDeleteAPI()
//            }
//            actionSheetController.addAction(BlockanddeleteAction)
        
            actionSheetController.popoverPresentationController?.sourceView = sender as UIView
            
            self.present(actionSheetController, animated: true, completion: nil)
    }
    
    @IBAction func SendButtonAction(_ sender: ResponsiveButton) {
       
        self.view.endEditing(true)
//        let user_profile_id = DataManager.getVal(Config().AppUserDefaults.object(forKey: "user_profile_id")) as? String ?? ""
        let now = Date()
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "hh:mm"
        let dateString = formatter.string(from: now)
        
        if isBlank(self.MessageTxtField) {
            if self.SendImage.image == nil{
                
            }else{
                self.ChatImgUploadAPI()
            }
        }else{
            if 0<(self.MessageTxtField.text?.count)!{
                self.message_type = "1"
                let now = Date()
                let formatter = DateFormatter()
                formatter.timeZone = TimeZone.current
                formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                let dateString = formatter.string(from: now)
                
                SocketIoManager.one_to_one_sharedInstance.sendMessage(withSender: self.loginUser_ID, withReciver: self.Come_chatUser_ID, message: self.MessageTxtField.text ?? "", withRoom: self.come_RoomID, type: "", mime_type: "", created_at: dateString, message_type: "1", vibe: SELECT_VIBE)
                
                
                
                if MessageListArray.count > 0 {

                                       let chatDict = NSMutableDictionary()
                                       chatDict.setObject(String(self.loginUser_ID), forKey: "sender_id" as NSCopying)
                                       chatDict.setObject(String(self.Come_chatUser_ID), forKey: "receiver_id" as NSCopying)
                                       chatDict.setObject(self.MessageTxtField.text ?? "", forKey: "message" as NSCopying)
                                       chatDict.setObject(dateString, forKey: "date_time" as NSCopying)
                                       chatDict.setObject(self.come_RoomID, forKey: "room" as NSCopying)
                                       
                    self.MessageListArray.add(chatDict)
                    self.MessageTxtField.text = ""
                                       self.ChatTblView.reloadData()
                                       let indexPath = IndexPath(row: self.MessageListArray.count-1, section: 0)
                                       self.ChatTblView.scrollToRow(at: indexPath, at: .bottom, animated: true)
                                       
                    UserChat_API()
                                       
                                   }
                else{
                    UserChat_API()
                }
                
//
//                self.MessageTxtField.text = ""
//                DispatchQueue.main.async {
//                    self.ChatTblView.reloadData()
//                }
//                if self.MessageListArray.count != 0{
//                    self.ChatTblView.scrollToRow(at: IndexPath(row: self.MessageListArray.count - 1, section: 0), at: .bottom, animated: true)
//                }
            }
        }
    }
    
    func scrollToBottom(){
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: self.MessageListArray.count-1, section: 0)
            self.ChatTblView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.MessageListArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dict = DataManager.getVal(self.MessageListArray[indexPath.row]) as! NSDictionary
        let type = DataManager.getVal(dict["message_type"]) as? String ?? ""
        let sender_profile_id = DataManager.getVal(dict["sender_id"]) as? String ?? ""
        let message = DataManager.getVal(dict["message"]) as? String ?? ""
        let status = DataManager.getVal(dict["is_read"]) as? String ?? ""
        let fileType = DataManager.getVal(dict["mime_type"]) as? String ?? ""
        let time = DataManager.getVal(dict["date_time"]) as? String ?? ""
        let profileImage = DataManager.getVal(dict["profile_image"]) as? String ?? ""
        if self.loginUser_ID == sender_profile_id{
            if type == "1"{ //text message
                let cell = tableView.dequeueReusableCell(withIdentifier: "SenderTableCell", for: indexPath) as! SenderTableCell
                cell.TitleLbl.text = message
                cell.timelbl.text = time
                
                if status == "2"{
                    cell.ReadImg.image = UIImage(named: "Read")
                }else{
                    cell.ReadImg.image = UIImage(named: "Tick")
                }
                return cell
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "ReciverImageTableCell", for: indexPath) as! ReciverImageTableCell
                if fileType == "png" || fileType == "jpg" || fileType == "jpeg"{
                    cell.imgView.sd_setImage(with: URL(string: Config().baseImageUrl + message), completed: nil)
                //    Config().setimage(image_url: message, image_name: cell.imgView)
                }else{
                    cell.imgView.image = UIImage(named: "Document")
                }
                if status == "2"{
                    cell.ReadUnReadImgView.image = UIImage(named: "Read")
                }else{
                    cell.ReadUnReadImgView.image = UIImage(named: "Tick")
                }
                cell.timeLbl.text = time
                return cell
            }
            
        }else{
            if type == "1"{//text message
                let cell = tableView.dequeueReusableCell(withIdentifier: "ReciverTableCell", for: indexPath) as! ReciverTableCell
                cell.TitleLbl.text = message
                cell.timelbl.text = time
                cell.imgView.sd_setImage(with: URL(string: Config().baseImageUrl + profileImage), completed: nil)
              //  Config().setimage(image_url: self.user_profile_image, image_name: cell.imgView)
                return cell
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "SenderImageTableCell", for: indexPath) as! SenderImageTableCell
                if fileType == "png" || fileType == "jpg" || fileType == "jpeg"{
                 //   Config().setimage(image_url: message, image_name: cell.imgView)
                }else{
                    cell.imgView.image = UIImage(named: "Document")
                }
             //   Config().setimage(image_url: self.user_profile_image, image_name: cell.ProfileImgView)
                cell.timeLbl.text = time
                return cell
            }
        }
    }
    
    @IBAction func backBtnAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
}

extension MessageVC: UIDocumentMenuDelegate, UIDocumentPickerDelegate{
    /*func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
     var imageData = Data()
     do {
     imageData = try Data(contentsOf: url as URL)
     } catch {
     print("Unable to load data: \(error)")
     }
     self.file_extantion = url.pathExtension
     self.SendImage.isHidden = false
     self.SendImage.image = UIImage(named: "Document")
     
     let dict = ["image_data": imageData,"status":"doc"] as [String: Any]
     self.image_array.append(dict)
     }*/
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        var imageData = Data()
        
        do {
            imageData = try Data(contentsOf: url as URL)
        } catch {
            print("Unable to load data: \(error)")
        }
        self.file_extantion = url.pathExtension
        
        if self.file_extantion == "PDF" {
            let dict = ["image_data": imageData,"status":"doc"] as [String: Any]
            self.image_array.append(dict)
            self.SendImage.isHidden = false
            self.SendImage.image = UIImage(named: "Document")
        }else if self.file_extantion == "pdf" {
            let dict = ["image_data": imageData,"status":"doc"] as [String: Any]
            self.image_array.append(dict)
            self.SendImage.isHidden = false
            self.SendImage.image = UIImage(named: "Document")
        }else if self.file_extantion == "docx" {
            let dict = ["image_data": imageData,"status":"doc"] as [String: Any]
            self.image_array.append(dict)
            self.SendImage.isHidden = false
            self.SendImage.image = UIImage(named: "Document")
        }else if self.file_extantion == "xls" {
            let dict = ["image_data": imageData,"status":"doc"] as [String: Any]
            self.image_array.append(dict)
            self.SendImage.isHidden = false
            self.SendImage.image = UIImage(named: "Document")
        }else if self.file_extantion == "doc" {
            let dict = ["image_data": imageData,"status":"doc"] as [String: Any]
            self.image_array.append(dict)
            self.SendImage.isHidden = false
            self.SendImage.image = UIImage(named: "Document")
        }else if self.file_extantion == "xlsx" {
            let dict = ["image_data": imageData,"status":"doc"] as [String: Any]
            self.image_array.append(dict)
            self.SendImage.isHidden = false
            self.SendImage.image = UIImage(named: "Document")
        }else if self.file_extantion == "jpg" {
            let dict = ["image_data": imageData,"status":"doc"] as [String: Any]
            self.image_array.append(dict)
            self.SendImage.isHidden = false
            self.SendImage.image = UIImage(named: "Document")
        }else if self.file_extantion == "exe" {
            let dict = ["image_data": imageData,"status":"doc"] as [String: Any]
            self.image_array.append(dict)
            self.SendImage.isHidden = false
            self.SendImage.image = UIImage(named: "Document")
        }else {
           
        }
    }
    func documentMenu(_ documentMenu: UIDocumentMenuViewController, didPickDocumentPicker documentPicker: UIDocumentPickerViewController) {
        UINavigationBar.appearance().tintColor = UIColor.black
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.black], for: .normal)
        
        documentPicker.delegate = self
        documentPicker.modalPresentationStyle = .overCurrentContext
        self.present(documentPicker, animated: true, completion: nil)
    }
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        /// Picker was cancelled! Duh 🤷🏻‍♀️
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true
                       , completion: {
                        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage{
                            self.SendImage.image = image
                            self.SendImage.isHidden = false
                            self.MessageTxtField.isHidden = true
                            let dict = ["image_data": image,"status":"image"] as [String: Any]
                            self.image_array.append(dict)
                        }else{
                            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
                                self.SendImage.image = image
                                self.SendImage.isHidden = false
                                self.MessageTxtField.isHidden = true
                                let dict = ["image_data": image,"status":"image"] as [String: Any]
                                self.image_array.append(dict)
                            }
                        }
                       })
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    func isBlank (_ textfield:UITextField) -> Bool {
        
        let thetext = textfield.text
        let trimmedString = thetext!.trimmingCharacters(in: CharacterSet.whitespaces)
        if trimmedString.isEmpty {
            return true
        }
        return false
    }
    
    //MARK:- TextField Delegate
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.MessageTxtField.resignFirstResponder()
        return true
    }
    @objc func keyboardWillShow(notification: NSNotification) {
        let topBarHeight = UIApplication.shared.statusBarFrame.size.height + (self.navigationController?.navigationBar.frame.height ?? 0.0)
        print(topBarHeight)
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            
            return
        }
        self.MainScrollBackView.frame.origin.y = 0 - keyboardSize.height //+ topBarHeight
        print(self.MainScrollBackView.frame.origin.y)
        print(keyboardSize)
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        let topBarHeight = UIApplication.shared.statusBarFrame.size.height + (self.navigationController?.navigationBar.frame.height ?? 0.0) - 80
        print(topBarHeight)
        self.MainScrollBackView.frame.origin.y = topBarHeight
    }
    //MARK:-Image Upload API
    func ChatImgUploadAPI(){
        
        //self.pleaseWait()
        
        let Dict = NSMutableDictionary()
        Dict.setValue(DataManager.getVal(self.loginUser_ID), forKey: "userid")
        Dict.setValue(DataManager.getVal(Config().api_key), forKey: "api_key")
        Dict.setValue(DataManager.getVal(self.come_RoomID), forKey: "room")
        
        
        let dict = DataManager.getVal(self.image_array[0]) as! [String: Any]
        let status = DataManager.getVal(dict["status"]) as? String ?? ""
        
        //For upload image
        let dataArr = NSMutableArray()
        let dataDict = NSMutableDictionary()
        dataDict.setValue("file", forKey: "image")
        if status == "doc"{//document
            dataDict.setValue(DataManager.getVal(dict["image_data"]) as! Data, forKey: "document_data")
            dataDict.setValue(self.file_extantion, forKey: "ext")
        }else{//image
            //dataDict.setValue((DataManager.getVal(dict["image_data"]) as! UIImage).pngData()!, forKey: "document_data")
            dataDict.setValue(self.resizeImage(image: (DataManager.getVal(dict["image_data"]) as! UIImage), targetSize: CGSize(width: 1500, height: 1500)).pngData(), forKey: "document_data")
            
            dataDict.setValue("png", forKey: "ext")
        }
        dataArr.add(dataDict)
        print(dataArr)
        
        let MethodName = "chat_file_upload"
        
        DataManager.UploadSingleDocumentFile(parameterDictionary: Dict, methodName: MethodName ,dataArray: dataArr){(responseData,error)-> Void in
            
            let status = DataManager.getVal(responseData?.object(forKey: "status")) as? String ?? ""
            let message = DataManager.getVal(responseData?.object(forKey: "message")) as? String ?? ""
            
            if status == "1" {
                self.image_array.removeAll()
                let filesURL = DataManager.getVal(responseData?.object(forKey: "filesURL")) as? String ?? ""
                //let fileType = DataManager.getVal(responseData?.object(forKey: "fileType")) as? String ?? ""
//                let user_profile_id = DataManager.getVal(Config().AppUserDefaults.object(forKey: "user_profile_id")) as? String ?? ""
                self.SendImage.image = nil
                self.MessageTxtField.isHidden = false
                self.SendImage.isHidden = true
                
                self.message_type = "2"
                
                let now = Date()
                let formatter = DateFormatter()
                formatter.timeZone = TimeZone.current
                formatter.dateFormat = "hh:mm"
                
                let dateString = formatter.string(from: now)
                SocketIoManager.one_to_one_sharedInstance.sendMessage(withSender: self.loginUser_ID, withReciver: self.Come_chatUser_ID, message: filesURL, withRoom: self.come_RoomID, type: self.message_type, mime_type: "", created_at: dateString, message_type: "2", vibe: SELECT_VIBE)

                
                self.MessageTxtField.text = ""
                //                DispatchQueue.main.async {
                //                    self.ChatTblView.reloadData()
                //                }
                //self.UserChat_API()
                //                if self.MessageListArray.count != 0{
                //                    self.ChatTblView.scrollToRow(at: IndexPath(row: self.MessageListArray.count - 1, section: 0), at: .bottom, animated: true)
                //                }
            }else{
            //    Config().error(message: message)
            }
        //    self.clearAllNotice()
        }
    }
    
    //MARK:- Delete All Message
    func ChatMessageDeleteAPI(room: String){
        
        //self.pleaseWait()
        
        let Dict = NSMutableDictionary()
        Dict.setValue(DataManager.getVal(self.loginUser_ID), forKey: "userid")
        Dict.setValue(DataManager.getVal(Config().api_key), forKey: "api_key")
        Dict.setValue(DataManager.getVal(self.come_RoomID), forKey: "room")
      
        let methodName = "delete_old_messages"
        
        DataManager.getAPIResponse(Dict,methodName: methodName, methodType: "POST") { (responseData,error) -> Void in
            
            let status = DataManager.getVal(responseData?.object(forKey: "status")) as? String ?? ""
            let message = DataManager.getVal(responseData?.object(forKey: "message")) as? String ?? ""
            
            if status == "1" {
                self.UserChat_API()
            }else{
                
            }
           // self.clearAllNotice()
        }
    }
    //MARK:- Delete All Message
    func BlockAPI(){
        
       // self.pleaseWait()
        
        let Dict = NSMutableDictionary()
        Dict.setValue(DataManager.getVal(""), forKey: "userid")
        Dict.setValue(DataManager.getVal(""), forKey: "userkey")
        Dict.setValue(DataManager.getVal(""), forKey: "user_profile_id")
        Dict.setValue(DataManager.getVal(self.ChatReceiverID), forKey: "block_profile_id")
        
        Dict.setValue(DataManager.getVal("1"), forKey: "status")
        
        let methodName = "userChatBlocking"
        
        DataManager.getAPIResponse(Dict,methodName: methodName, methodType: "POST") { (responseData,error) -> Void in
            
            let status = DataManager.getVal(responseData?.object(forKey: "status")) as? String ?? ""
            let message = DataManager.getVal(responseData?.object(forKey: "message")) as? String ?? ""
            
            if status == "1" {
              
                self.UserChat_API()
            }else{
                
            }
           // self.clearAllNotice()
        }
    }
    //MARK:- Delete And Block User
    func BlockAndDeleteAPI(){
        
      ///  self.pleaseWait()
        
        let Dict = NSMutableDictionary()
        Dict.setValue(DataManager.getVal(""), forKey: "userid")
        Dict.setValue(DataManager.getVal(""), forKey: "user_profile_id")
        Dict.setValue(DataManager.getVal(self.ChatReceiverID), forKey: "block_profile_id")
        Dict.setValue(DataManager.getVal(self.come_RoomID), forKey: "room")
        Dict.setValue(DataManager.getVal(self.businessId), forKey: "business_id")
        
        let methodName = "deleteAndBlockUserThread"
        
        DataManager.getAPIResponse(Dict,methodName: methodName, methodType: "POST") { (responseData,error) -> Void in
            
            let status = DataManager.getVal(responseData?.object(forKey: "status")) as? String ?? ""
            let message = DataManager.getVal(responseData?.object(forKey: "message")) as? String ?? ""
            
            if status == "1" {
//                Config().success(message: message)
//                let vc = MessageListVC(nibName: "MessageListVC", bundle: nil)
//                self.RootViewWithSideManu(vc)
            }else{
               
            }
           // self.clearAllNotice()
        }
    }
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
          let size = image.size

              let widthRatio  = targetSize.width  / size.width
              let heightRatio = targetSize.height / size.height

              // Figure out what our orientation is, and use that to form the rectangle
              var newSize: CGSize
              if(widthRatio > heightRatio) {
                  newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
              } else {
                  newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
              }

              // This is the rect that we've calculated out and this is what is actually used below
              let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)

              // Actually do the resizing to the rect using the ImageContext stuff
              UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
              image.draw(in: rect)
              let newImage = UIGraphicsGetImageFromCurrentImageContext()
              UIGraphicsEndImageContext()

              return newImage!
      }
}
