//
//  PresentStoryViewController.swift
//  StoryDemo
//
//  Created by MAC-30 on 12/10/21.
//


import UIKit
import AVKit
import AVFoundation
import SGSegmentedProgressBarLibrary
import CoreMedia
import SDWebImage

class PresentStoryViewController: UIViewController,UIGestureRecognizerDelegate{
    
    var imageDemoArray = ["Sports","black.jpg","black.jpg","black.jpg","black.jpg","Art"
    ]
//    var videoDemoArray : [AVPlayer] = [AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "small1", ofType: "mp4")!)),AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "small1", ofType: "mp4")!)),AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "small1", ofType: "mp4")!)),AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "small1", ofType: "mp4")!)),AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "small2", ofType: "mp4")!)),AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "small1", ofType: "mp4")!))]
    
    var LableDemopArray = ["","In this process, we are going to the call above method In this process, we are going to the call above method","","SwiftUI’s VideoPlayer view lets us playback movies from any URL, local or remote","",""]
    
    var videoUrl = [Bundle.main.url(forResource: "small", withExtension: "mp4"),Bundle.main.url(forResource: "small", withExtension: "mp4"),Bundle.main.url(forResource: "small", withExtension: "mp4"),Bundle.main.url(forResource: "small1", withExtension: "mp4"),Bundle.main.url(forResource: "small2", withExtension: "mp4"),Bundle.main.url(forResource: "small1", withExtension: "mp4")]
    var comeUserID = String()
    var ImageArray = [UIImage]()
    var player = AVPlayer()
    var avpController = AVPlayerViewController()
    var playerLayer: AVPlayerLayer?
    @IBOutlet weak var nextBtn: UIButton!
    var userName = String()
    @IBOutlet weak var image_view: UIImageView!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var name_lbl: UILabel!
    @IBOutlet weak var textLbl: UILabel!
    @IBOutlet weak var videoView: UIView!
    
    var getcount = Int()
    var segmentBar: SGSegmentedProgressBar?
    var isRed = false
    var progressBarTimer: Timer!
    var timeDuration = Int()
    var isRunning = false
    var snapsArray = NSMutableArray()
    var snaps_count:Int!
    var imageArrayn = NSMutableArray()
    var messageArray = NSMutableArray()
    var colourCodeArray = NSMutableArray()
    var backGroundColourCodeArray = NSMutableArray()
    override func viewDidLoad() {
        super.viewDidLoad()
        getcount = 1
        self.snaps_count = 1
        self.timeDuration = 0
//        self.videoDemoArray = [url1,url2,url3]
        image_view.layer.cornerRadius = 32
       // self.name_lbl.text = userName
        if self.comeUserID == "" {
            let user_id = UserDefaults.standard.value(forKey: "user_id") as? String ?? ""
            getStoryAPI(userId: user_id)
        }else{
            getStoryAPI(userId: comeUserID)
        }
        
        
        self.textLbl.isHidden = true
 
        self.image_view.layer.cornerRadius  = self.image_view.frame.width/2
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapped))
        self.view.addGestureRecognizer(tapGestureRecognizer)
            
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPressed))
        self.view.addGestureRecognizer(longPressRecognizer)
        
    }
    
