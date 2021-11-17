//
//  ViewController.swift
//  Soul Tribe
//
//  Created by Ashish Soni on 31/05/21.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
    @IBOutlet weak var colIntro: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        colIntro.register(UINib(nibName: "SlideCell", bundle: nil), forCellWithReuseIdentifier: "SlideCell")
        
        // Do any additional setup after loading the view.
    
    
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    //MARK:- Setup Slide Views
    func createIntroSlides() -> [[String : Any]] {
        var slide1 = [String : Any]()
        
        slide1["image"] = UIImage.init(named: "introbg")
        slide1["heading"] = "Welcome to the Tribe!"
        slide1["content"] = "Soul Tribe! is the first social and dating platform which connects spiritually conscious souls from all over the world on one high vibrational app."
        // slide1["pagecount"] = UIImage.init(named: "dot1")
        slide1["buttonBottom"] = "Skip"
       // slide1["buttonTop"] = "heart intro"
        
        var slide2 = [String : Any]()
        slide2["image"] = UIImage.init(named: "intro002")
        //slide2["heading"] = "Attract Your Soul Love, Tribe, or Both!"
       // slide2["content"] = "Whether you are choosing to connect with your Soul Love or create deep lasting friendships, attract all your heart desires!"
       // slide2["pagecount"] = UIImage.init(named: "dot2")
        slide2["buttonBottom"] = "Skip"
      //  slide2["buttonTop"] = "YStar"
        
        var slide3 = [String : Any]()
        slide3["image"] = UIImage.init(named: "intro003")
       // slide3["heading"] = "It is a long established fact that a reader"
       // slide3["content"] = "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form."
        //slide3["pagecount"] = UIImage.init(named: "dot4")
        slide3["buttonBottom"] = "Skip"
        //slide3["buttonTop"] = "Star"
        
        var slide4 = [String : Any]()
        slide4["image"] = UIImage.init(named: "intro004")
       // slide3["heading"] = "It is a long established fact that a reader"
       // slide3["content"] = "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form."
       // slide4["pagecount"] = UIImage.init(named: "dot5")
        slide4["buttonBottom"] = "Skip"
      //  slide4["buttonTop"] = "Star"
        
        var slide5 = [String : Any]()
        slide5["image"] = UIImage.init(named: "intro005")
       // slide3["heading"] = "It is a long established fact that a reader"
       // slide3["content"] = "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form."
       // slide5["pagecount"] = UIImage.init(named: "dot6")
        slide5["buttonBottom"] = "Skip"
       // slide5["buttonTop"] = "Star"
        
        var slide6 = [String : Any]()
        slide6["image"] = UIImage.init(named: "intro06-1")
       // slide3["heading"] = "It is a long established fact that a reader"
       // slide3["content"] = "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form."
       // slide5["pagecount"] = UIImage.init(named: "dot6")
        slide6["buttonBottom"] = "Finish"
       // slide5["buttonTop"] = "Star"
    
        
        return [slide1, slide2, slide3, slide4, slide5, slide6 ]
    }
    //MARK:- Collection View Methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return createIntroSlides().count
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SlideCell", for: indexPath) as! SlideCell
        
        let dicSlide = createIntroSlides()[indexPath.item]
        
        if indexPath.row == 0{
            
            cell.lblContent.isHidden = false
            cell.lblHeading.isHidden = false

        cell.introImg.image = dicSlide["image"] as? UIImage
        cell.lblHeading.text = dicSlide["heading"] as? String
        cell.lblContent.text = dicSlide["content"] as? String
            cell.skipBtn.setTitle(dicSlide["buttonBottom"]as? String, for: .normal)
            cell.skipBtn.addTarget(self, action: #selector(actionBtnSkip(_:)), for: .touchUpInside)
        }
        else{
            cell.lblHeading.isHidden = true
            cell.lblContent.isHidden = true
            cell.introImg.image = dicSlide["image"] as? UIImage
            cell.skipBtn.setTitle(dicSlide["buttonBottom"]as? String, for: .normal)
            cell.skipBtn.addTarget(self, action: #selector(actionBtnSkip(_:)), for: .touchUpInside)
        }
      //  cell.lblHeading.text = dicSlide["heading"] as? String
       // cell.lblContent.text = dicSlide["content"] as? String
        //cell.imgSelectedPage.image = dicSlide["pagecount"] as? UIImage
      //  cell.HeartBtn.setImage(UIImage(named: dicSlide["buttonTop"] as? String ?? ""), for: .normal)
       
      
        return cell
    }
    
    @objc func actionBtnSkip(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(identifier: "LoginViewController") as! LoginViewController
        navigationController?.pushViewController(vc, animated: true)
    }

}

