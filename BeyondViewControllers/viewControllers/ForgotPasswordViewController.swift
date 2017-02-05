//
//  ForgotPasswordViewController.swift
//  BeyondViewControllers
//
//  Created by Joshua Sullivan on 2/4/17.
//  Copyright © 2017 Josh Sullivan. All rights reserved.
//

import UIKit

protocol ForgotPasswordViewControllerDelegate: class {
    func forgotPasswordController(resetPassword fpController: ForgotPasswordViewController, for email: String)
}

class ForgotPasswordViewController: UIViewController {

    weak var delegate: ForgotPasswordViewControllerDelegate?
    
    @IBOutlet weak var emailField: UITextField! {
        didSet {
            emailField.delegate = self
        }
    }
    
    @IBOutlet weak var resetButton: UIButton!
        
    @IBAction fileprivate func resetTapped(sender: Any?) {
        doPasswordReset()
    }
    
    func doPasswordReset() {
        let email = emailField.text ?? ""
        guard !email.isEmpty else {
            emailField.set(isError: true)
            return
        }
        emailField.set(isError: false)
        delegate?.forgotPasswordController(resetPassword: self, for: email)
    }
}

extension ForgotPasswordViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        doPasswordReset()
        return false
    }
}
