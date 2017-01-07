//
//  AppCoordinator.swift
//  BeyondViewControllers
//
//  Created by Joshua Sullivan on 11/4/16.
//  Copyright © 2016 Josh Sullivan. All rights reserved.
//

import UIKit

class AppCooordinator {
    
    let apiService: APIClientService
    let locationService: LocationService
    
    let rootViewController: UIViewController?
    
    /// Target view to place all content within.
    let contentContainer: UIView?
    
    /// The currently active task. We always start with .startup.
    var currentTask: Task = .startup
    
    var currentCoordinator: TaskCoordinator? = nil
    
    init(rootViewController: UIViewController?, startingTask: Task? = nil) {
        
        self.rootViewController = rootViewController
        
        // Create the services.
        apiService = APIClientService()
        locationService = LocationService()
        
        // Set up the content container, if needed.
        if let rvc = rootViewController {
            let contentView = UIView(frame: rvc.view.bounds)
            contentContainer = contentView
            add(view: contentView, to: rvc.view)
        } else {
            contentContainer = nil
        }
        
        // Start the process.
        if let task = startingTask {
            begin(task)
        } else {
            begin(.forecast)
        }
    }
    
    fileprivate func begin(_ task: Task, allowTaskRestart: Bool = false) {
        guard task != .startup else {
            debugPrint("It is not valid to attempt to begin the .startup task.")
            return
        }
        guard task != currentTask else {
            if allowTaskRestart {
                currentCoordinator?.restart()
            }
            return
        }
        
        let nextCoordinator = coordinator(for: task)
        transition(from: currentCoordinator, to: nextCoordinator)
        currentCoordinator = nextCoordinator
    }
    
    fileprivate func coordinator(for task: Task) -> TaskCoordinator {
        switch task {
        case .forecast:
            return ForecastCoordinator(apiClient: apiService, locationFinder: locationService)
        case .help:
            return HelpCoordinator()
        default:
            preconditionFailure("Unknown or invalid task \(task).")
        }
    }
    
    fileprivate func transition(from fromCoordinator: TaskCoordinator?, to toCoordinator: TaskCoordinator, animated: Bool = true, completion:(() -> Void)? = nil) {
        // A full implementation might choose to introduce specialized animated transitions.
        // Prepare the destination Task Coordinator for use.
        toCoordinator.begin()
        
        guard let from = fromCoordinator else {
            // This must be the first coordinator. Just parent it and be done.
            currentCoordinator = toCoordinator
            parent(viewController:toCoordinator.rootViewController, inView: contentContainer)
            return
        }
        
        // Replace the current task with the new one.
        from.prepareForRemoval()
        
        // Update the reference to the current coordinator.
        currentCoordinator = toCoordinator
        
        guard let rvc = rootViewController, let contentContainer = contentContainer  else {
            debugPrint("The App Coordinator is not set up with a root view controller.")
            return
        }
        
        let fromVC = from.rootViewController
        let toVC = toCoordinator.rootViewController
        
        rvc.addChildViewController(toVC)
        
        let animation: UIViewControllerAnimatedTransitioning
        if animated {
            animation = animator(forTransitionFrom: from.task, to: toCoordinator.task)
        } else {
            animation = InstantTaskTransition()
        }
        
        let context = FullScreenTransitioningContext(from: fromVC, to: toVC, container: contentContainer) {
            finished in
            self.unparent(fromVC)
            
            toVC.didMove(toParentViewController: rvc)
            animation.animationEnded?(finished)
            
            if let completion = completion {
                completion()
            }
        }
        animation.animateTransition(using: context)
    }
    
    /// Allows a unique animator to be provided for various task-to-task transitions.
    fileprivate func animator(forTransitionFrom from: Task, to: Task) -> UIViewControllerAnimatedTransitioning {
        switch (from, to) {
        default:
            return GenericTaskTransition()
        }
    }
    
    // MARK: - Helper Methods
    
    fileprivate func parent(viewController vc: UIViewController, inView: UIView? = nil, useAutoLayout: Bool = false) {
        
        guard
            let rootViewController = rootViewController,
            let contentContainer = contentContainer
            else { return }
        
        // Ensure that the containing view exists.
        let view = inView ?? contentContainer
        
        // Parent the view controller.
        rootViewController.addChildViewController(vc)
        
        // Ensure that the child vc had a view.
        guard let subView = vc.view else {
            preconditionFailure("The child view controller had no view!? Gnarly.")
        }
        
        subView.translatesAutoresizingMaskIntoConstraints = !useAutoLayout
        subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        subView.frame = view.frame
        
        // Add the child vc's view.
        view.addSubview(subView)
        
        // Complete the vc parenting.
        vc.didMove(toParentViewController: rootViewController)
    }
    
    fileprivate func unparent(_ vc: UIViewController) {
        // Standard view controller custom containment implementation.
        vc.willMove(toParentViewController: nil)
        vc.view?.removeFromSuperview()
        vc.removeFromParentViewController()
    }
    
    /// Add `view` as a child of `parentView` with an equal size (minus insets, if any).
    fileprivate func add(view: UIView, to parentView: UIView, with insets: UIEdgeInsets = UIEdgeInsets.zero) {
        parentView.addSubview(view)
        view.topAnchor.constraint(equalTo: parentView.topAnchor, constant: insets.top).isActive = true
        view.leftAnchor.constraint(equalTo: parentView.leftAnchor, constant: insets.left).isActive = true
        view.rightAnchor.constraint(equalTo: parentView.rightAnchor, constant: insets.right).isActive = true
        view.bottomAnchor.constraint(equalTo: parentView.bottomAnchor, constant: insets.bottom).isActive = true
    }
    
}
