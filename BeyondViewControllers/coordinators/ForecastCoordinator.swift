//
//  ForecastCoordinator.swift
//  BeyondViewControllers
//
//  Created by Joshua Sullivan on 11/4/16.
//  Copyright © 2016 Josh Sullivan. All rights reserved.
//

import UIKit

class ForecastCoordinator: NSObject, TaskCoordinator {
    
    // MARK: - Constants & Child Types
    
    /// This coordinator has 2 steps.
    fileprivate enum Step {
        /// The list of all forecasts.
        case summary
        
        /// The details on one particular forecast.
        case details
    }
    
    // MARK: - TaskCoordinator Properties
    
    /// This coordinator handles the forecast task.
    var task: Task { return .forecast }
    
    /// Returns the navController.
    var rootViewController: UIViewController {
        return navController
    }
        
    weak var delegate: TaskCoordinatorDelegate?
    
    // MARK: - Class-specific Properties
    
    /// The actual view controller we're using as our root.
    fileprivate let navController: UINavigationController
    
    /// The view model driving the Forecast screen.
    fileprivate let viewModel: ForecastViewModel
    
    /// The step this coordinator is currently on.
    fileprivate var currentStep: Step = .summary
    
    // MARK: - Lifecycle
    
    /// This class takes an APIClient-conforming object as init argument, allowing the
    /// easy substitution of a mock object for testing. If this class found the APIClient
    /// via a singleton accessor, there would be no way to subsitute a mock object.
    init(locationFinder: LocationFinder) {
        navController = UINavigationController()
        viewModel = ForecastViewModel(locationFinder: locationFinder)
        super.init()
        navController.delegate = self
    }
    
    /// Do any remaining setup before the coordinator's view appears on stage.
    func begin() {
        show(step: .summary)
    }
    
    /// Tear down the model.
    func prepareForRemoval() {
        viewModel.prepareForRemoval()
    }
    
    //MARK: - Flow Management
    
    /// Take all necessary actions to display the requested Step.
    fileprivate func show(step: Step) {
        switch step {
        case .summary:
            guard let vc = UIStoryboard(name: "Forecast", bundle: nil).instantiateViewController(withIdentifier: "summary") as? ForecastViewController else {
                preconditionFailure("Did not get the expected view controller type.")
            }
            vc.dataSource = viewModel
            vc.delegate = self
            navController.setViewControllers([vc], animated: true)
        case .details:
            guard let vc = UIStoryboard(name: "Forecast", bundle: nil).instantiateViewController(withIdentifier: "details") as? ForecastDetailsViewController else {
                preconditionFailure("Did not get the expected view controller type.")
            }
            vc.dataSource = viewModel
            navController.pushViewController(vc, animated: true)
        }
        currentStep = step
    }
}

extension ForecastCoordinator: ForecastViewControllerDelegate {
    /// Move to the details screen.
    func forecastViewController(_ forecastViewController: ForecastViewController, detailsFor day: ForecastDay) {
        viewModel.selectedDay = day
        show(step: .details)
    }
    
    /// Move to the help task.
    func forecastViewController(didTapHelp forecastViewController: ForecastViewController) {
        delegate?.taskCoordinator(self, changeTask: .help)
    }
}

extension ForecastCoordinator: UINavigationControllerDelegate {
    
    /// Observe pop actions to determine when the user leaves the details screen.
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == .pop {
            currentStep = .summary
        }
        return nil
    }
}
