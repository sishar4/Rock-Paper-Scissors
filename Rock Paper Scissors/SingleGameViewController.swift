//
//  SingleGameViewController.swift
//  Rock Paper Scissors
//
//  Created by Sahil Ishar on 3/18/16.
//  Copyright © 2016 Sahil Ishar. All rights reserved.
//

import UIKit

class SingleGameViewController: UIViewController, CharacterChooserDelegate, MatchResultDelegate {

    let storyBoard = UIStoryboard(name: "Main", bundle: nil)
    var readyView : SingleGameReadyViewController?
    var infoView : GameInfoViewController?
    let top : CGFloat = UIScreen.mainScreen().bounds.origin.y
    //for showing correct character centered in carousel in chooser view
    var characterIndex : Int = 1
    
    @IBOutlet weak var userAvatar : UIImageView!
    @IBOutlet weak var robotAvatar : UIImageView!
    @IBOutlet weak var userScoreLabel : UILabel!
    @IBOutlet weak var robotScoreLabel : UILabel!
    @IBOutlet weak var currentRoundImageView : UIImageView!
    @IBOutlet weak var currentGameView : UIView!
    
    @IBOutlet weak var homeButton : UIBarButtonItem!
    @IBOutlet weak var infoButton : UIBarButtonItem!
    
    @IBAction func exitGame(sender: UIBarButtonItem) {
        let exitAlert = UIAlertController(title: "Forfeit Match?", message: "Are you sure you want to leave? The current match will be forfeited.", preferredStyle: UIAlertControllerStyle.Alert)
        exitAlert.addAction(UIAlertAction(title: "LEAVE", style: .Default, handler: { (action: UIAlertAction!) in
            self.exitGame()
        }))
        exitAlert.addAction(UIAlertAction(title: "CANCEL", style: .Default, handler: nil))
        
        presentViewController(exitAlert, animated: true, completion: nil)
    }
    
    func exitGame() {
        //Exit Single Player Game
        let mainNav = storyBoard.instantiateViewControllerWithIdentifier("MainNavController")
        let appDelegate: UIApplicationDelegate = UIApplication.sharedApplication().delegate!
        appDelegate.window!!.rootViewController = mainNav
    }
    
    @IBAction func infoButtonClicked(sender: UIBarButtonItem) {
        if infoView == nil {
            infoView = storyBoard.instantiateViewControllerWithIdentifier("GameInfoViewController") as? GameInfoViewController
            infoView!.view.frame = CGRectMake(0.0, top, self.view.frame.width, self.view.frame.height)
        }
        
        let win:UIWindow = UIApplication.sharedApplication().delegate!.window!!
        win.addSubview(infoView!.view)
        win.bringSubviewToFront(infoView!.view)
    }
    
    
    func loadAndShowCharacterView() {
        let characterChooserView : CharacterChooserView = CharacterChooserView.instanceFromNib() as! CharacterChooserView
        characterChooserView.frame = CGRectMake(0.0, 0.0, currentGameView!.frame.width, currentGameView!.frame.height)
        characterChooserView.delegate = self
        characterChooserView.passedIndex = characterIndex
        currentGameView!.addSubview(characterChooserView)
    }
    
    // MARK: - Match Result Delegate
    func playAgain() {
        loadAndShowCharacterView()
    }
    
    
    // MARK: - Character Chooser Delegate
    func didPlayWithCharacter(characterName: String, atIndex: Int) {
        print(characterName)
        characterIndex = atIndex
        
        let matchResultView : MatchResultView = MatchResultView.instanceFromNib() as! MatchResultView
        matchResultView.frame = CGRectMake(0.0, 0.0, currentGameView!.frame.width, currentGameView!.frame.height)
        matchResultView.delegate = self
        currentGameView!.addSubview(matchResultView)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        readyView = storyBoard.instantiateViewControllerWithIdentifier("GameReadyViewControllerSingle") as? SingleGameReadyViewController
        readyView!.view.frame = CGRectMake(0.0, 0.0, self.view.frame.width, self.view.frame.height)
        view.addSubview(readyView!.view)
        
        
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(3.0 * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue()) {
            if self.infoView != nil {
                self.infoView?.exitInfoView()
            }
            self.readyView!.view.removeFromSuperview()
            self.loadAndShowCharacterView()
        }
    }

    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
