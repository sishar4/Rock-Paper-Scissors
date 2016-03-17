//
//  RPSMainViewController.swift
//  Rock Paper Scissors
//
//  Created by Sahil Ishar on 3/16/16.
//  Copyright © 2016 Sahil Ishar. All rights reserved.
//

import UIKit

enum ViewControllerIdentifier: String {
    case NewGame = "NewGameViewController"
    case About = "AboutViewController"
}

class RPSMainViewController: UIViewController, MenuViewControllerDelegate {

    let storyBoard = UIStoryboard(name: "Main", bundle: nil)
    var menuViewController: MenuViewController? {
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
    @IBOutlet weak var edgePanRecognizer : UIScreenEdgePanGestureRecognizer!
    
    @IBAction func menuButtonClicked(sender: UIBarButtonItem) {
        if isMenuShowing {
            hideMenu()
        } else {
            showMenu()
        }
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
                //Dismiss menu on tap on screen outside menu
                let tapRecognizer = UITapGestureRecognizer.init(target: self, action: "hideMenu")
                self.coverView!.addGestureRecognizer(tapRecognizer)
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
    
    //MARK: Menu View Controller Delegate
    func didSelectMenuItemWithTitle(title: String) {
        if title == pageTitle {
            hideMenu()
            return
        }
        
        pageTitle = title
        
        //find ViewController with identifier for storyboard
        let titleNoSpaces = title.stringByReplacingOccurrencesOfString(" ", withString: "")
        let newVC = storyBoard.instantiateViewControllerWithIdentifier(titleNoSpaces + "ViewController")
        newVC.view.frame = CGRectMake(0.0, 0.0, currentView.bounds.size.width, currentView.bounds.size.height)
        selectedVC = newVC
        updateCurrentView()
    }
    func didSwipeLeft() {
        hideMenu()
    }
    
    func updateCurrentView() {
        currentVC!.view.removeFromSuperview()
        currentVC = selectedVC
        currentView.addSubview(currentVC!.view)
        self.title = pageTitle
        
        if isMenuShowing {
            hideMenu()
        }
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
        
        edgePanRecognizer.edges = UIRectEdge.Left
        loadInitialView()

        menuViewController = storyBoard.instantiateViewControllerWithIdentifier("MenuViewController") as? MenuViewController
        menuViewController?.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
