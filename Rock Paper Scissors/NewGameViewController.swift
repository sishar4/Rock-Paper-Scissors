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
        print("Choose Single Player Game : %@", chooseSinglePlayer)
        //perform segue/action based on isSinglePlayer bool value (single vs. multi player)
        
    }
    
    func loadPageViews() {
        //Load Views for Single and Multi Player game options
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        print(screenSize.width)
        let pageWidth = screenSize.width
        
        let singlePlayerView: GameChooserView = GameChooserView.instanceFromNib() as! GameChooserView
        singlePlayerView.loadSinglePlayerView()
        singlePlayerView.frame = CGRectMake(0.0, 0.0, pageWidth, scrollView.frame.size.height)
        scrollView.addSubview(singlePlayerView)
        
        let multiPlayerView: GameChooserView = GameChooserView.instanceFromNib() as! GameChooserView
        multiPlayerView.loadMultiPlayerView()
        multiPlayerView.frame = CGRectMake(pageWidth, 0.0, pageWidth, scrollView.frame.size.height)
        scrollView.addSubview(multiPlayerView)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let pageWidth = scrollView.frame.size.width
        let page = Int(floor((scrollView.contentOffset.x * 2.0 + pageWidth) / (pageWidth * 2.0)))
        
        // Update the page control
        pageControl.currentPage = page
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadPageViews()
        
        let scrollViewSize = scrollView.frame.size
        let pageScrollViewSize = UIScreen.mainScreen().bounds
        scrollView.contentSize = CGSize(width: pageScrollViewSize.width * 2.0,
            height: scrollViewSize.height)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
