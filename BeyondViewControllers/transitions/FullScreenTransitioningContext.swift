//
//  FullScreenTransitioningContext.swift
//  BeyondViewControllers
//
//  Created by Joshua Sullivan on 12/3/16.
//  Copyright © 2016 Josh Sullivan. All rights reserved.
//

import UIKit

class FullScreenTransitioningContext: NSObject, UIViewControllerContextTransitioning {
    
    public typealias TransitionCompletion = (Bool) -> Void
    
    public var containerView: UIView
    
    public var isAnimated: Bool { return true }
    
    public var isInteractive: Bool { return false }
    
    public var transitionWasCancelled: Bool { return false }
    
    public var presentationStyle: UIModalPresentationStyle { return .custom }
    
    public var targetTransform: CGAffineTransform { return CGAffineTransform.identity }
    
    fileprivate let viewControllers: [UITransitionContextViewControllerKey : UIViewController]
    
    fileprivate let views: [UITransitionContextViewKey: UIView]
    
    fileprivate let completion: TransitionCompletion?
    
    init(from: UIViewController, to: UIViewController, container: UIView, completion: TransitionCompletion?) {
        guard from.isViewLoaded && to.isViewLoaded else {
            preconditionFailure("Both the 'from' and the 'to' view controllers must have their views loaded prior to using them in a transition.")
        }
        viewControllers = [
            UITransitionContextViewControllerKey.from : from,
            UITransitionContextViewControllerKey.to : to
        ]
        views = [
            UITransitionContextViewKey.from : from.view,
            UITransitionContextViewKey.to : to.view
        ]
        containerView = container
        self.completion = completion
        
        super.init()
    }
    
    public func completeTransition(_ didComplete: Bool) {
        completion?(didComplete)
    }
    
    public func viewController(forKey key: UITransitionContextViewControllerKey) -> UIViewController? {
        return viewControllers[key]
    }
    
    public func view(forKey key: UITransitionContextViewKey) -> UIView? {
        return views[key]
    }
    
    public func initialFrame(for vc: UIViewController) -> CGRect {
        return containerView.frame
    }
    
    public func finalFrame(for vc: UIViewController) -> CGRect {
        return containerView.frame
    }
    
// Mark: - Interactive Transition (Unused)
    
    public func updateInteractiveTransition(_ percentComplete: CGFloat) {}
    
    public func finishInteractiveTransition() {}
    
    public func cancelInteractiveTransition() {}
    
    public func pauseInteractiveTransition() {}
    
}
