//
//  LoginCoordinator.swift
//  BeyondViewControllers
//
//  Created by Joshua Sullivan on 2/4/17.
//  Copyright © 2017 Josh Sullivan. All rights reserved.
//

import UIKit

class LoginCoordinator: TaskCoordinator {
    
    enum Step {
        case login
        case forgotPassword
        
        var storyboard: UIStoryboard {
            return UIStoryboard(name: "Login", bundle: nil)
        }
        
        var storyboardIdentifier: String {
            switch self {
            case .login:
                return "login"
            case .forgotPassword:
                return "forgotPassword"
            }
        }
    }
    
    var task: Task { return .login }
    
    private let navController: UINavigationController
    
    var rootViewController: UIViewController {
        return navController
    }
    
    var delegate: TaskCoordinatorDelegate?
    
    var currentStep: Step? = nil
    
    func begin() {
        show(step: .login)
    }
    
    func restart() {
        show(step: .login)
    }
    
    func prepareForRemoval() {
        // Nothing.
    }
    
    fileprivate func show(step: Step) {
        guard currentStep != nil else {
            let vc = viewController(for: step)
            navController.setViewControllers([vc], animated: false)
            return
        }
        switch step {
        case .login:
            navController.popToRootViewController(animated: true)
        case .forgotPassword:
            let vc = viewController(for: .forgotPassword)
            navController.pushViewController(vc, animated: true)
        }
    }
    
    fileprivate func viewController(for step: Step) -> UIViewController {
        let viewController = step.storyboard.instantiateViewController(withIdentifier: step.storyboardIdentifier)
        switch step {
        case .login:
            guard let vc = viewController as? LoginViewController else {
                assertionFailure("Incorrect storyboard configuration.")
                break
            }
            vc.delegate = self
        case .forgotPassword:
            guard let vc = viewController as? ForgotPasswordViewController else {
                assertionFailure("Incorrect storyboard configuration.")
                break
            }
            vc.delegate = self
        }
        return viewController
    }
}

extension LoginCoordinator: LoginViewControllerDelegate {
    func loginController(login loginController: LoginViewController, email: String, password: String) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { 
            self.delegate?.taskCoordinator(finished: self)
        }
    }
    
    func loginController(forgotPassword loginController: LoginViewController) {
        show(step: .forgotPassword)
    }
}

extension LoginCoordinator: ForgotPasswordViewControllerDelegate {
    func forgotPasswordController(resetPassword fpController: ForgotPasswordViewController, for email: String) {
        let alert = UIAlertController(title: "Email Sent", message: "We've sent an email to the provided address with instructions about how to reset your password. (Not really!)", preferredStyle: .alert)
        let btn = UIAlertAction(title: "Okay", style: .cancel) {
            action in
            fpController.dismiss(animated: true, completion: { 
                self.show(step: .login)
            })
        }
        alert.addAction(btn)
        fpController.present(alert, animated: true, completion: nil)
    }
}
