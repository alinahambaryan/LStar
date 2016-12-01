//
//  CreditCardViewModel.swift
//  Lendstar
//
//  Created by ALINA HAMBARYAN on 11/23/16.
//  Copyright © 2016 ALINA HAMBARYAN. All rights reserved.
//

import Foundation

class CreditCardViewModel {
    let cardNumber : String
    var balance : String
    let cardNumberIsValid : Bool
    let card:CreditCard
    
    init (card:CreditCard) {
        self.card = card
        self.cardNumber = card.creditCardNumber!
        self.balance = String(card.amount)
        self.cardNumberIsValid = CreditCardViewModel.luhnCheck(card.creditCardNumber!) && card.creditCardNumber != ""
    }
    
    static func luhnCheck(cardNumber: String) -> Bool {
        var sum = 0
        let reversedCharacters = cardNumber.characters.reverse().map { String($0) }
        for (idx, element) in reversedCharacters.enumerate() {
            guard let digit = Int(element) else { return false }
            switch ((idx % 2 == 1), digit) {
            case (true, 9): sum += 9
            case (true, 0...8): sum += (digit * 2) % 9
            default: sum += digit
            }
        }
        return sum % 10 == 0
    }
}