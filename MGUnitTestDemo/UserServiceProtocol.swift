//
//  UserServiceProtocol.swift
//  MGUnitTestDemo
//
//  Created by Tuan Truong on 12/17/15.
//  Copyright © 2015 Tuan Truong. All rights reserved.
//

import Foundation

protocol UserServiceProtocol {
    func getAll() -> [User]
    func addUser(user: User)
    func updateUser(user: User)
    func deleteUser(user: User)
}