//
//  GameChooserView.swift
//  Rock Paper Scissors
//
//  Created by Sahil Ishar on 3/16/16.
//  Copyright © 2016 Sahil Ishar. All rights reserved.
//

import UIKit

class GameChooserView: UIView {

    @IBOutlet weak var playerImgButton : UIButton!
    @IBOutlet weak var gameTypeLabel : UILabel!
    @IBOutlet weak var gameDetailLabel : UILabel!
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "GameChooserView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
    }
    
    func loadSinglePlayerView() {
        gameTypeLabel.text = "Single Player"
        gameDetailLabel.text = "Take on the iOS robot!"
    }
    
    func loadMultiPlayerView() {
        gameTypeLabel.text = "MultiPlayer"
        gameDetailLabel.text = "Find people to play with!"
    }

    override func awakeFromNib() {
        playerImgButton.layer.cornerRadius = 90.0
        translatesAutoresizingMaskIntoConstraints = true
    }

}
