//
//  UserViewModelTests.swift
//  SampleLendstar
//
//  Created by ALINA HAMBARYAN on 11/23/16.
//  Copyright © 2016 ALINA HAMBARYAN. All rights reserved.
//

import XCTest
@testable import LENDSTAR

class UserViewModelTests: XCTestCase {
    var validViewModel: UserViewModel!
    var invalidViewModel: UserViewModel!

    override func setUp() {
        super.setUp()
        
        let validUser = User(name: "Alina",creditCard: CreditCard(amount: 200,creditCardNumber:"4111111111111111"))
        let notValidUser = User(name: "Ali",creditCard: CreditCard(amount: 200,creditCardNumber:"4111111111111111"))

        validViewModel = UserViewModel(user: validUser)
        invalidViewModel = UserViewModel(user: notValidUser)
    }
    
    func testUserName() {
        XCTAssertTrue(self.validViewModel.userNameIsValid)
        XCTAssertFalse(self.invalidViewModel.userNameIsValid)
    }
}
