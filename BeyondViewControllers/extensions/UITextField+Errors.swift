//
//  UITextField+Errors.swift
//  BeyondViewControllers
//
//  Created by Joshua Sullivan on 2/4/17.
//  Copyright © 2017 Josh Sullivan. All rights reserved.
//

import UIKit

private let errorColor: CGColor = UIColor(colorLiteralRed: 0.8, green: 0.0, blue: 0.0, alpha: 1.0).cgColor

extension UITextField {
    func set(isError: Bool) {
        self.layer.borderColor = isError ? errorColor : UIColor.lightGray.cgColor
    }
}
