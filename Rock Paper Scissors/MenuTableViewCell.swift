//
//  MenuTableViewCell.swift
//  Rock Paper Scissors
//
//  Created by Sahil Ishar on 3/16/16.
//  Copyright © 2016 Sahil Ishar. All rights reserved.
//

import UIKit

class MenuTableViewCell: UITableViewCell {
    
    var isDisabled : Bool = false
    @IBOutlet weak var btnImageView : UIImageView!
    @IBOutlet weak var titleLabel : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected {
            backgroundColor = UIColor(red: (56/255.0), green: (56/255.0), blue: (56/255.0), alpha: 1.0)
            titleLabel.textColor = UIColor.whiteColor()
        } else if (!isDisabled) {
            backgroundColor = UIColor.whiteColor()
            titleLabel.textColor = UIColor(red: (121/255.0), green: (121/255.0), blue: (121/255.0), alpha: 1.0)
        }
    }
    
    func disableCell() {
        isDisabled = true
        userInteractionEnabled = false
        let clr = UIColor(red: (202/255.0), green: (202/255.0), blue: (202/255.0), alpha: 0.5)
        titleLabel.textColor = clr
        btnImageView.backgroundColor = clr
    }
    
    func reEnableCell() {
        isDisabled = false
        userInteractionEnabled = true
        let clr = UIColor(red: (121/255.0), green: (121/255.0), blue: (121/255.0), alpha: 1.0)
        titleLabel.textColor = clr
        btnImageView.backgroundColor = clr
    }
}