//    func hexStringToUIColor (hex:String) -> UIColor {
//        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
//
//        if (cString.hasPrefix("#")) {
//            cString.remove(at: cString.startIndex)
//        }
//
//        if ((cString.count) != 6) {
//            return UIColor.gray
//        }
//
//        var rgbValue:UInt64 = 0
//        Scanner(string: cString).scanHexInt64(&rgbValue)
//
//        return UIColor(
//            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
//            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
//            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
//            alpha: CGFloat(1.0)
//        )
//    }
    
    func getStoryAPI(userId: String) {
//        self.getcount = 0
        

        let dict = NSMutableDictionary()
        dict.setValue(userId, forKey: "user_id")
        dict.setValue(Config().api_key, forKey: "api_key")

        let methodName = "get_stories"

        DataManager.getAPIResponse(dict, methodName: methodName, methodType: "POST"){(responseData,error)-> Void in

            let status = DataManager.getVal(responseData?["status"]) as? String ?? ""
           // let message = DataManager.getVal(responseData?["message"]) as? String ?? ""

            if status == "1"{
                let user = DataManager.getVal(responseData?["data"]) as! NSDictionary
                let userdetail = user.value(forKey: "user") as! NSDictionary
                let image = userdetail.value(forKey: "profile_image") as? String ?? ""
                
                let urlStr = Config().baseImageUrl + image
                self.image_view.sd_setImage(with: URL(string: urlStr), completed: nil)
              //  Config().setimage(name: "https://tribe.devtechnosys.tech/storage/app/public/" + image! , image: self.image_view)
                self.name_lbl.text  = userdetail.value(forKey: "name") as? String
                self.snaps_count = user.value(forKey: "snaps_count") as? Int
                self.snapsArray = user.value(forKey: "snaps") as! NSMutableArray
                if self.snapsArray.count == 0 {
                    self.view.makeToast("Story not Found")
                    DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute: {
                        self.dismiss(animated: true, completion: nil)
                    })
                }else{
                    for i in 0..<self.snapsArray.count {
                        var dict = NSDictionary()
                        dict = self.snapsArray.object(at: i) as! NSDictionary
                        let image = dict.value(forKey: "images") as? String ?? ""
                        let message = dict.value(forKey: "message") as? String
                        let color_code = dict.value(forKey: "color_code") as? String
                        let bgcolor_code = dict.value(forKey: "background_color_code") as? String
                        self.backGroundColourCodeArray.add(bgcolor_code ?? "#000000")
                        self.colourCodeArray.add(color_code ?? "#000000")
                        self.imageArrayn.add(Config().baseImageUrl + image)
                        self.messageArray.add(message ?? "")
                        let newimage =  "https://tribe.devtechnosys.tech/storage/app/public/" + image
                        let imageurl = URL.init(string: newimage)
                        if let data = try? Data(contentsOf: imageurl!)
                        {
                            let image: UIImage = UIImage(data: data)!
                            self.ImageArray.append(image)
                        }
                    }
                    let rect = CGRect(x: 5, y: 5, width: self.view.frame.size.width-10, height: 2)
                    self.segmentBar = SGSegmentedProgressBar(frame: rect, delegate: self, dataSource: self)
                    self.view.addSubview(self.segmentBar!)
                    self.segmentBar?.start()
                    self.userImageView.sd_setImage(with: URL(string: self.imageArrayn[0] as! String), completed: nil)
                    let image1 = self.imageArrayn[0]
                    if (image1 as AnyObject).contains("black.jpg") {
                        self.textLbl.isHidden = false
                        let message = self.messageArray[0] as? String
                        let colorcode = self.colourCodeArray[0] as? String
                        let bgColorCode = self.backGroundColourCodeArray[0] as? String ?? ""
                        self.textLbl.backgroundColor = self.hexStringToUIColor(hex: bgColorCode)
                        self.textLbl.text = message
                        self.textLbl.textColor = self.hexStringToUIColor(hex: colorcode!)
                    }else{
                        self.textLbl.text = ""
                        self.textLbl.isHidden = true
                    }
                }
                
              
            }else{
                self.dismiss(animated: true, completion: nil)
            }


        }
    }
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    @objc func tapped(sender: UITapGestureRecognizer){
        print("tapped")
    }
    @objc func longPressed(sender: UILongPressGestureRecognizer)
    {
        print("longPress")
        if sender.state == .ended {
            self.segmentBar?.resume()
        }else{
//            sender.minimumPressDuration = 0.01
            self.segmentBar?.pause()
        }
        
    }
    @IBAction func disMisBtnAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func beforeBtnAction(_ sender: Any) {
        self.segmentBar?.previousSegment()
//        userImageView.image = UIImage(named: imageDemoArray[self.segmentBar?.currentIndex ?? 0])
//        let image = imageArrayn[self.segmentBar?.currentIndex ?? 0]
//        if (image as AnyObject).contains("black.jpg") {
//            self.textLbl.isHidden = false
//            let message = messageArray[self.segmentBar?.currentIndex ?? 0] as? String
//            self.textLbl.text = message
//            let colorcode = self.colourCodeArray[self.segmentBar?.currentIndex ?? 0] as? String
//            self.textLbl.textColor = self.hexStringToUIColor(hex: colorcode!)
//        }else{
//            self.textLbl.text = ""
//            self.textLbl.isHidden = true
//        }

        self.playerLayer?.player = nil
        self.playerLayer?.removeFromSuperlayer()
    
        self.videoView.isHidden = true
        self.userImageView.sd_setImage(with: URL(string: imageArrayn[self.segmentBar?.currentIndex ?? 0] as! String), completed: nil)
        let image = imageArrayn[self.segmentBar?.currentIndex ?? 0]
        if (image as AnyObject).contains("black.jpg") {
            self.timeDuration = 0
            self.videoView.isHidden = true
            self.textLbl.isHidden = false
            let message = messageArray[self.segmentBar?.currentIndex ?? 0]
                let colorcode = self.colourCodeArray[self.segmentBar?.currentIndex ?? 0 + 1] as? String
                self.textLbl.textColor = self.hexStringToUIColor(hex: colorcode!)
            self.textLbl.text = message as! String
            let bgColorCode = self.backGroundColourCodeArray[0] as? String ?? ""
            self.textLbl.backgroundColor = self.hexStringToUIColor(hex: bgColorCode)
        }
        
//        else if (image as AnyObject).contains("videomp4") {
//            self.videoView.isHidden = false
//            self.textLbl.isHidden = true
//            let player = self.videoDemoArray[self.segmentBar?.currentIndex ?? 0]
//            if let url = self.videoUrl[self.segmentBar?.currentIndex ?? 0] {
//                    let asset = AVAsset(url: url)
//                    let duration = asset.duration
//                self.timeDuration = Int(CMTimeGetSeconds(duration))
//                    print(self.timeDuration)
//                }
//            playerLayer = AVPlayerLayer(player: player)
//            playerLayer!.frame = self.videoView.bounds
//            playerLayer!.videoGravity = .resizeAspect
//            self.videoView.layer.addSublayer(playerLayer!)
//            player.seek(to: .zero)
//            player.play()
//
//        }
        
        else{
            self.timeDuration = 0
            self.textLbl.text = ""
            self.textLbl.isHidden = true
        }
    }
    @IBAction func nextBtnAction(_ sender: Any) {
        self.segmentBar?.nextSegment()
//        userImageView.image = UIImage(named: imageDemoArray[self.segmentBar?.currentIndex ?? 0])
//        let image = imageArrayn[self.segmentBar?.currentIndex ?? 0]
//        if (image as AnyObject).contains("black.jpg") {
//            self.textLbl.isHidden = false
//            let message = messageArray[self.segmentBar?.currentIndex ?? 0] as? String
//            let colorcode = self.colourCodeArray[self.segmentBar?.currentIndex ?? 0] as? String
//            self.textLbl.textColor = self.hexStringToUIColor(hex: colorcode!)
//            self.textLbl.text = message
//        }else{
//            self.textLbl.text = ""
//            self.textLbl.isHidden = true
//        }
        self.playerLayer?.player = nil
        self.playerLayer?.removeFromSuperlayer()
        self.videoView.isHidden = true
        segmentBar?.pause()
        self.userImageView.sd_setImage(with: URL(string: imageArrayn[self.segmentBar?.currentIndex ?? 0] as! String), completed: nil)
        segmentBar?.resume()
        let image = imageArrayn[self.segmentBar?.currentIndex ?? 0]
        if (image as AnyObject).contains("black.jpg") {
            self.timeDuration = 0
            self.videoView.isHidden = true
            self.textLbl.isHidden = false
            let message = messageArray[self.segmentBar?.currentIndex ?? 0]
            let colorcode = self.colourCodeArray[self.segmentBar?.currentIndex ?? 0 + 1] as? String
                self.textLbl.textColor = self.hexStringToUIColor(hex: colorcode!)
            self.textLbl.text = message as! String
            let bgColorCode = self.backGroundColourCodeArray[0] as? String ?? ""
            self.textLbl.backgroundColor = self.hexStringToUIColor(hex: bgColorCode)
        }
//        else if (image as AnyObject).contains("videomp4") {
//            self.videoView.isHidden = false
//            self.textLbl.isHidden = true
//            let player = self.videoDemoArray[self.segmentBar?.currentIndex ?? 0]
//            if let url = self.videoUrl[self.segmentBar?.currentIndex ?? 0] {
//                    let asset = AVAsset(url: url)
//                    let duration = asset.duration
//                self.timeDuration = Int(CMTimeGetSeconds(duration))
//                    print(self.timeDuration)
//                }
//            playerLayer = AVPlayerLayer(player: player)
//            playerLayer!.frame = self.videoView.bounds
//            playerLayer!.videoGravity = .resizeAspect
//            self.videoView.layer.addSublayer(playerLayer!)
//
//            player.seek(to: .zero)
//            player.play()
//        }
        else{
            self.timeDuration = 0
            self.textLbl.text = ""
            self.textLbl.isHidden = true
        }
    }
}

