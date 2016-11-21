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
    
    let rootViewController: UIViewController?
    
    /// Target view to place all content within.
    let contentContainer: UIView?
    
    /// The currently active task. We always start with .startup.
    var currentTask: Task = .startup
    
    var currentTaskCoordinator: TaskCoordinator? = nil
    
    init(rootViewController: UIViewController?, startingTask: Task? = nil) {
        
        self.rootViewController = rootViewController
        
        // Create the services.
        apiService = APIClientService()
        
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
                currentTaskCoordinator?.restart()
            }
            return
        }
        
        let nextCoordinator = coordinator(for: task)
        transition(from: currentTaskCoordinator, to: nextCoordinator)
        currentTaskCoordinator = nextCoordinator
    }
    
    fileprivate func coordinator(for task: Task) -> TaskCoordinator {
        switch task {
        case .forecast:
            return ForecastCoordinator(apiClient: apiService)
        case .help:
            return HelpCoordinator()
        default:
            preconditionFailure("Unknown or invalid task \(task).")
        }
    }
    
    fileprivate func transition(from fromTask: TaskCoordinator?, to toTask: TaskCoordinator, animated: Bool = true) {
        // A full implementation might choose to introduce specialized animated transitions.
    }
    
// MARK: - Helper Methods
    
    /// Add `view` as a child of `parentView` with an equal size (minus insets, if any).
    fileprivate func add(view: UIView, to parentView: UIView, with insets: UIEdgeInsets = UIEdgeInsets.zero) {
        parentView.addSubview(view)
        view.topAnchor.constraint(equalTo: parentView.topAnchor, constant: insets.top).isActive = true
        view.leftAnchor.constraint(equalTo: parentView.leftAnchor, constant: insets.left).isActive = true
        view.rightAnchor.constraint(equalTo: parentView.rightAnchor, constant: insets.right).isActive = true
        view.bottomAnchor.constraint(equalTo: parentView.bottomAnchor, constant: insets.bottom).isActive = true
    }
    
}
