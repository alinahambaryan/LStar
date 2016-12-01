//
//  Transaction.swift
//  Lendstar
//
//  Created by ALINA HAMBARYAN on 11/23/16.
//  Copyright © 2016 ALINA HAMBARYAN. All rights reserved.
//

import Foundation

class Transaction {
     let currency: String
     let executionDate: String
     let amount: Double
     let reason: String

    init(currency: String, executionDate: String,amount: Double, reason: String) {
        self.currency = currency
        self.executionDate = executionDate
        self.amount = amount
        self.reason = reason
    }
}
extension Transaction: Equatable {}

func == (left: Transaction, right: Transaction) -> Bool {
    return left.currency == right.currency
        && left.executionDate == right.executionDate
        && left.amount == right.amount
        && left.reason == right.reason
}