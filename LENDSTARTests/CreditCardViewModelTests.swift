//
//  CreditCardViewModelTests.swift
//  SampleLendstar
//
//  Created by ALINA HAMBARYAN on 11/23/16.
//  Copyright © 2016 ALINA HAMBARYAN. All rights reserved.
//

import XCTest
@testable import LENDSTAR

class CreditCardViewModelTests: XCTestCase {
    var validViewModel: CreditCardViewModel!
    var invalidViewModel: CreditCardViewModel!
    
    override func setUp() {
        super.setUp()
        
        let validCreditCard = CreditCard(amount: 200, creditCardNumber: "4111111111111111")
        let notValidCreditCard  = CreditCard(amount: 200,creditCardNumber:"4111111111111110")
        
        validViewModel = CreditCardViewModel(card: validCreditCard)
        invalidViewModel = CreditCardViewModel(card: notValidCreditCard)
    }
    
    func testCreditCardNumber() {
        XCTAssertTrue(self.validViewModel.cardNumberIsValid)
        XCTAssertFalse(self.invalidViewModel.cardNumberIsValid)
    }
}