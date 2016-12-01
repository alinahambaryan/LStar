//
//  TransactionTableViewController.swift
//  Lendstar
//
//  Created by ALINA HAMBARYAN on 11/23/16.
//  Copyright © 2016 ALINA HAMBARYAN. All rights reserved.
//

import UIKit


class TransactionTableViewController: BaseViewController, UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var balanceLabel: UILabel!
    
    var viewModel : UserViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.balanceLabel.text = viewModel?.balance
        self.navigationItem.title = "Transactions"
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector: #selector(TransactionTableViewController.pop),
                                                         name: "TransferMade",
                                                         object: nil)

    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let viewModel = self.viewModel{
            if let transactions = viewModel.user.transactions {
                return transactions.count
            }
        }
            return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Subtitle, reuseIdentifier: "TransactionCell")
        cell.backgroundColor = indexPath.row%2 == 0 ? UIColor(hex: 0xE8EFC7): UIColor(hex: 0x8CB8AF)

        if let user = self.viewModel?.user{
            if let transactions = user.transactions {
                let transaction = transactions[indexPath.row]
                cell.textLabel?.text = transaction.reason //+ ", " + String(transaction.amount)
                cell.detailTextLabel?.text = transaction.executionDate
            }
        }
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
    
    func pop() {
        self.navigationController!.popViewControllerAnimated(false)
    }
}