//
//  GameInfoViewController.swift
//  Rock Paper Scissors
//
//  Created by Sahil Ishar on 3/18/16.
//  Copyright © 2016 Sahil Ishar. All rights reserved.
//

import UIKit

class GameInfoViewController: UIViewController {

    @IBOutlet weak var exitViewButton : UIButton!
    
    @IBAction func exitView(sender: UIButton) {
        exitInfoView()
    }
    
    func exitInfoView() {
        //End Gif
        view.removeFromSuperview()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Start Gif
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
