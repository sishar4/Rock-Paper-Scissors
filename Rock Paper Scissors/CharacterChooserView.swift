//
//  CharacterChooserView.swift
//  Rock Paper Scissors
//
//  Created by Sahil Ishar on 3/21/16.
//  Copyright © 2016 Sahil Ishar. All rights reserved.
//

import UIKit

protocol CharacterChooserDelegate: class {
    func didPlayWithCharacter(characterName: String)
}

class CharacterChooserView: UIView, iCarouselDelegate, iCarouselDataSource {

    weak var delegate: CharacterChooserDelegate?
    
    var rockImageView : FLAnimatedImageView?
    var paperImageView : FLAnimatedImageView?
    var scissorsImageView : FLAnimatedImageView?
    var previousIndex : NSInteger = 1
    var numShakes : NSInteger = 0
    var timer : NSTimer?
    var time : Float = 0.0
    
    @IBOutlet weak var headerLabel : UILabel!
    @IBOutlet weak var progressBar : UIProgressView!
    @IBOutlet weak var carouselView : iCarousel!
    @IBOutlet weak var rockButton : UIButton!
    @IBOutlet weak var paperButton : UIButton!
    @IBOutlet weak var scissorsButton : UIButton!
    
    
    //MARK: - Button Clicks
    @IBAction func rockClicked(sender: UIButton) {
        carouselView.scrollToItemAtIndex(0, animated: true)
    }
    
    @IBAction func paperClicked(sender: UIButton) {
        carouselView.scrollToItemAtIndex(1, animated: true)
    }
    
    @IBAction func scissorsClicked(sender: UIButton) {
        carouselView.scrollToItemAtIndex(2, animated: true)
    }
    
    func doubleTapped() {
        print("Index of choice: ", carouselView.currentItemIndex)
    }
    
    
    //MARK: - iCarousel Delegate
    func numberOfItemsInCarousel(carousel: iCarousel) -> Int {
        return 3
    }

    func carousel(carousel: iCarousel, viewForItemAtIndex index: Int, reusingView view: UIView?) -> UIView {
        var itemView: FLAnimatedImageView
        if (view == nil) {
            itemView = FLAnimatedImageView(frame:CGRect(x:0.0, y:0.0, width:200.0, height:360.0))
        } else {
            itemView = view as! FLAnimatedImageView;
        }
        
        if index == 0 {
            itemView = rockImageView!
        } else if index == 1 {
            itemView = paperImageView!
        } else {
            itemView = scissorsImageView!
        }
        
        return itemView
    }
    
    func carousel(carousel: iCarousel, valueForOption option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        switch (option)
        {
        case .Wrap:
            return 1.0
        case .Radius:
            return 225.0
        default:
            return value
        }
    }
    
