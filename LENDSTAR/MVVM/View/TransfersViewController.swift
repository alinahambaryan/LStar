//
//  TransfersViewController.swift
//  SampleLendstar
//
//  Created by ALINA HAMBARYAN on 11/24/16.
//  Copyright © 2016 ALINA HAMBARYAN. All rights reserved.
//

import UIKit

class TransferViewController:BaseViewController, UITextFieldDelegate {
    @IBOutlet weak var toTextFIeld: UITextField!
    @IBOutlet weak var fromTextField: UITextField!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var reasonTextField: UITextField!
    
    @IBOutlet weak var payButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func makeTransfer(sender: AnyObject) {
        let transferViewModel = TransferViewModel(fromUserName: fromTextField.text!, toUserName: toTextFIeld.text!)
        
        if (transferViewModel.fromUserViewModel == transferViewModel.toUserViewModel ) {
            self.showErrorWithMessage("Error", message: "users cannot pay themselves", actionHandler: {})
            return
        }
        
        if (transferViewModel.fromUserViewModel == nil) {
            self.showErrorWithMessage("Error", message: "Incorrect FROM", actionHandler: {})
            return
        } else if (transferViewModel.toUserViewModel == nil) {
            self.showErrorWithMessage("Error", message: "Incorrect TO", actionHandler: {})
            return
        } else  if let amount = amountTextField.text {
            if amount.isEmpty {
                self.showErrorWithMessage("Error", message: "No amount specified", actionHandler: {})
                return
               }else {
                if (Double((transferViewModel.fromUserViewModel?.user.creditCard?.amount)!) - Double(amount)! <= 0) {
                    self.showErrorWithMessage("Error", message: "Not enoght funds", actionHandler: {})
                    return
                }
                else if (Double(amount) < 1) {
                    self.showErrorWithMessage("Warning", message: "Minimum transfer amount is 1€", actionHandler: {})
                    return
                }
                else {
                    self.reasonTextField .resignFirstResponder()
                    transferViewModel.reason = reasonTextField.text!
                    transferViewModel.makeTransfer(Double(amount)!)
                    self.showErrorWithMessage("Success", message: "Transfered successfully", actionHandler: {
                        self.cleanTextFields()
                    })
                }
            }
        }
    }
    
    func cleanTextFields(){
        self.toTextFIeld.text = ""
        self.fromTextField.text = ""
        self.amountTextField.text = ""
        self.reasonTextField.text = ""
    }
}