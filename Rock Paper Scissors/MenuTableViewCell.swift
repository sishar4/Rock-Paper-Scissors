//
//  MenuTableViewCell.swift
//  Rock Paper Scissors
//
//  Created by Sahil Ishar on 3/16/16.
//  Copyright © 2016 Sahil Ishar. All rights reserved.
//

import UIKit

class MenuTableViewCell: UITableViewCell {

    @IBOutlet weak var btnImageView : UIImageView!
    @IBOutlet weak var titleLabel : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected {
            self.backgroundColor = UIColor.darkGrayColor()
            titleLabel.textColor = UIColor.whiteColor()
        } else {
            self.backgroundColor = UIColor.whiteColor()
            titleLabel.textColor = UIColor.darkGrayColor()
        }
    }
}
