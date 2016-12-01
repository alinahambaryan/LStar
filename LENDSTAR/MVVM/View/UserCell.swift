//
//  UserCell.swift
//  Lendstar
//
//  Created by ALINA HAMBARYAN on 11/23/16.
//  Copyright © 2016 ALINA HAMBARYAN. All rights reserved.
//

import UIKit

class UserCell : UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var creditCardLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    
    func configureCell(user:UserViewModel) {
        self.nameLabel.text = user.name
        self.creditCardLabel.text = user.cardNumber
        self.amountLabel.text = user.balance
    }
}