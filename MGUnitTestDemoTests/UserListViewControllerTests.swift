//
//  UserListViewControllerTests.swift
//  MGUnitTestDemo
//
//  Created by Tuan Truong on 12/24/15.
//  Copyright © 2015 Tuan Truong. All rights reserved.
//

import XCTest
@testable import MGUnitTestDemo

class UserListViewControllerTests: XCTestCase {
    
    var viewController: UserListViewController!
    
    override func setUp() {
        super.setUp()
        
        viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("UserListViewController") as! UserListViewController
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDataProviderHasTableViewPropertySetAfterLoading() {
        // Arrange
        
        // Act
        let _ = viewController.view
        
        // Assert
        XCTAssertTrue(viewController.userListDataProvider.tableView != nil, "The table view property of data provider should be set")
        XCTAssertTrue(viewController.tableView === viewController.userListDataProvider.tableView, "The table view should be set to the table view of data provider")
        
    }
    
    func testAddButtonTransitsToUserViewController() {
        // Arrange
        let controller = MockUserListViewController()
        
        // Act
        controller.onAddButtonClicked(UIBarButtonItem())
        
        // Assert
        if let identifier = controller.segueIdentifier {
            XCTAssertEqual(controller.userSegueIdentifier, identifier, "The segue identifier should be the user segue identifier")
        }
        else {
            XCTFail("Segue should be performed")
        }
    }
    
    func testTransitsToUserViewControllerAfterSelectingTableViewRow() {
        // Arrange
        let controller = MockUserListViewController()
        let dataProvider = MockUserListDataProvider()
        controller.userListDataProvider = dataProvider
        
        // Act
        controller.tableView(UITableView(), didSelectRowAtIndexPath: NSIndexPath(forRow: 0, inSection: 0))
        
        // Assert
        if let identifier = controller.segueIdentifier {
            XCTAssertEqual(controller.userSegueIdentifier, identifier, "The segue identifier should be the user segue identifier")
        }
        else {
            XCTFail("Segue should be performed")
        }
    }
    
    func testArgumentsArePassedOnUserSegue() {
        // Arrange
        let userController = UserViewController()
        let navigationController = UINavigationController(rootViewController: userController)
        let segue = UIStoryboardSegue(identifier: viewController.userSegueIdentifier,
            source: viewController,
            destination: navigationController)
        let user = User()
        
        // Act
        viewController.prepareForSegue(segue, sender: user)
        
        // Assert
        XCTAssertTrue(userController.delegate === viewController, "The view controller should be set as user view controller's delegate")
        XCTAssertTrue(userController.user === user, "The user property of user view controller should be set")
    }
    
    func testAddUser() {
        // Arrange
        let dataProvider = MockUserListDataProvider()
        viewController.userListDataProvider = dataProvider
        
        let user = User()
        user.id = ""
        
        let userViewController = UserViewController()
        userViewController.user = user
        
        // Act
        viewController.userViewControllerDone(userViewController)
        
        // Assert
        XCTAssertTrue(dataProvider.isUserAdded, "A new user should be added")
        XCTAssertTrue(user.id != "", "The new user should have an id")
    }
    
    func testUpdateUser() {
        // Arrange
        let dataProvider = MockUserListDataProvider()
        viewController.userListDataProvider = dataProvider
        
        let user = User()
        user.id = NSUUID().UUIDString
        
        let userViewController = UserViewController()
        userViewController.user = user
        
        // Act
        viewController.userViewControllerDone(userViewController)
        
        // Assert
        XCTAssertTrue(dataProvider.isUserUpdated, "The user should be updated")
    }
}

class MockUserListDataProvider: NSObject, UserListDataProviderProtocol {
    weak var tableView: UITableView?
    var isUserAdded = false
    var isUserUpdated = false
    var isFetched = false
    
    subscript(index: Int) -> User? {
        return User()
    }
    
    func addUser(user: User) {
        isUserAdded = true
    }
    func updateUser(user: User) {
        isUserUpdated = true
    }
    func fetch() {
        isFetched = true
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

class MockUserListViewController: UserListViewController {
    var segueIdentifier: String?
    override func performSegueWithIdentifier(identifier: String, sender: AnyObject?) {
        segueIdentifier = identifier
    }
}
