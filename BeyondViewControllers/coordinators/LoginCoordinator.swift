//
//  LoginCoordinator.swift
//  BeyondViewControllers
//
//  Created by Joshua Sullivan on 11/4/16.
//  Copyright © 2016 Josh Sullivan. All rights reserved.
//

import UIKit

class LoginCoordinator: TaskCoordinator {
    
    var task: Task { return .login }
    
    var rootViewController: UIViewController {
        return navController
    }
    
    /// The view controller we're using as our root view controller.
    fileprivate var navController: UINavigationController
    
    var isModalTask: Bool {
        return false
    }
    
    weak var delegate: TaskCoordinatorDelegate?
    
    fileprivate let apiClient: APIClient
    
    /// This coordinator takes the API Client Service as a dependency.
    init(apiClient: APIClient) {
        navController = UINavigationController()
        self.apiClient = apiClient
    }
    
    func begin() {
        // Do some setup stuff here.
    }
    
    func prepareForRemoval() {
        // Do tear-down stuff here.
    }
    
}


