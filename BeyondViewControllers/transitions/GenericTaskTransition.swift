//
//  GenericTaskTransition.swift
//  BeyondViewControllers
//
//  Created by Joshua Sullivan on 12/3/16.
//  Copyright © 2016 Josh Sullivan. All rights reserved.
//

import UIKit

/// A super-simple transition that simply cross-fades between view controllers.
/// Feel free to make something more elaborate if your heart tells you it is the right thing to do.
class GenericTaskTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.25
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let container = transitionContext.containerView
        guard
            let fromView = transitionContext.view(forKey: .from),
            let toView = transitionContext.view(forKey: .to)
            else {
                assertionFailure("This animation only works with a from and to view controller.")
                transitionContext.completeTransition(false)
                return
        }
        
        toView.translatesAutoresizingMaskIntoConstraints = true
        toView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        toView.frame = container.bounds
        toView.alpha = 0.0
        container.addSubview(toView)
        let duration = transitionDuration(using: transitionContext)
        UIView.animate(
            withDuration: duration,
            animations: {
                toView.alpha = 1.0
            },
            completion: {
                finished in
                if finished {
                    fromView.removeFromSuperview()
                } else {
                    toView.removeFromSuperview()
                }
                transitionContext.completeTransition(finished)
        })
    }
}
