//
//  UIColor
//  LENDSTAR
//
//  Created by ALINA HAMBARYAN on 11/24/16.
//  Copyright © 2016 ALINA HAMBARYAN. All rights reserved.
//

import UIKit

public extension UIColor {

    convenience init(hex: Int) {
        self.init(hex: hex, alpha: 1)
    }

    convenience init(hex: Int, alpha: Double) {
        self.init(red: CGFloat((hex >> 16) & 0xff) / 255, green: CGFloat((hex >> 8) & 0xff) / 255, blue: CGFloat(hex & 0xff) / 255, alpha: CGFloat(alpha))
    }
}
