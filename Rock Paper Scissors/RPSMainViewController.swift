//
//  RPSMainViewController.swift
//  Rock Paper Scissors
//
//  Created by Sahil Ishar on 3/16/16.
//  Copyright © 2016 Sahil Ishar. All rights reserved.
//

import UIKit

class RPSMainViewController: UIViewController, MenuViewControllerDelegate {

    let storyBoard = UIStoryboard(name: "Main", bundle: nil)
    let menuTop : CGFloat = UIScreen.mainScreen().bounds.origin.y
    
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
            self.menuViewController!.view.frame = CGRect(x: 0.0-self.view.frame.width+100.0, y: menuTop, width: self.view.frame.width - 100.0, height: self.view.frame.height)
            let win:UIWindow = UIApplication.sharedApplication().delegate!.window!!
            win.addSubview(menuViewController!.view)
            win.bringSubviewToFront(menuViewController!.view)
//            self.addChildViewController(menuViewController!)
        }
    }
    
    var currentVC : UIViewController?
    var selectedVC : UIViewController?
    var pageTitle : String = "New Game"
    var isMenuShowing : Bool = false
    var overlayView : UIView?
    var translationIncrement : Float = 0.00
    var removeMenuPanRecognizer : UIPanGestureRecognizer?
    
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
    
    @IBAction func handleOpenPan(recognizer: UIScreenEdgePanGestureRecognizer) {
        let velocity = recognizer.velocityInView(self.view)
        if (velocity.x > 1500.0) {
            showMenu()
            return
        }
        
        let translation = recognizer.translationInView(self.view)
        
        switch recognizer.state {
            case .Began:
                print("began")
                addOverlay()
                
            case .Changed:
                if let view = menuViewController!.view {
                    if view.center.x < ((self.view.frame.width - 100.0)/2) - 0.1 {
                        view.center = CGPoint(x:view.center.x + translation.x,
                            y:UIScreen.mainScreen().bounds.height/2)
                        overlayView!.center = CGPoint(x: overlayView!.center.x + translation.x, y: UIScreen.mainScreen().bounds.height/2)
                        
                        let tran = Float(translation.x)
                        translationIncrement += tran
                        print(translationIncrement)
                        
                        let viewSection = Float(view.frame.size.width)
                        if translationIncrement > viewSection/12.0 {
                            overlayView!.alpha += 0.0555
                            translationIncrement = 0.0
                        }
                    }
                }
                
                recognizer.setTranslation(CGPointZero, inView: self.view)
            
            case .Ended:
                print("ended")
                if let view = menuViewController!.view {
                    translationIncrement = 0.0
                    
                    if view.center.x <= -(view.frame.size.width/2) {
                        overlayView!.alpha = 0.0
                        overlayView!.removeFromSuperview()
                    } else if view.center.x == view.frame.size.width/2 {
                        //do nothing
                    } else if view.center.x > self.view.frame.origin.x {
                        showMenu()
                    } else if (self.view.frame.origin.x - view.center.x)  < view.frame.size.width/2 {
                        isMenuShowing = true
                        hideMenu()
                    }
                }
            case .Possible:
                print("possible")
            case .Cancelled:
                print("cancelled")
            case .Failed:
                print("failed")
        }
    }
    
    func handleClosePan(recognizer: UIPanGestureRecognizer) {
        let velocity = recognizer.velocityInView(self.view)
        if (velocity.x < -1500.0) {
            hideMenu()
            return
        }
        print(UIScreen.mainScreen().bounds.width/2 - 50.0)
        let translation = recognizer.translationInView(self.view)
        
        switch recognizer.state {
        case .Began:
            print("began")
            overlayView!.frame.size.width = self.view.frame.width
            
        case .Changed:
            if let view = menuViewController!.view {
                if view.center.x > ((self.view.frame.width - 100.0)/2) + 0.1 {
                    overlayView!.alpha = 0.5
                } else if view.center.x > 0.0 - view.frame.width/2 {
                    view.center = CGPoint(x:view.center.x + translation.x,
                        y:UIScreen.mainScreen().bounds.height/2)
                    overlayView!.center = CGPoint(x: overlayView!.center.x + translation.x, y: UIScreen.mainScreen().bounds.height/2)
                    
                    let tran = Float(translation.x)
                    translationIncrement += tran
                    print(translationIncrement)
                    
                    let viewSection = Float(view.frame.size.width)
                    print(viewSection)
                    if -translationIncrement > viewSection/12.0 {
                        overlayView!.alpha -= 0.0555
                        translationIncrement = 0.0
                    }
                } else {
                    overlayView!.alpha = 0.0
                    overlayView!.removeFromSuperview()
                }
            }
            
            recognizer.setTranslation(CGPointZero, inView: self.view)
            
        case .Ended:
            print("ended")
            if let view = menuViewController!.view {
                translationIncrement = 0.0
                
                if view.center.x > self.view.frame.origin.x {
                    isMenuShowing = false
                    showMenu()
                } else if (self.view.frame.origin.x - view.center.x) < view.frame.size.width/2 {
                    hideMenu()
                }
            }
        case .Possible:
            print("possible")
        case .Cancelled:
            print("cancelled")
        case .Failed:
            print("failed")
        }
    }
    
    func showMenu() {
        addOverlay()
        
        UIView.animateWithDuration(0.3, animations: {
            self.menuViewController!.view.frame = CGRect(x: 0.0, y: self.menuTop, width: self.view.frame.width - 100.0, height: self.view.frame.height)
            self.overlayView!.frame = CGRectMake(self.view.frame.width - 100.0, 0.0, 100.0, self.view.frame.height)
            self.overlayView!.alpha = 0.5
            }, completion: { (Bool) -> Void in
                self.isMenuShowing = true
                
                //Add UITapGestureRecognizer to overlay view to dismiss menu on tap
                let tapRecognizer = UITapGestureRecognizer.init(target: self, action: "hideMenu")
                self.overlayView!.addGestureRecognizer(tapRecognizer)
                
                //Add UIPanGestureRecognizer to menu to handle draggin menu off screen
                self.removeMenuPanRecognizer = UIPanGestureRecognizer(target: self,
                    action: "handleClosePan:")
                self.menuViewController!.view.addGestureRecognizer(self.removeMenuPanRecognizer!)
        })
    }
    
    func hideMenu() {
        if isMenuShowing {
            UIView.animateWithDuration(0.3, animations: {
                self.menuViewController!.view.frame = CGRect(x: 0.0-self.view.frame.width+100.0, y: self.menuTop, width: self.view.frame.width - 100.0, height: self.view.frame.height)
                self.overlayView!.frame = self.view.frame
                self.overlayView!.alpha = 0.0
                }, completion: { (Bool) -> Void in
                    self.overlayView!.removeFromSuperview()
                    self.isMenuShowing = false
            })
        }
    }
    
    func addOverlay() {
        if overlayView == nil {
            overlayView = UIView.init(frame: CGRectMake(0.0, menuTop, self.view.frame.width, self.view.frame.height))
            overlayView?.backgroundColor = UIColor.blackColor()
            overlayView?.alpha = 0.0
        }
        overlayView?.removeFromSuperview()
        view.addSubview(overlayView!)
    }
    
    //MARK: - Menu View Controller Delegate
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
        
        if title == "New Game" {
            //Post Notification to NewGameViewController to disable scrollView panGestureRecognizer to allow edgePanRecognizer to work on left edge
            NSNotificationCenter.defaultCenter().postNotificationName("NewGameScreenVisibleNotification", object: edgePanRecognizer)
        }
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
        
        //Post Notification to NewGameViewController to disable scrollView panGestureRecognizer to allow edgePanRecognizer to work
        NSNotificationCenter.defaultCenter().postNotificationName("NewGameScreenVisibleNotification", object: edgePanRecognizer)
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
