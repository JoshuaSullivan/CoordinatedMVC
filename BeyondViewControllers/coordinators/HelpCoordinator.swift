//
//  HelpCoordinator.swift
//  BeyondViewControllers
//
//  Created by Joshua Sullivan on 11/4/16.
//  Copyright © 2016 Josh Sullivan. All rights reserved.
//

import UIKit

class HelpCoordinator: TaskCoordinator {
    
    var task: Task { return .help }
    
    /// The actual view controller we use. This task only has 1 step/view.
    fileprivate let viewController: UIViewController
    
    var rootViewController: UIViewController {
        return viewController
    }
    
    var isModalTask: Bool { return true }
    
    weak var delegate: TaskCoordinatorDelegate?
    
    init() {
        guard let vc = UIStoryboard(name: "Help", bundle: nil).instantiateInitialViewController() as? HelpViewController else {
            preconditionFailure("Help storyboard is misconfigured.")
        }
        viewController = vc
    }
    
    func begin() {
        
    }
    
    func prepareForRemoval() {
        
    }
}
