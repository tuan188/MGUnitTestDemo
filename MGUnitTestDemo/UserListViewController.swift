//
//  UserListViewController.swift
//  MGUnitTestDemo
//
//  Created by Tuan Truong on 12/22/15.
//  Copyright © 2015 Tuan Truong. All rights reserved.
//

import UIKit

class UserListViewController: UITableViewController {
    
    let userService: UserServiceProtocol = UserService()
    
    var users: [User]!

    override func viewDidLoad() {
        super.viewDidLoad()

        users = userService.getAll()
    }
    
    @IBAction func onAddButtonClicked(sender: UIBarButtonItem) {
        self.performSegueWithIdentifier("presentUser", sender: nil)
    }
    

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("userCell", forIndexPath: indexPath) as! UserCell
        let user = users[indexPath.row]
        cell.userNameLabel.text = user.username
        cell.emailLabel.text = user.email
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let user = users[indexPath.row]
            userService.deleteUser(user)
            users = userService.getAll()
            tableView.reloadData()
        }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "presentUser" {
            let controller = (segue.destinationViewController as! UINavigationController).topViewController as! UserViewController
            controller.delegate = self
        }
    }
}

extension UserListViewController: UserViewControllerDelegate {
    func userViewControllerDone(sender: UserViewController) {
        let user = sender.user
        if user.id.isEmpty { // add user
            user.id = NSUUID().UUIDString
            userService.addUser(user)
        }
        else {
            userService.updateUser(user)
        }
        users = userService.getAll()
        tableView.reloadData()
    }
}
