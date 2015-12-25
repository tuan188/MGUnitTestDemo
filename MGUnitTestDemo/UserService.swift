//
//  UserService.swift
//  MGUnitTestDemo
//
//  Created by Tuan Truong on 12/17/15.
//  Copyright © 2015 Tuan Truong. All rights reserved.
//

import UIKit

class UserService: NSObject, UserServiceProtocol {
    
    static var userDic = Dictionary<String, User>()
    
    func getAll() -> [User] {
        return [User](UserService.userDic.values)
    }
    
    func addUser(user: User)  {
        UserService.userDic[user.id] = user
    }
    
    func updateUser(user: User) {
        UserService.userDic[user.id] = user
    }
    func deleteUser(user: User) {
        UserService.userDic.removeValueForKey(user.id)
    }
}
