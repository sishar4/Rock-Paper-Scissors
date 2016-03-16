//
//  RPSMainViewController.swift
//  Rock Paper Scissors
//
//  Created by Sahil Ishar on 3/16/16.
//  Copyright © 2016 Sahil Ishar. All rights reserved.
//

import UIKit

class RPSMainViewController: UIViewController {

    let storyBoard = UIStoryboard(name: "Main", bundle: nil)
    var menuViewController: UIViewController? {
        willSet{
            if menuViewController != nil {
                if menuViewController!.view != nil {
                    menuViewController!.view!.removeFromSuperview()
                }
                menuViewController!.removeFromParentViewController()
            }
        }
        
        didSet{
            self.menuViewController!.view.frame = CGRect(x: 0.0-self.view.frame.width+100.0, y: 0.0, width: self.view.frame.width - 100.0, height: self.view.frame.height)
            self.view!.addSubview(menuViewController!.view)
            self.view!.bringSubviewToFront(menuViewController!.view)
            self.addChildViewController(menuViewController!)
        }
    }
    
    var currentVC : UIViewController?
    var selectedVC : UIViewController?
    var pageTitle : String = "New Game"
    var isMenuShowing : Bool = false
    var coverView : UIView?
    
    @IBOutlet weak var currentView : UIView!
    @IBOutlet weak var menuButton : UIBarButtonItem!
    @IBOutlet weak var recognizer : UIScreenEdgePanGestureRecognizer!
    
    @IBAction func menuButtonClicked(sender: UIBarButtonItem) {
        if isMenuShowing {
            hideMenu()
        } else {
            showMenu()
        }
    }
    
    @IBAction func swipeLeft(sender: UISwipeGestureRecognizer) {
        hideMenu()
    }
    
    @IBAction func handlePan(recognizer: UIScreenEdgePanGestureRecognizer) {
//        let translation = recognizer.translationInView(self.view)
//        if let view = recognizer.view {
//            view.center = CGPoint(x:view.center.x + translation.x,
//                y:view.center.y + translation.y)
//        }
//        recognizer.setTranslation(CGPointZero, inView: self.view)
        showMenu()
    }
    
    func showMenu() {
        
        if coverView == nil {
            coverView = UIView.init(frame: CGRectMake(0.0, 0.0, self.view.frame.width, self.view.frame.height))
            coverView?.backgroundColor = UIColor.blackColor()
            coverView?.alpha = 0.0
        }
        view.addSubview(coverView!)
        UIView.animateWithDuration(0.3, animations: {
            self.menuViewController!.view.frame = CGRect(x: 0.0, y: 0.0, width: self.view.frame.width - 100.0, height: self.view.frame.height)
            self.coverView!.frame = CGRectMake(self.view.frame.width - 100.0, 0.0, 100.0, self.view.frame.height)
            self.coverView!.alpha = 0.5
            }, completion: { (Bool) -> Void in
                self.isMenuShowing = true
        })
    }
    
    func hideMenu() {
        if isMenuShowing {
            UIView.animateWithDuration(0.3, animations: {
                self.menuViewController!.view.frame = CGRect(x: 0.0-self.view.frame.width+100.0, y: 0.0, width: self.view.frame.width - 100.0, height: self.view.frame.height)
                self.coverView!.frame = self.view.frame
                self.coverView!.alpha = 0.0
                }, completion: { (Bool) -> Void in
                    self.coverView!.removeFromSuperview()
                    self.isMenuShowing = false
            })
        }
    }
    
    func updateCurrentView() {
        currentVC!.view.removeFromSuperview()
        currentVC = selectedVC
        currentView.addSubview(currentVC!.view)
        self.title = pageTitle
    }
    
    func loadInitialView() {
        let newGameVC = storyBoard.instantiateViewControllerWithIdentifier("NewGameViewController")
        newGameVC.view.frame = CGRectMake(0.0, 0.0, currentView.bounds.size.width, currentView.bounds.size.height)
        selectedVC = newGameVC
        currentVC = selectedVC
        currentView.addSubview(currentVC!.view)
        self.title = pageTitle
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recognizer.edges = UIRectEdge.Left
        loadInitialView()
        
        let menuVC: MenuViewController = storyBoard.instantiateViewControllerWithIdentifier("MenuViewController")as! MenuViewController
        menuViewController = menuVC
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
