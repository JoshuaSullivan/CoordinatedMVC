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
    
    /// The view model driving the Forecast screen.
    fileprivate let viewModel: ForecastViewModel
    
    // MARK: - Lifecycle
    
    /// This class takes an APIClient-conforming object as init argument, allowing the
    /// easy substitution of a mock object for testing. If this class found the APIClient
    /// via a singleton accessor, there would be no way to subsitute a mock object.
    init(apiClient: APIClient, locationFinder: LocationFinder) {
        navController = UINavigationController()
        viewModel = ForecastViewModel(apiClient: apiClient, locationFinder: locationFinder)
    }
    
    /// Do any remaining setup before the coordinator's view appears on stage.
    func begin() {
        show(step: .summary)
    }
    
    func prepareForRemoval() {
        viewModel.prepareForRemoval()
    }
    
    //MARK: - Flow Management
    
    fileprivate func show(step: Step) {
        switch step {
        case .summary:
            let vc = UIStoryboard(name: "Forecast", bundle: nil).instantiateViewController(withIdentifier: "summary")
            navController.setViewControllers([vc], animated: true)
        case .details:
            let vc = UIStoryboard(name: "Forecast", bundle: nil).instantiateViewController(withIdentifier: "details")
            navController.pushViewController(vc, animated: true)
        }
        
    }
    
}
