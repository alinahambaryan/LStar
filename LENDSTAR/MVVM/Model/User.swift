//
//  User.swift
//  Lendstar
//
//  Created by ALINA HAMBARYAN on 11/22/16.
//  Copyright © 2016 ALINA HAMBARYAN. All rights reserved.
//

import Foundation

class User {
    var name : String
    var creditCard : CreditCard?
    var transactions : [Transaction]?
    
    init (name: String, creditCard:CreditCard) {
        self.name = name
        self.creditCard = creditCard
    }
    
    func setTransactions (transactions:[Transaction]) {
        self.transactions = transactions
    }
}

extension User: Equatable {}

func == (left: User, right: User) -> Bool {
    return left.name == right.name
        && left.creditCard == right.creditCard
}