//
//  CreditCard.swift
//  Lendstar
//
//  Created by ALINA HAMBARYAN on 11/22/16.
//  Copyright © 2016 ALINA HAMBARYAN. All rights reserved.
//

import Foundation

class CreditCard {
    var amount : Double?
    var creditCardNumber : String?
    
    init(amount:Double,creditCardNumber:String) {
        self.amount = amount
        self.creditCardNumber = creditCardNumber
    }
}

extension CreditCard: Equatable {}

func == (left: CreditCard, right: CreditCard) -> Bool {
    return left.creditCardNumber == right.creditCardNumber
}