//
//  LoaderVC.swift
//  PassworkCoreFramework
//
//  Created by sanjay kholiya on 08/05/21.
//  Copyright © 2021 sanjay kholiya. All rights reserved.
//

import UIKit
class AppLoader{
    public static var loader:LoaderVC = LoaderVC()
}

class LoaderVC: UIViewController {
    @IBOutlet weak var myImageView: UIImageView!

     override func viewDidLoad() {
        super.viewDidLoad()
        let when = DispatchTime.now() + 0.2
        DispatchQueue.main.asyncAfter(deadline: when)
        {
            self.didStartLoading()
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.didStartLoading()
    }
    
    func didStartLoading(){
   
        UIView.animate(withDuration: 1, delay: 0, options: [UIView.AnimationOptions.autoreverse,UIView.AnimationOptions.repeat,UIView.AnimationOptions.curveEaseInOut],
        animations: {
            self.myImageView.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        }, completion:nil)
       
   }
    
    func stopLoading() {
        self.myImageView.layer.removeAllAnimations()
        self.dismiss(animated: true, completion: nil)
    }
        
}
