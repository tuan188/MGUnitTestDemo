//
//  UserService.swift
//  MGUnitTestDemo
//
//  Created by Tuan Truong on 12/17/15.
//  Copyright © 2015 Tuan Truong. All rights reserved.
//

import UIKit

class UserService: NSObject, UserServiceProtocol {
    
    var userDic = Dictionary<String, User>()
    
    func getAll() -> [User] {
        return [User](userDic.values)
    }
    
    func addUser(user: User)  {
        userDic[user.id] = user
    }
    
    func updateUser(user: User) {
        userDic[user.id] = user
    }
    func deleteUser(user: User) {
        userDic.removeValueForKey(user.id)
    }
}
