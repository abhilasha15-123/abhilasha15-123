//
//  myView.swift
//  Koloda_Example
//
//  Created by mac-14 on 15/03/21.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

//import UIKit
//import AVKit
//import AVFoundation
//import PopBounceButton
//
//class myView: UIView,UIScrollViewDelegate {
//
//
//    @IBOutlet var contentView: UIView!
//    @IBOutlet weak var img_1: UIImageView!
//    @IBOutlet weak var Verifiedimg: UIImageView!
//    @IBOutlet weak var userName: UILabel!
//    @IBOutlet weak var ageLbl: UILabel!
//    @IBOutlet weak var cityLbl: UILabel!
//    @IBOutlet weak var userBioLbl: UILabel!
//
//    @IBOutlet weak var quesAnsCollectionView: UICollectionView!
//    @IBOutlet weak var imageCollectionView: UICollectionView!
//    @IBOutlet weak var habitsCollectionView: UICollectionView!
//    @IBOutlet weak var videoCollectionView: UICollectionView!
//    @IBOutlet weak var superLikeBtn: PopBounceButton!
//    @IBOutlet weak var likeBtn: PopBounceButton!
//    @IBOutlet weak var disLikeBtn: PopBounceButton!
//    @IBOutlet weak var superLikeBtnTop: PopBounceButton!
//    @IBOutlet weak var blockBtn: ResponsiveButton!
//
//    @IBOutlet weak var goldIcon: PopBounceButton!
//    @IBOutlet weak var imagePageControl: UIPageControl!
//    @IBOutlet weak var videoPageControl: UIPageControl!
//
//    @IBOutlet weak var mainView: UIView!
//    @IBOutlet weak var scrollView: UIScrollView!
//
//    @IBOutlet weak var quesTopConstrants: NSLayoutConstraint!
//    @IBOutlet weak var quesHeightConstrants: NSLayoutConstraint!
//
//
//
//    @IBOutlet weak var imageCollectionTopCons: NSLayoutConstraint!
//    @IBOutlet weak var imagesCollectionHeightCons: NSLayoutConstraint!
//    @IBOutlet weak var habitsCollectionTopCons: NSLayoutConstraint!
//    @IBOutlet weak var habitsCollectionHeightCons: NSLayoutConstraint!
//    @IBOutlet weak var videoCollectionTopCons: NSLayoutConstraint!
//    @IBOutlet weak var videoCollectionHeightCons: NSLayoutConstraint!
//
//    var picturesArray = [String]()
//    var videosArray = [String]()
//    var titlesArray = [[String: Any]]()
//    var memberStatus = String()
//    var quesAnsArray = [[String:Any]]()
//
//    let screenWidth = UIScreen.main.bounds.size.width
//    let screenHeight = UIScreen.main.bounds.size.height
//
//    override init(frame: CGRect) {
//        super.init(frame : frame)
//        commonInit()
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder : aDecoder)
//        commonInit()
//    }
//    private func commonInit() {
//
//        Bundle.main.loadNibNamed("myView", owner: self, options: nil)
//        addSubview(contentView)
//        contentView.frame = self.bounds
//        contentView.layer.cornerRadius = 8
//        contentView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
//
//        self.img_1.layer.cornerRadius = 8
//        self.quesAnsCollectionView.layer.cornerRadius = 8
//        self.imageCollectionView.layer.cornerRadius = 8
//        self.habitsCollectionView.layer.cornerRadius = 8
//        self.videoCollectionView.layer.cornerRadius = 8
//        self.ageLbl.layer.cornerRadius = 8
//        self.ageLbl.layer.masksToBounds = true
//        self.cityLbl.layer.cornerRadius = 8
//        self.cityLbl.layer.masksToBounds = true
//
//        if self.memberStatus == "3"{
//            self.goldIcon.isHidden = false
//        }else{
//            self.goldIcon.isHidden = true
//        }
//
//        self.scrollView.delegate = self
//
//        let Questnib = UINib(nibName: "QuesAnsCollectionCell", bundle: nil)
//        self.quesAnsCollectionView.register(Questnib, forCellWithReuseIdentifier: "QuesAnsCollectionCell")
//        self.quesAnsCollectionView.delegate = self
//        self.quesAnsCollectionView.dataSource = self
//        self.quesAnsCollectionView.isPagingEnabled = true
//
//        let LayOut = UICollectionViewFlowLayout()
//        LayOut.itemSize = CGSize(width: 250, height: 350)
//        LayOut.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//        LayOut.minimumInteritemSpacing = 0
//        LayOut.minimumLineSpacing = 0
//        LayOut.scrollDirection = .horizontal
//
//        let Headernib = UINib(nibName: "HeaderCollectionCell", bundle: nil)
//        self.imageCollectionView.register(Headernib, forCellWithReuseIdentifier: "HeaderCollectionCell")
////        self.imageCollectionView.collectionViewLayout = LayOut
//        self.imageCollectionView.tag = 1
//        self.imageCollectionView.delegate = self
//        self.imageCollectionView.dataSource = self
//        self.imageCollectionView.isPagingEnabled = true
//
//        let VideoLayOut = UICollectionViewFlowLayout()
//        VideoLayOut.itemSize = CGSize(width: 250, height: 200)
//        VideoLayOut.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//        VideoLayOut.minimumInteritemSpacing = 0
//        VideoLayOut.minimumLineSpacing = 0
//        VideoLayOut.scrollDirection = .horizontal
//
//        let Videonib = UINib(nibName: "VideoCollectionCell", bundle: nil)
//        self.videoCollectionView.register(Videonib, forCellWithReuseIdentifier: "VideoCollectionCell")
////        self.videoCollectionView.collectionViewLayout = LayOut
//        self.videoCollectionView.tag = 2
//        self.videoCollectionView.delegate = self
//        self.videoCollectionView.dataSource = self
//        self.videoCollectionView.isPagingEnabled = true
//
//        let detail_layout = UICollectionViewFlowLayout()
//        detail_layout.itemSize = CGSize(width: self.screenWidth/2-30, height: 40)
//        detail_layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//        detail_layout.minimumInteritemSpacing = 0
//        detail_layout.minimumLineSpacing = 10
//        detail_layout.scrollDirection = .vertical
//
//        let Detailnib = UINib(nibName: "DetailCollectionCell", bundle: nil)
//        self.habitsCollectionView.register(Detailnib, forCellWithReuseIdentifier: "DetailCollectionCell")
////        self.habitsCollectionView.collectionViewLayout = detail_layout
//        self.habitsCollectionView.delegate = self
//        self.habitsCollectionView.dataSource = self
//
//    }
//
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        if ((scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height - 100) {
//            let animation = CATransition()
//            animation.type = .fade
//            animation.duration = 0.5
//            superLikeBtnTop.layer.add(animation, forKey: nil)
//
//            self.superLikeBtnTop.isHidden = true
//            self.superLikeBtn.isHidden = false
//        }else{
//            let animation = CATransition()
//            animation.type = .fade
//            animation.duration = 0.5
//            superLikeBtn.layer.add(animation, forKey: nil)
//
//            self.superLikeBtnTop.isHidden = false
//            self.superLikeBtn.isHidden = true
//        }
//    }
//
//}
//
//extension myView: UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,AVPlayerViewControllerDelegate{
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if collectionView == imageCollectionView{
//            print(self.picturesArray)
//            imagePageControl.numberOfPages = self.picturesArray.count
//            imagePageControl.isHidden = !(self.picturesArray.count > 1)
//            return picturesArray.count
//        }else if collectionView == videoCollectionView{
//            print(self.videosArray)
//            videoPageControl.numberOfPages = self.videosArray.count
//            videoPageControl.isHidden = !(self.videosArray.count > 1)
//            return videosArray.count
//        }else if collectionView == habitsCollectionView{
//            print(self.titlesArray)
//            return titlesArray.count
//        }else{
//            return quesAnsArray.count
//        }
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        if collectionView == imageCollectionView{
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeaderCollectionCell", for: indexPath) as! HeaderCollectionCell
//            cell.tag = indexPath.row
//            cell.clipsToBounds = true
//            Config().setimage(name: DataManager.getVal(self.picturesArray[indexPath.row]) as? String ?? "", image: cell.imgView)
//            cell.imgView.layer.cornerRadius = 8
//            return cell
//        }else if collectionView == videoCollectionView{
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoCollectionCell", for: indexPath) as! VideoCollectionCell
//            cell.tag = indexPath.row
//            cell.clipsToBounds = true
//            let url = DataManager.getVal(videosArray[indexPath.item]) as? String ?? ""
////            let videoURL = URL(string: url)!
//
////            cell.player = AVPlayer(url: videoURL)
//            Config().setimage(name: url, image: cell.imgView)
//            cell.avpController = AVPlayerViewController()
//            cell.avpController.player = cell.player
//            cell.avpController.view.frame.size.width = cell.imgView.frame.size.width
//            cell.avpController.view.frame.size.height = cell.imgView.frame.size.height
////            self.addChild(cell.avpController)
//            cell.imgView.layer.cornerRadius = 8
//            cell.imgView.addSubview(cell.avpController.view)
//            if(cell.player.timeControlStatus == AVPlayer.TimeControlStatus.playing) {
//                cell.player.pause()
//            }else if(cell.player.timeControlStatus == AVPlayer.TimeControlStatus.paused) {
//                cell.player.play()
//            }
//            NotificationCenter.default.addObserver(self, selector: #selector(self.audioPlayerDidFinishPlaying(_:successfully:)), name: .AVPlayerItemDidPlayToEndTime, object: nil)
//            cell.playButton.tag = indexPath.item
//            cell.playButton.addTarget(self, action: #selector(playvideo(_:)), for: .touchUpInside)
//            return cell
//        }else if collectionView == habitsCollectionView{
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailCollectionCell", for: indexPath) as! DetailCollectionCell
//            cell.layer.cornerRadius = 5
//            cell.clipsToBounds = true
//            cell.layer.borderWidth = 1
//            cell.layer.borderColor = UIColor.lightGray.cgColor
//
//            let dict = DataManager.getVal(self.titlesArray[indexPath.row]) as! [String: Any]
//            cell.titleLbl.text = DataManager.getVal(dict["key"]) as? String ?? ""
//            cell.imgView.image = UIImage(named: DataManager.getVal(dict["image"]) as? String ?? "")
//            if cell.titleLbl.text == ""{
//                cell.imgView.isHidden = true
//            }else{
//                cell.imgView.isHidden = false
//            }
//
//            return cell
//        }else{
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "QuesAnsCollectionCell", for: indexPath) as! QuesAnsCollectionCell
//            let dict = DataManager.getVal(quesAnsArray[indexPath.row]) as! [String: Any]
//            cell.questionLbl.text = "Q. " + (DataManager.getVal(dict["question"]) as? String ?? "")
//            cell.answerLbl.text = "A. " + (DataManager.getVal(dict["answer"]) as? String ?? "")
//            return cell
//        }
//    }
//
//    @objc func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
//        print("Video Ended")
//    }
//
//    @objc func playvideo(_ sender:UIButton) {
//
//        let url = DataManager.getVal(videosArray[sender.tag]) as? String ?? ""
//            let videoURL = URL(string: url)!
//
////            cell.player = AVPlayer(url: videoURL)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        if collectionView == self.imageCollectionView{
//            self.imagePageControl.currentPage = indexPath.item
//        }else if collectionView == self.videoCollectionView{
//            self.videoPageControl.currentPage = indexPath.item
//        }
//
//    }
//
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        if let collectionView = scrollView as? UICollectionView {
//            switch collectionView.tag {
//            case 1:
//                imagePageControl?.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
//            case 2:
//                videoPageControl?.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
//            default:
//                let whichCollectionViewScrolled = "unknown"
//                print(whichCollectionViewScrolled)
//            }
//        } else{
//            print("cant cast")
//        }
//
//    }
//
//    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
//        if let collectionView = scrollView as? UICollectionView {
//            switch collectionView.tag {
//            case 1:
//                imagePageControl?.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
//            case 2:
//                videoPageControl?.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
//            default:
//                let whichCollectionViewScrolled = "unknown"
//                print(whichCollectionViewScrolled)
//            }
//        }else{
//            print("cant cast")
//        }
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        if collectionView == self.habitsCollectionView{
//            return UIEdgeInsets(top: 10,left: 10,bottom: 10,right: 10)
//        }else{
//            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//        }
//    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        if collectionView == self.habitsCollectionView{
//            return 5
//        }else{
//            return 0
//        }
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        if collectionView == self.habitsCollectionView{
//            return 5
//        }else{
//            return 0
//        }
//    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        if collectionView == self.habitsCollectionView{
//            let dict = DataManager.getVal(self.titlesArray[indexPath.row]) as! [String: Any]
//            let text = DataManager.getVal(dict["key"]) as? String ?? ""
//            var cellWidth = CGFloat()
//            if text == "" {
//                cellWidth = 0
//            }else{
//                cellWidth = (text as AnyObject).size(withAttributes:[.font: UIFont.systemFont(ofSize:17.0)]).width + 50
//            }
//
//            return CGSize(width: cellWidth, height: 35)
//        }else if collectionView == self.imageCollectionView{
//            return CGSize(width: screenWidth-50, height: 350)
//        }else if collectionView == self.videoCollectionView{
//            return CGSize(width: screenWidth-50, height: 200)
//        }else{
//            return CGSize(width: screenWidth-50, height: 200)
//        }
//    }
//
//}
//extension UIView {
//    func dropShadow(scale: Bool = true) {
//        layer.masksToBounds = false
//        layer.shadowColor = UIColor.cyan.cgColor
//        layer.backgroundColor = UIColor.cyan.cgColor
//        layer.shadowOpacity = 1
//        layer.shadowOffset = .zero
//        layer.shadowRadius = 5
//        layer.shouldRasterize = true
//        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
//    }
//}
