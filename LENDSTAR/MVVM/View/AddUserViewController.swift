//
//  AddUserViewController.swift
//  Lendstar
//
//  Created by ALINA HAMBARYAN on 11/22/16.
//  Copyright © 2016 ALINA HAMBARYAN. All rights reserved.
//

import UIKit

class AddUserViewController : BaseViewController {
    @IBOutlet weak var userTexField: UITextField!
    @IBOutlet weak var creditCardTextField: UITextField!
    var viewModel:UserViewModel? = nil;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    func setupUI() {
        if let viewModel = self.viewModel {
            self.userTexField.text = viewModel.name
            self.creditCardTextField.text = viewModel.cardNumber
        }
    }
    
    @IBAction func addUser(sender: AnyObject) {
        if (!self.userTexField.text!.isEmpty) && (self.creditCardTextField.text!.isEmpty) {
            self.addUserWithoutCreditCard()
        }
        else if (!self.userTexField.text!.isEmpty) && (!self.creditCardTextField.text!.isEmpty){
            self.addUserWithCreditCard()
        }
        else if (self.userTexField.text!.isEmpty) && (self.creditCardTextField.text!.isEmpty){
            self.showErrorWithMessage("Warning", message: "Invalid arguments", actionHandler: {return})
        }
    }
    
    func addUserWithoutCreditCard() {
        let user = User(name: self.userTexField.text!, creditCard: CreditCard(amount: 0, creditCardNumber: self.creditCardTextField.text!))
        let newViewModel =  UserViewModel(user: user)
        if (newViewModel.userNameIsValid) {
            self.viewModel?.deleteUserViewModel()
            newViewModel.updateUser()
            self.navigationController!.popViewControllerAnimated(true)
        } else {
            self.showErrorWithMessage("Error", message: "User name should have more than 4 and less than 15 characters", actionHandler: {return})
        }
    }
    
    func addUserWithCreditCard() {
        if (self.creditCardTextField.text?.characters.count > 19){
            self.showErrorWithMessage("Error", message: "Input has more than 19 characters", actionHandler: {})
            return
        }
        let user = User(name: self.userTexField.text!, creditCard: CreditCard(amount: 500, creditCardNumber: self.creditCardTextField.text!))
        let newViewModel =  UserViewModel(user: user)

        if (!newViewModel.userNameIsValid) {
            self.showErrorWithMessage("Error", message: "User name should have more than 4 and less than 15 characters", actionHandler: {})
            return
        }
        else if (newViewModel.userWithNameHasValidCard()){
            self.showErrorWithMessage("Error", message: "This user already has a valid credit card", actionHandler: {})
            return
        }
        else if (!newViewModel.cardNumberIsValid) {
            self.showErrorWithMessage("Error", message: "This card is invalid", actionHandler: {})
            return
        }
        else if (newViewModel.isCreditCardAlreadyExistsInSystem()) {
            self.showErrorWithMessage("Error", message: "Card has already been added by another user, reported for fraud!",
                                      actionHandler: {})
            return
        }
        else {
            self.viewModel?.deleteUserViewModel()
            newViewModel.updateUser()
            self.navigationController!.popViewControllerAnimated(true)
        }
    }
}