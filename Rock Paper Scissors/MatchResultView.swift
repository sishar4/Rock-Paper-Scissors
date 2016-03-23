//
//  MatchResultView.swift
//  Rock Paper Scissors
//
//  Created by Sahil Ishar on 3/23/16.
//  Copyright © 2016 Sahil Ishar. All rights reserved.
//

import UIKit

protocol MatchResultDelegate: class {
//    func updateWithResult()
    func playAgain()
}
class MatchResultView: UIView {

    weak var delegate: MatchResultDelegate?
    
    @IBOutlet weak var resultHeaderLabel : UILabel!
    @IBOutlet weak var resultDescriptionLabel : UILabel!
    @IBOutlet weak var resultGifView : UIView!
    @IBOutlet weak var playAgainButton : UIButton!
    
    @IBAction func playAgainClicked(sender: UIButton) {
        removeFromSuperview()
        delegate?.playAgain()
    }
    
    
//    func playWithCharacter(character: String) {
//        
//    }
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "MatchResultView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
    }
    
    override func awakeFromNib() {
        
    }
}
