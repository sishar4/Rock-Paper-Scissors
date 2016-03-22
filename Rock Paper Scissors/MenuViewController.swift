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
        //Handle sign in functionality
    }
    
    func signInUser() {
        
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
        
        if (cell.titleLabel.text == "Invitations") {
            //Check if signed in or not
            //If not
            cell.disableCell()
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //Pass title of selected cell to RPSMainViewController to load the correct view
        
        let selection = cellItemsArray.objectAtIndex(indexPath.row) as! String
        if selection != "Sign In" {
            delegate?.didSelectMenuItemWithTitle(selection)
        } else {
            signInUser()
        }
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
}
