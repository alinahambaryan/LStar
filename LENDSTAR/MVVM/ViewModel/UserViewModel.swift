//
//  UserViewModel.swift
//  Lendstar
//
//  Created by ALINA HAMBARYAN on 11/23/16.
//  Copyright © 2016 ALINA HAMBARYAN. All rights reserved.
//

import Foundation

class UserViewModel {
    let name : String
    let cardNumber : String
    var balance : String
    let userNameIsValid : Bool
    let cardNumberIsValid : Bool

    let user:User
    
    init (user:User) {
        self.user = user
        self.name = user.name
        self.cardNumber = user.creditCard!.creditCardNumber! != "" ? user.creditCard!.creditCardNumber! : ""
        self.balance = String(format:"€%.1f", (user.creditCard?.amount)!)
        self.userNameIsValid = user.name.characters.count > 3 && user.name.characters.count < 15
        
        let creditCardViewModel = CreditCardViewModel(card: user.creditCard!)
        self.cardNumberIsValid = creditCardViewModel.cardNumberIsValid
    }
    
    func userWithNameHasValidCard()-> Bool{
       let result =  DataProvider.sharedInstance.userViewModels.filter{$0.cardNumberIsValid && $0.name == self.name}
        return !result.isEmpty
    }
    
    func isUserNameValid (name:String) -> Bool {
        return name.characters.count > 3 && name.characters.count < 15
    }
    
    func updateUser() {
        let result = DataProvider.sharedInstance.userViewModels.filter { $0 == self}
        if result.isEmpty {
            DataProvider.sharedInstance.userViewModels.insert(self, atIndex: DataProvider.sharedInstance.userViewModels.startIndex)
        } 
    }
    
    func userExistsInsystem(userViewModel:UserViewModel) -> Bool {
        let results = DataProvider.sharedInstance.userViewModels.filter{$0 == userViewModel}
        return results.count > 0
    }
    
    func deleteUserViewModel() {
        DataProvider.sharedInstance.userViewModels =  DataProvider.sharedInstance.userViewModels.filter{$0.name != self.name}
    }
    
    func isCreditCardAlreadyExistsInSystem()-> Bool {
        let results = DataProvider.sharedInstance.userViewModels.filter { $0.user.creditCard?.creditCardNumber == self.cardNumber }
        return results.count > 0
    }
}

extension UserViewModel: Equatable {}

func == (left: UserViewModel, right: UserViewModel) -> Bool {
    return left.name == right.name && left.name != ""
        && left.cardNumber == right.cardNumber && left.cardNumber != ""
}