//
//  MenuViewController.swift
//  Rock Paper Scissors
//
//  Created by Sahil Ishar on 3/16/16.
//  Copyright © 2016 Sahil Ishar. All rights reserved.
//

import UIKit

protocol MenuViewControllerDelegate: class {
    func didSelectMenuItemWithTitle(title : String)
}

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    weak var delegate: MenuViewControllerDelegate?
    var cellItemsArray = []
    @IBOutlet weak var signInButton : UIButton!
    @IBOutlet weak var tableView : UITableView!
    
    @IBAction func signInClicked(sender: UIButton) {
        
    }
    
    // MARK: - Table View Delegate
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("menuCell")! as! MenuTableViewCell
        
        cell.titleLabel.text = cellItemsArray[indexPath.row] as? String
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let selection = cellItemsArray.objectAtIndex(indexPath.row) as! String
        delegate?.didSelectMenuItemWithTitle(selection)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60.0
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let indexPath = NSIndexPath.init(forRow: 0, inSection: 0)
        tableView.selectRowAtIndexPath(indexPath, animated: false, scrollPosition: UITableViewScrollPosition.Top)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cellItemsArray = ["New Game", "Invitations", "About", "Sign In"]
        tableView.registerNib(UINib(nibName: "MenuTableViewCell", bundle: nil), forCellReuseIdentifier: "menuCell")
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
