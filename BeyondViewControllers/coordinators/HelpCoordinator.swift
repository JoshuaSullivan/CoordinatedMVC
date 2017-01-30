//
//  HelpCoordinator.swift
//  BeyondViewControllers
//
//  Created by Joshua Sullivan on 11/4/16.
//  Copyright © 2016 Josh Sullivan. All rights reserved.
//

import UIKit

/// The help coordinator is simpler than the Forecast coordinator: it only has one screen to manage,
/// so we're not bothering to define a Steps enum.
class HelpCoordinator: TaskCoordinator {
    
    var task: Task { return .help }
    
    fileprivate let navController: UINavigationController
    
    var rootViewController: UIViewController {
        return navController
    }
        
    weak var delegate: TaskCoordinatorDelegate?
    
    init() {
        guard let vc = UIStoryboard(name: "Help", bundle: nil).instantiateInitialViewController() as? HelpViewController else {
            preconditionFailure("Help storyboard is misconfigured.")
        }
        navController = UINavigationController(rootViewController: vc)
        vc.delegate = self
        
    }
    
    /// This class has no setup or teardown, so we're just providing empty implementations.
    func begin() {}
    
    /// This class has no setup or teardown, so we're just providing empty implementations.
    func prepareForRemoval() {}
}

extension HelpCoordinator: HelpViewControllerDelegate {
    /// Launch my blog.
    func helpViewController(didTapBlog helpController: HelpViewController) {
        debugPrint("Launch blog.")
        let app = UIApplication.shared
        guard let url = URL(string: "http://www.chibicode.org/"), app.canOpenURL(url) else {
            debugPrint("Can't open blog.")
            return
        }
        if #available(iOS 10.0, *) {
            app.open(url, options: [:], completionHandler: nil)
        } else {
            app.openURL(url)
        }
    }
    
    /// Launch my twitter account.
    func helpViewController(didTapTwitter helpController: HelpViewController) {
        debugPrint("Launch twitter.")
        let app = UIApplication.shared
        guard let url = URL(string: "https://twiter.com/ChibiJosh"), app.canOpenURL(url) else {
            debugPrint("Can't open twitter.")
            return
        }
        if #available(iOS 10.0, *) {
            app.open(url, options: [:], completionHandler: nil)
        } else {
            app.openURL(url)
        }
    }
    
    /// Help is done.
    func helpViewController(didTapDone helpController: HelpViewController) {
        delegate?.taskCoordinator(finished: self)
    }
}
