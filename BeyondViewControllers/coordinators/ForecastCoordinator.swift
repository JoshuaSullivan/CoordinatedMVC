//
//  ForecastCoordinator.swift
//  BeyondViewControllers
//
//  Created by Joshua Sullivan on 11/4/16.
//  Copyright © 2016 Josh Sullivan. All rights reserved.
//

import UIKit

class ForecastCoordinator: TaskCoordinator {
    
    // MARK: - Constants & Child Types
    
    fileprivate enum Step {
        case summary
        case details
    }
    
    // MARK: - TaskCoordinator Properties
    
    /// This coordinator handles the forecast task.
    var task: Task { return .forecast }
    
    var rootViewController: UIViewController {
        return navController
    }
    
    var isModalTask: Bool { return false }
    
    weak var delegate: TaskCoordinatorDelegate?
    
    // MARK: - Class-specific Properties
    
    /// The actual view controller we're using as our root.
    fileprivate let navController: UINavigationController
    
    /// Hold a reference to the APIClient provided at init.
    fileprivate let apiClient: APIClient
    
    fileprivate let viewModel: ForecastViewModel
    
    // MARK: - Lifecycle
    
    /// This class takes an APIClient-conforming object as init argument, allowing the
    /// easy substitution of a mock object for testing. If this class found the APIClient
    /// via a singleton accessor, there would be no way to subsitute a mock object.
    init(apiClient: APIClient) {
        navController = UINavigationController()
        self.apiClient = apiClient
        viewModel = ForecastViewModel(apiClient: apiClient)
    }
    
    /// Do any remaining setup before the coordinator's view appears on stage.
    func begin() {
        
    }
    
    func prepareForRemoval() {
        viewModel.prepareForRemoval()
    }
    
}
