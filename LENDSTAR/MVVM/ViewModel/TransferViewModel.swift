//
//  TransferViewModel.swift
//  SampleLendstar
//
//  Created by ALINA HAMBARYAN on 11/24/16.
//  Copyright © 2016 ALINA HAMBARYAN. All rights reserved.
//

import Foundation
import UIKit

let mySpecialNotificationKey = "AmountTransfered"

class TransferViewModel {

    var fromUserViewModel: UserViewModel?
    let toUserViewModel: UserViewModel?
   
    var reason :  String?
    let fromUserName:String
    let toUserName:String
    
    init(fromUserName:String, toUserName:String) {
        self.fromUserViewModel = TransferViewModel.getViewModelByName(fromUserName)
        self.toUserViewModel = TransferViewModel.getViewModelByName(toUserName)
        self.fromUserName = fromUserName
        self.toUserName = toUserName
        self.reason = "Empty reason payment"
    }

    static func getViewModelByName(name:String) -> UserViewModel? {
        let results = DataProvider.sharedInstance.userViewModels.filter{$0.name == name && !$0.cardNumber.isEmpty}
        return results.first
    }
    
    func makeTransfer(transferAmount:Double){
        let from = DataProvider.sharedInstance.userViewModels.filter{$0 == fromUserViewModel}
        let to = DataProvider.sharedInstance.userViewModels.filter{$0 == toUserViewModel}

        if (!from.isEmpty) {
            from.first!.user.creditCard?.amount = (fromUserViewModel?.user.creditCard?.amount)! - transferAmount
            from.first!.balance = String(format:"€%.1f", (from.first!.user.creditCard?.amount)!)
            
            var details = "You paid " + to.first!.user.name + " " + String(format:"€%.1f", (transferAmount)) + " for "
            let reason =  (self.reason!.isEmpty) ? "unspecified" : self.reason!
            details += reason

            let transaction = Transaction(currency: "EUR", executionDate: "", amount: (transferAmount), reason: details)
            if from.first!.user.transactions != nil {
                from.first!.user.transactions!.insert(transaction, atIndex: (from.first!.user.transactions?.startIndex)!)
            } else {
                from.first!.user.transactions = [transaction]
            }
        }
        
        if (!to.isEmpty) {
            to.first!.user.creditCard?.amount = (to.first!.user.creditCard?.amount)! + transferAmount
            to.first!.balance = String(format:"€%.1f", (to.first!.user.creditCard?.amount)!)
            var details = from.first!.user.name + " paid you " + String(format:"€%.1f", (transferAmount)) + " for "
            let reason =  (self.reason!.isEmpty) ? "unspecified" : self.reason!
            details += reason
           
            let transaction = Transaction(currency: "EUR", executionDate: "", amount: (transferAmount), reason: details)
            if to.first!.user.transactions != nil {
                to.first!.user.transactions?.insert(transaction, atIndex: (to.first!.user.transactions?.startIndex)!)
            } else {
                to.first!.user.transactions = [transaction]
            }
        }
        NSNotificationCenter.defaultCenter().postNotificationName("TransferMade", object: nil,userInfo:nil)
    }
}

extension TransferViewModel: Equatable {}

func == (left: TransferViewModel, right: TransferViewModel) -> Bool {
    return left.fromUserViewModel == right.fromUserViewModel
        && left.toUserViewModel == right.toUserViewModel
}