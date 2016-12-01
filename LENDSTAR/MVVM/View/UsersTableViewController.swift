//
//  FirstViewController.swift
//  Lendstar
//
//  Created by ALINA HAMBARYAN on 11/22/16.
//  Copyright © 2016 ALINA HAMBARYAN. All rights reserved.
//

import UIKit

class UsersTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var userTableView: UITableView!
    var data = DataProvider.sharedInstance.userViewModels
   
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setAddButton()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.reloadData()
        self.addButton.hidden = data.count != 0
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UserCell = tableView.dequeueReusableCellWithIdentifier("UserCell", forIndexPath: indexPath) as! UserCell
        let user = data[indexPath.row]
        cell.configureCell(user)
        cell.backgroundColor = indexPath.row%2 == 0 ? UIColor(hex: 0xE8EFC7): UIColor(hex: 0x8CB8AF)
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let currentUser = data[indexPath.row]
        if currentUser.user.transactions != nil {
            let viewController:TransactionTableViewController =
                UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("TransactionTableViewController") as! TransactionTableViewController
            viewController.viewModel = currentUser
            self.navigationController!.pushViewController(viewController, animated: true)

        } else if (currentUser.user.creditCard?.creditCardNumber?.isEmpty == true) {
            let viewController:AddUserViewController =
                UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("AddUserViewController") as! AddUserViewController
            viewController.viewModel = currentUser
            self.navigationController!.pushViewController(viewController, animated: true)
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
    @IBAction func addUser(sender: AnyObject) {
        let viewController:AddUserViewController =
            UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("AddUserViewController") as! AddUserViewController
        self.navigationController!.pushViewController(viewController, animated: true)
    }
    
    func setAddButton () {
        let backButton = UIBarButtonItem.init(title: "Add", style: .Plain, target: self, action:#selector(UsersTableViewController.addUser(_:)))
        self.navigationItem.rightBarButtonItem = backButton
    }
    
    func reloadData() {
        data = DataProvider.sharedInstance.userViewModels
        self.userTableView .reloadData()
    }
}