extension PresentStoryViewController: SGSegmentedProgressBarDelegate,SGSegmentedProgressBarDataSource{
    func segmentedProgressBarFinished(finishedIndex: Int, isLastIndex: Bool) {
        print("finish Index")
        if isLastIndex == true{
            self.timeDuration = 0
//            userImageView.image = UIImage(named: imageDemoArray[finishedIndex])
        }else{
//            self.playerLayer?.player = nil
//            self.playerLayer?.removeFromSuperlayer()
//            self.videoView.isHidden = true
            self.userImageView.sd_setImage(with: URL(string: imageArrayn[finishedIndex + 1] as! String), completed: nil)
            let image = imageArrayn[finishedIndex + 1]
            if (image as AnyObject).contains("black.jpg") {
                self.timeDuration = 0
                self.videoView.isHidden = true
                self.textLbl.isHidden = false
                let message = messageArray[finishedIndex + 1]
                let colorcode = self.colourCodeArray[finishedIndex + 1] as? String
                self.textLbl.textColor = self.hexStringToUIColor(hex: colorcode!)
                self.textLbl.text = message as! String
                let bgColorCode = self.backGroundColourCodeArray[0] as? String ?? ""
                self.textLbl.backgroundColor = self.hexStringToUIColor(hex: bgColorCode)
            }
//            else if (image as AnyObject).contains("videomp4") {
//                self.videoView.isHidden = false
//                self.textLbl.isHidden = true
//                let player = self.videoDemoArray[finishedIndex + 1]
//                if let url = self.videoUrl[finishedIndex + 1] {
//                        let asset = AVAsset(url: url)
//                        let duration = asset.duration
//                    self.timeDuration = Int(CMTimeGetSeconds(duration))
//                        print(self.timeDuration)
//                    }
//                playerLayer = AVPlayerLayer(player: player)
//                playerLayer!.frame = self.videoView.bounds
//                playerLayer!.videoGravity = .resizeAspect
//                self.videoView.layer.addSublayer(playerLayer!)
//                player.seek(to: .zero)
//                player.play()
//
//            }
            else{
                self.timeDuration = 0
                self.textLbl.text = ""
                self.textLbl.isHidden = true
            }
        }
        if isLastIndex == true {
            self.dismiss(animated: true, completion: nil)
        }
    }
    var numberOfSegments: Int {
        return self.snaps_count
    }
    var segmentDuration: TimeInterval {
        if self.timeDuration != 0 {
            return TimeInterval(self.timeDuration)
        }else{
            return 3
        }
    }
    var paddingBetweenSegments: CGFloat {
        return 3
    }
    var trackColor: UIColor {
        return UIColor.darkGray
    }
    var progressColor: UIColor {
        return UIColor.white
    }
    var roundCornerType: SGCornerType {
        return .none
    }
}


