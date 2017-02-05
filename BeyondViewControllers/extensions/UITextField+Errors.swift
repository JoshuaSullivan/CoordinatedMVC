//
//  UITextField+Errors.swift
//  BeyondViewControllers
//
//  Created by Joshua Sullivan on 2/4/17.
//  Copyright © 2017 Josh Sullivan. All rights reserved.
//

import UIKit

private let errorColor: UIColor = UIColor(colorLiteralRed: 0.8, green: 0.0, blue: 0.0, alpha: 0.2)

extension UITextField {
    func set(isError: Bool) {
        self.backgroundColor = isError ? errorColor : .clear
    }
}
