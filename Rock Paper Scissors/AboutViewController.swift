//
//  AboutViewController.swift
//  Rock Paper Scissors
//
//  Created by Sahil Ishar on 3/17/16.
//  Copyright © 2016 Sahil Ishar. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {

    @IBOutlet weak var videoLinkButton : UIButton!
    
    @IBAction func openLink(sender: UIButton) {
        let videoUrl = NSURL(string: "http://www.youtube.com/watch?v=UYxpX3N20qU")
        if UIApplication.sharedApplication().canOpenURL(videoUrl!) {
            UIApplication.sharedApplication().openURL(videoUrl!)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
