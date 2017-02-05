//
//  LoginViewController.swift
//  BeyondViewControllers
//
//  Created by Joshua Sullivan on 2/4/17.
//  Copyright © 2017 Josh Sullivan. All rights reserved.
//

import UIKit

protocol LoginViewControllerDelegate: class {
    
    /// Do a sign in with the provided email and password.
    /// - Note: In a real app, you'd want a completion closure to handle login failures.
    ///         However, the demo app will never fail, so we don't need it.
    func loginController(login loginController: LoginViewController, email: String, password: String)
    
    /// The user tapped forgot password button.
    func loginController(forgotPassword loginController: LoginViewController)
}


/// This view controller has no external data requirements, so it doesn't have a DataSource protocol.
class LoginViewController: UIViewController {
    
    weak var delegate: LoginViewControllerDelegate?
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @discardableResult fileprivate func validateFields() -> Bool {
        let email = emailField.text ?? ""
        let password = passwordField.text ?? ""
        let emailIsValid = !email.isEmpty
        let passwordIsValid = !password.isEmpty
        emailField.set(isError: !emailIsValid)
        passwordField.set(isError: !passwordIsValid)
        guard emailIsValid, passwordIsValid else {
            return false
        }
        return true
    }
    
    fileprivate func attemptLogin() {
        guard validateFields() else { return }
        let email = emailField.text ?? ""
        let password = passwordField.text ?? ""
        delegate?.loginController(login: self, email: email, password: password)
    }
    
    // MARK: - IBActions
    
    @IBAction fileprivate func signInTapped(sender: Any?) {
        attemptLogin()
    }
    
    @IBAction fileprivate func forgotPasswordTapped(sender: Any?) {
        delegate?.loginController(forgotPassword: self)
    }
}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailField {
            passwordField.becomeFirstResponder()
        } else {
            passwordField.resignFirstResponder()
            attemptLogin()
        }
        return false
    }
}
