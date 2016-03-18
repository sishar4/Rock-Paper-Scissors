//
//  NewGameViewController.swift
//  Rock Paper Scissors
//
//  Created by Sahil Ishar on 3/16/16.
//  Copyright © 2016 Sahil Ishar. All rights reserved.
//

import UIKit

class NewGameViewController: UIViewController, UIScrollViewDelegate {

    var chooseSinglePlayer : Bool = true
    @IBOutlet weak var scrollView : UIScrollView!
    @IBOutlet weak var pageControl : UIPageControl!
    @IBOutlet weak var playButton : UIButton!
    
    
    @IBAction func playButtonClicked(sender: UIButton) {
        print("Choose Single Player Game : ", chooseSinglePlayer)
        //perform segue/action based on isSinglePlayer bool value (single vs. multi player)
        if chooseSinglePlayer {
            //Start Single Player Game
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let singlePlayerGame = storyBoard.instantiateViewControllerWithIdentifier("GameNavControllerSingle")
            let appDelegate: UIApplicationDelegate = UIApplication.sharedApplication().delegate!
            appDelegate.window!!.rootViewController = singlePlayerGame
        } else {
            //Start Multiplayer Game
        }
    }
    
    func loadPageViews() {
        //Load Views for Single and Multi Player game options
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        print(screenSize.width)
        let pageWidth = screenSize.width
        
        let singlePlayerView: GameChooserView = GameChooserView.instanceFromNib() as! GameChooserView
        singlePlayerView.loadSinglePlayerView()
        singlePlayerView.frame = CGRectMake(0.0, 0.0, pageWidth, scrollView.bounds.size.height)
        
        //Add to UIView before adding to scrollview to save autolayout constraints
        let contentView1 = UIView.init(frame: CGRectMake(0.0, 0.0, pageWidth, scrollView.bounds.size.height))
        contentView1.addSubview(singlePlayerView)
        scrollView.addSubview(contentView1)

        let multiPlayerView: GameChooserView = GameChooserView.instanceFromNib() as! GameChooserView
        multiPlayerView.loadMultiPlayerView()
        multiPlayerView.frame = CGRectMake(0.0, 0.0, pageWidth, scrollView.frame.size.height)
        
        let contentView2 = UIView.init(frame: CGRectMake(pageWidth, 0.0, pageWidth, scrollView.frame.size.height))
        contentView2.addSubview(multiPlayerView)
        scrollView.addSubview(contentView2)
        
        scrollView.contentSize = CGSize(width: pageWidth * 2, height: 1.0)
    }
    
    // MARK: Scroll View Delegate
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let pageWidth = scrollView.frame.size.width
        let page = Int(floor((scrollView.contentOffset.x * 2.0 + pageWidth) / (pageWidth * 2.0)))
        
        if page == 0 {
            chooseSinglePlayer = true
        } else {
            chooseSinglePlayer = false
        }
        
        // Update the page control
        pageControl.currentPage = page
    }
    
    //Notification to disable pan gesture on scrollview
    //Allowing pan gesture on MainVC to open menu
    func disableScrollViewPanWithGesture(notification: NSNotification){
        let recognizer = notification.object as! UIScreenEdgePanGestureRecognizer
        scrollView.panGestureRecognizer.requireGestureRecognizerToFail(recognizer)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadPageViews()
        
        let pageScrollViewSize = UIScreen.mainScreen().bounds
        scrollView.frame = CGRectMake(0.0, scrollView.frame.origin.y, pageScrollViewSize.width, scrollView.frame.size.height)

        //Add Notification observer
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "disableScrollViewPanWithGesture:", name:"NewGameScreenVisibleNotification", object: nil)
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        //Remove Notification observer
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
}
