//
//  UserListDataProvider.swift
//  MGUnitTestDemo
//
//  Created by Tuan Truong on 12/24/15.
//  Copyright © 2015 Tuan Truong. All rights reserved.
//

import UIKit

class UserListDataProvider: NSObject, UserListDataProviderProtocol {
    weak var tableView: UITableView?
    
    var users: [User]?
    let userService: UserServiceProtocol = UserService()
    
    subscript(index: Int) -> User? {
        if let users = users where index < users.count {
            return users[index]
        }
        return nil
    }
    
    func addUser(user: User) {
        userService.addUser(user)
    }
    
    func updateUser(user: User) {
        userService.updateUser(user)
    }
    
    func fetch() {
        users = userService.getAll()
        tableView?.reloadData()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("userCell", forIndexPath: indexPath) as! UserCell
        let user = users![indexPath.row]
        cell.userNameLabel.text = user.username
        cell.emailLabel.text = user.email
        return cell
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let user = users![indexPath.row]
            userService.deleteUser(user)
            fetch()
        }
    }
}
