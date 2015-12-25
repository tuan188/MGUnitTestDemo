//
//  UserListViewController.swift
//  MGUnitTestDemo
//
//  Created by Tuan Truong on 12/22/15.
//  Copyright © 2015 Tuan Truong. All rights reserved.
//

import UIKit

class UserListViewController: UITableViewController {
    
    var userListDataProvider: UserListDataProviderProtocol!
    let userSegueIdentifier = "presentUser"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        userListDataProvider = UserListDataProvider()
        userListDataProvider.tableView = self.tableView
        tableView.dataSource = userListDataProvider
    }
    
    @IBAction func onAddButtonClicked(sender: UIBarButtonItem) {
        self.performSegueWithIdentifier(userSegueIdentifier, sender: nil)
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let user = userListDataProvider[indexPath.row]
        if user != nil  {
            self.performSegueWithIdentifier(userSegueIdentifier, sender: user)
        }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == userSegueIdentifier {
            let controller = (segue.destinationViewController as! UINavigationController).topViewController as! UserViewController
            controller.delegate = self
            controller.user = sender as? User
        }
    }
}

extension UserListViewController: UserViewControllerDelegate {
    func userViewControllerDone(sender: UserViewController) {
        let user = sender.user
        if user.id.isEmpty { // add user
            user.id = NSUUID().UUIDString
            userListDataProvider.addUser(user)
        }
        else {
            userListDataProvider.updateUser(user)
        }
        userListDataProvider.fetch()
    }
}
