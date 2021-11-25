//
//  TrimerViewController.swift
//  TuVozNow
//
//  Created by mac-14 on 30/04/20.
//  Copyright © 2020 zokoo. All rights reserved.
//

import UIKit
import PryntTrimmerView
import AVFoundation
import Photos
import AVKit

class TrimerViewController: UIViewController {
    //MARK: Variables
    var videoDetails: UploadVideoData?
    var player: AVPlayer?
    var playbackTimeCheckerTimer: Timer?
    var trimmerPositionChangedTimer: Timer?
    var Asset : AVAsset?
    var videoURL: URL?
    var cropedVideoData = Data()
    var asset: PHAsset?
    //MARK:- Outlets
    @IBOutlet weak var trimmerView: TrimmerView!
    @IBOutlet weak var VideoView: UIView!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var timeLabelLeadingConstraint: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        continueButton.layer.cornerRadius = 6
        
        
        if let newAsset = self.asset{
            self.getURL(asset: newAsset) { url in
                self.videoURL = url
                self.videoDetails?.videoURL = url
            }
        }
        
    }
    @IBAction func backBtnAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        NotificationCenter.default.post(name: NSNotification.Name("CloseView"), object: nil)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
      //  setUpNavBarBackButton(viewController: self, color: APPColor.APP_THEME ?? .blue)
        continueButton.setTitle("Continue", for: .normal)
      //  continueButton.titleLabel?.setCostomFontSize(size: 18)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.tabBarController?.tabBar.isHidden = true
        timeLabel.layer.cornerRadius = 5
        timeLabel.layer.masksToBounds = true
        HideViews()
      //  ShowLoaderOnView()
        DispatchQueue.main.asyncAfter(deadline: .now()+1.0) {
            guard let videoURL = self.videoURL else{
              //  HideLoaderOnView()
             //   displayAlertWithMessage("You are not allow to upload this type of video.")
                return
            }
            print("Video URL: \(videoURL)")
            self.Asset = AVAsset(url: videoURL)
            self.trimmerView.maxDuration = self.Asset?.duration.seconds ?? 15
            self.trimmerView.asset = self.Asset
            self.trimmerView.delegate = self
            self.addVideoPlayer(with: self.Asset!, playerView: self.VideoView)
            self.ShowViews()
          //  HideLoaderOnView()
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.tabBarController?.tabBar.isHidden = false
        }
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil)
    }
    //MARK: Functions
    
    func HideViews()  {
        VideoView.isHidden = true
        trimmerView.isHidden = true
        timeLabel.isHidden = true
        continueButton.isHidden = true
    }
    
    func ShowViews()  {
        VideoView.isHidden = false
        trimmerView.isHidden = false
        timeLabel.isHidden = false
        continueButton.isHidden = false
    }
    func startPlaybackTimeChecker() {
        stopPlaybackTimeChecker()
        playbackTimeCheckerTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self,
                                                        selector:
            #selector(self.onPlaybackTimeChecker), userInfo: nil, repeats: true)
    }
    
    func stopPlaybackTimeChecker() {
        playbackTimeCheckerTimer?.invalidate()
        playbackTimeCheckerTimer = nil
    }
    
    func ChangeTimeLablePostion(x: CGFloat) {
        let padding: CGFloat = 10
        let lblWidth = timeLabel.frame.size.width
        let minX = VideoView.frame.origin.x + lblWidth/2
        let maxX = (VideoView.frame.width) - lblWidth/2
        let newX = x + padding
        if newX < minX{
            self.timeLabelLeadingConstraint.constant = VideoView.frame.origin.x - padding
        }else if newX > maxX{
            self.timeLabelLeadingConstraint.constant = maxX - lblWidth/2
            
        }else{
            self.timeLabelLeadingConstraint.constant = newX - lblWidth/2 - padding
        }
    }
    func getURL(asset: PHAsset, completion: @escaping (URL) -> () ) {
        PHImageManager.default().requestAVAsset(forVideo: asset, options: nil) { (avAsset, b, c) in
            if let urlAsset = avAsset as? AVURLAsset {
                completion(urlAsset.url)
            }
        }
    }
    //mark:- button action
    
    @IBAction func continueButtonAction(_ sender: Any) {
        let startTime = Float(trimmerView.startTime?.seconds ?? 0.0)
        let endTime = Float(trimmerView.endTime?.seconds ?? 0.0)
        let myurl =  urlOfCurrentlyPlayingInPlayer(player: player!)
        let url = cropVideo(sourceURL1: myurl!, statTime: startTime, endTime: endTime)
        do {
            cropedVideoData = try Data(contentsOf: url)
        } catch  {
            print("Error to convert in data")
        }
        print("New Video Data: \(cropedVideoData)")
    }
    private func addVideoPlayer(with asset: AVAsset, playerView: UIView) {
        let playerItem = AVPlayerItem(asset: asset)
        player = AVPlayer(playerItem: playerItem)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.itemDidFinishPlaying(_:)),
                                               name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: playerItem)
        
        let layer: AVPlayerLayer = AVPlayerLayer(player: player)
        layer.backgroundColor = UIColor.white.cgColor
        layer.frame = CGRect(x: 0, y: 0, width: playerView.frame.width, height: playerView.frame.height)
        layer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        playerView.layer.sublayers?.forEach({$0.removeFromSuperlayer()})
        playerView.layer.addSublayer(layer)
    }
    @objc func itemDidFinishPlaying(_ notification: Notification) {
        if let startTime = trimmerView.startTime {
            player?.seek(to: startTime)
        }
    }
    
    @objc func onPlaybackTimeChecker() {
        
        guard let startTime = trimmerView.startTime, let endTime = trimmerView.endTime, let player = player else {
            return
        }
        
        let playBackTime = player.currentTime()
        trimmerView.seek(to: playBackTime)
        
        if playBackTime >= endTime {
            player.seek(to: startTime, toleranceBefore: CMTime.zero, toleranceAfter: CMTime.zero)
            trimmerView.seek(to: startTime)
        }
    }
    ///It will return Thumbnail UIImage
    func getThumbnailImageFromVideoUrl(url: URL, completion: @escaping ((_ image: UIImage?)->Void)) {
        DispatchQueue.global().async { //1
            let asset = AVAsset(url: url) //2
            let avAssetImageGenerator = AVAssetImageGenerator(asset: asset) //3
            avAssetImageGenerator.appliesPreferredTrackTransform = true //4
            let thumnailTime = CMTimeMake(value: 2, timescale: 1) //5
            do {
                let cgThumbImage = try avAssetImageGenerator.copyCGImage(at: thumnailTime, actualTime: nil) //6
                let thumbImage = UIImage(cgImage: cgThumbImage) //7
                DispatchQueue.main.async { //8
                    completion(thumbImage) //9
                }
            } catch {
                print(error.localizedDescription) //10
                DispatchQueue.main.async {
                    completion(nil) //11
                }
            }
        }
    }
    
    func getThumbnailImageData(url: URL) -> Data {
        var imageData = Data()
        getThumbnailImageFromVideoUrl(url: url) { image in
            imageData = image?.pngData() ?? Data()
        }
        return imageData
    }
    func urlOfCurrentlyPlayingInPlayer(player : AVPlayer) -> URL? {
        return ((player.currentItem?.asset) as? AVURLAsset)?.url
    }
    func cropVideo(sourceURL1: URL, statTime:Float, endTime:Float) -> URL
    {
       // ShowLoaderWithMessage(message: "Trimming...")
        let fileManager = FileManager.default
        let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        
        let asset = AVAsset(url: sourceURL1)
        let _ = Float(asset.duration.value) / Float(asset.duration.timescale)
        var outputURL = documentDirectory.appendingPathComponent("output")
        do {
            try fileManager.createDirectory(at: outputURL, withIntermediateDirectories: true, attributes: nil)
            outputURL = outputURL.appendingPathComponent("\(sourceURL1.lastPathComponent)02.MP4")
        }catch let error {
            print(error)
        }
        
        //Remove existing file
        try? fileManager.removeItem(at: outputURL)
        
        guard let exportSession = AVAssetExportSession(asset: asset, presetName: AVAssetExportPresetHighestQuality) else { return URL(string: "")!}
        exportSession.outputURL = outputURL
        exportSession.outputFileType = .mp4
        
        let timeRange = CMTimeRange(start: CMTime(seconds: Double(statTime), preferredTimescale: 1000),
                                    end: CMTime(seconds: Double(endTime), preferredTimescale: 1000))
        
        exportSession.timeRange = timeRange
        exportSession.exportAsynchronously {
            switch exportSession.status {
            case .completed:
                do {
                    self.cropedVideoData = try Data(contentsOf: outputURL)
                    DispatchQueue.main.async {
                        
                    }
                } catch  {
                  
                }
            case .failed:
               
                print("failed \(exportSession.error.debugDescription)")
            case .cancelled:
               
                print("cancelled \(exportSession.error.debugDescription)")
            default:
               
                break
            }
        }
        return outputURL
    }
    
}
extension TrimerViewController:TrimmerViewDelegate {
    func didChangePositionBar(_ playerTime: CMTime) {
        timeLabel.text = playerTime.positionalTime
        player?.seek(to: playerTime, toleranceBefore: CMTime.zero, toleranceAfter: CMTime.zero)
        player?.play()
        startPlaybackTimeChecker()
        let second = playerTime.seconds
        let maxSeconds = Asset?.duration.seconds ?? 0.0
        let maxX = Double(trimmerView.frame.width)
        let newX = (maxX*second)/maxSeconds
        ChangeTimeLablePostion(x: CGFloat(newX))
    }
    
    
    func positionBarStoppedMoving(_ playerTime: CMTime) {
        stopPlaybackTimeChecker()
        player?.pause()
        player?.seek(to: playerTime, toleranceBefore: CMTime.zero, toleranceAfter: CMTime.zero)
        let _ = (trimmerView.endTime! - trimmerView.startTime!).seconds
    }
    
}
