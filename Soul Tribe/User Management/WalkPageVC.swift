//
//  WalkPageVC.swift
//  Soul Tribe
//
//  Created by MAC-28 on 31/07/21.
//

import UIKit

class WalkPageVC: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate,UIViewControllerTransitioningDelegate {
    
    var index = 0
    var identifiers: NSArray = ["FirstIntroVC", "SecondIntroVC", "ThirdIntroVC", "ForthIntroVC", "FifthIntroVC", "SixIntroVC"]
    override func viewDidLoad() {
        
        self.dataSource = self
        self.delegate = self
        let startingViewController = self.viewControllerAtIndex(index: self.index)
        let viewControllers: NSArray = [startingViewController ?? []]
        self.setViewControllers(viewControllers as? [UIViewController], direction: .forward, animated: true, completion: nil)
       
        
    }
        override var prefersStatusBarHidden: Bool {
            return true
        
        }
    
    
    func viewControllerAtIndex(index: Int) -> UIViewController! {
        
        //first view controller = firstViewControllers navigation controller
        if index == 0 {
            
            return self.storyboard?.instantiateViewController(withIdentifier: "FirstIntroVC") as? FirstIntroVC
        
        }
        
        //second view controller = secondViewController's navigation controller
        if index == 1 {
            
            return self.storyboard?.instantiateViewController(withIdentifier: "SecondIntroVC") as? SecondIntroVC
            
        }
        if index == 2 {
            
            return self.storyboard?.instantiateViewController(withIdentifier: "ThirdIntroVC") as? ThirdIntroVC
        }
        if index == 3 {
            
            return self.storyboard?.instantiateViewController(withIdentifier: "ForthIntroVC") as? ForthIntroVC
        }
        if index == 4 {
            
            return self.storyboard?.instantiateViewController(withIdentifier: "FifthIntroVC") as? FifthIntroVC
        }
        if index == 5 {
         
            return self.storyboard?.instantiateViewController(withIdentifier: "SixIntroVC") as? SixIntroVC
        }
        
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        let identifier = viewController.restorationIdentifier
        let index = self.identifiers.index(of: identifier ?? "")
        
        //if the index is the end of the array, return nil since we dont want a view controller after the last one
        if index == 0{
            
            return nil
        }
        
        //increment the index to get the viewController after the current index
        self.index = self.index - 1
        return self.viewControllerAtIndex(index: self.index)
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        let identifier = viewController.restorationIdentifier
        let index = self.identifiers.index(of: identifier ?? "")
        
        //if the index is 0, return nil since we dont want a view controller before the first one
        if index == identifiers.count - 1 {
            
            return nil
        }
        
        //decrement the index to get the viewController before the current one
        self.index = self.index + 1
        return self.viewControllerAtIndex(index: self.index)
        
    }
    
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController!) -> Int {
        return self.identifiers.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController!) -> Int {
        return 0
    }
    
    //MARK:- Button Action Methods

    @objc func actionBtnSkip(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(identifier: "LoginViewController") as! LoginViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