    func carouselCurrentItemIndexDidChange(carousel: iCarousel) {
        let index = carouselView.currentItemIndex
        
        if previousIndex != index {
            switch (previousIndex) {
            case 0:
                rockImageView!.animatedImage = FLAnimatedImage(animatedGIFData: NSData(contentsOfFile: NSBundle.mainBundle().pathForResource("rock_deselect", ofType: "gif")!))
            case 1:
                paperImageView!.animatedImage = FLAnimatedImage(animatedGIFData: NSData(contentsOfFile: NSBundle.mainBundle().pathForResource("paper_deselect", ofType: "gif")!))
            case 2:
                scissorsImageView!.animatedImage = FLAnimatedImage(animatedGIFData: NSData(contentsOfFile: NSBundle.mainBundle().pathForResource("scissors_deselect", ofType: "gif")!))
            default:
                return
            }
        }
        
        switch (index) {
        case 0:
            rockImageView!.animatedImage = FLAnimatedImage(animatedGIFData: NSData(contentsOfFile: NSBundle.mainBundle().pathForResource("rock_select", ofType: "gif")!))
        case 1:
            paperImageView!.animatedImage = FLAnimatedImage(animatedGIFData: NSData(contentsOfFile: NSBundle.mainBundle().pathForResource("paper_select", ofType: "gif")!))
        case 2:
            scissorsImageView!.animatedImage = FLAnimatedImage(animatedGIFData: NSData(contentsOfFile: NSBundle.mainBundle().pathForResource("scissors_select", ofType: "gif")!))
        default:
            return
        }
        
        previousIndex = index
    }
    
    
    //MARK: - Character Selection by Gestures
    func addGestureRecognizers(imgView: FLAnimatedImageView) {
        let doubleTap = UITapGestureRecognizer(target: self, action: "doubleTapped")
        doubleTap.numberOfTapsRequired = 2
        imgView.addGestureRecognizer(doubleTap)
    }
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
        if motion == .MotionShake {
            numShakes++
            
            switch (numShakes) {
            case 1:
                headerLabel.text = "ROCK!"
            case 2:
                headerLabel.text = "PAPER!"
            case 3:
                headerLabel.text = "SCISSOR!"
            case 4:
                progressBarFinished()
                
                //Show Game Result View
                carouselView.removeFromSuperview()
                performSelector("playGame", withObject: nil, afterDelay: 1.0)
                return
            default:
                return
            }
            
            //Re-start progress bar
            if (progressBar.hidden) {
                progressBar.hidden = false
            }
            progressBar.setProgress(1.0, animated: false)
            
            time = 0.0
            timer = NSTimer.scheduledTimerWithTimeInterval(0.001, target: self, selector:Selector("setProgress"), userInfo: nil, repeats: true)
        }
    }
    
    func setProgress() {
        time += 0.001
        progressBar.setProgress(1.0 - (time / 3.0), animated: true)
        if time >= 3 {
            progressBarFinished()
        }
    }
    
    func progressBarFinished() {
        timer!.invalidate()
        progressBar.hidden = true
        if (numShakes == 4) {
            headerLabel.text = "SHOOT!"
        } else {
            headerLabel.text = "CHOOSE YOUR CHARACTER"
        }
        
        numShakes = 0
    }
    
    func playGame() {
        removeFromSuperview()
        delegate?.didPlayWithCharacter("Paper")
    }
    
    //Allows view to handle Shake events
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "CharacterChooserView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
    }
    
    override func awakeFromNib() {
        translatesAutoresizingMaskIntoConstraints = true
        
        progressBar.hidden = true
        
        rockImageView = FLAnimatedImageView.init(frame: CGRectMake(0.0, 0.0, 150.0, 270.0))
        rockImageView!.animatedImage = FLAnimatedImage(animatedGIFData: NSData(contentsOfFile: NSBundle.mainBundle().pathForResource("rock_deselect", ofType: "gif")!))
        rockImageView!.contentMode = .ScaleAspectFit
//        addGestureRecognizers(rockImageView!)
        
        paperImageView = FLAnimatedImageView.init(frame: CGRectMake(0.0, 0.0, 150.0, 270.0))
        paperImageView!.animatedImage = FLAnimatedImage(animatedGIFData: NSData(contentsOfFile: NSBundle.mainBundle().pathForResource("paper_select", ofType: "gif")!))
        paperImageView!.contentMode = .ScaleAspectFit
//        addGestureRecognizers(paperImageView!)
        
        scissorsImageView = FLAnimatedImageView.init(frame: CGRectMake(0.0, 0.0, 150.0, 270.0))
        scissorsImageView!.animatedImage = FLAnimatedImage(animatedGIFData: NSData(contentsOfFile: NSBundle.mainBundle().pathForResource("scissors_deselect", ofType: "gif")!))
        scissorsImageView!.contentMode = .ScaleAspectFit
//        addGestureRecognizers(scissorsImageView!)
        
        
        //iCarousel
        carouselView.type = iCarouselType.Cylinder
        carouselView.pagingEnabled = true
        carouselView.decelerationRate = 0.0
        carouselView.reloadData()
        carouselView.scrollToItemAtIndex(1, animated: false)
        
        becomeFirstResponder()
    }
}
