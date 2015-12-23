//
//  UserViewController.swift
//  MGUnitTestDemo
//
//  Created by Tuan Truong on 12/22/15.
//  Copyright © 2015 Tuan Truong. All rights reserved.
//

import UIKit

protocol UserViewControllerDelegate: class {
    func userViewControllerDone(sender: UserViewController)
}

class UserViewController: UITableViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    weak var delegate: UserViewControllerDelegate?
    
    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameTextField.becomeFirstResponder()
        
        if let user = self.user {
            usernameTextField.text = user.username
            emailTextField.text = user.email
        }
    }

    @IBAction func onDoneButtonClicked(sender: UIBarButtonItem) {
        if user == nil {
            user = User()
        }
        user.username = usernameTextField.text!
        user.email = emailTextField.text!
        self.delegate?.userViewControllerDone(self)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func onCancelButtonClicked(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
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
