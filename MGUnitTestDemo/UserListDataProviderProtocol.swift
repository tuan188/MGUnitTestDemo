//
//  UserListDataProviderProtocol.swift
//  MGUnitTestDemo
//
//  Created by Tuan Truong on 12/24/15.
//  Copyright © 2015 Tuan Truong. All rights reserved.
//

import Foundation
import UIKit

protocol UserListDataProviderProtocol: UITableViewDataSource {
    weak var tableView: UITableView? { get set }
    subscript(index: Int) -> User? { get }
    func addUser(user: User)
    func updateUser(user: User)
    func fetch()
}
