//
//  DataProvider.swift
//  Lendstar
//
//  Created by ALINA HAMBARYAN on 11/22/16.
//  Copyright © 2016 ALINA HAMBARYAN. All rights reserved.
//

import Foundation

class DataProvider {
    static let sharedInstance = DataProvider()
    
    lazy var userViewModels: [UserViewModel] = {
        return [];
    }()

}