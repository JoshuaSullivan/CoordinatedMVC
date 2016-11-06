//
//  TaskCoordinator.swift
//  BeyondViewControllers
//
//  Created by Joshua Sullivan on 11/4/16.
//  Copyright © 2016 Josh Sullivan. All rights reserved.
//

import UIKit

public protocol TaskCoordinator {
    /// The `Task` that this coordinator aims to coordinate.
    var task: Task { get }
    
    /// The view controller which the task coordinator will use to present its managed screens. Usually an instance of `UINavigationController`.
    var rootViewController: UIViewController { get }
    
    /// Determines whether the TaskCoordinator expects to be presented modally.
    /// Modal tasks can "interrupt" other tasks to complete an immediately pressing
    /// app concern, such as presenting a login screen when authentication fails or
    /// presenting a Shopping Cart view when the user taps an appropriate button.
    var isModalTask: Bool { get }
    
    /// The task coordinator's delegate.
    weak var delegate: TaskCoordinatorDelegate? { get set }
    
    /// Instructs the TaskCoordinator to begin its task.
    /// Typically, this would include preparing its rootViewController to be presented on screen.
    /// - Note: When this method is called, the coordinator's root view controller won't be parented and its view won't be part of the view hierarchy. It is important not to take any actions which would rely on these factors being set.
    func begin()
    
    /// Called immediately before the task is removed from the view stack.
    func prepareForRemoval()
}

/// A `TaskCoordinatorDelegate` receives notifications that a `TaskCoordinator` has completed or that a different `TaskCoordinator` is needed to continue the user's flow through the app.
public protocol TaskCoordinatorDelegate: class {
    
    /// The task coordinator concluded successfully.
    func taskCoordinator(finished taskCoordinator: TaskCoordinator)
    
    /// The task coordinator was canceled (used by modal coordinators)
    func taskCoordinator(canceled taskCoordinator: TaskCoordinator)
    
    /// The task coordinator is reaching out for another coordinator to continue coordination duties.
    ///
    /// - Parameter taskCoordinator: The `TaskCoordinator` reaching out for assistance.
    /// - Parameter changeTask: The `Task` that is required to continue the user flow.
    func taskCoordinator(_ taskCoordinator: TaskCoordinator, changeTask newTask: Task)
    
}

