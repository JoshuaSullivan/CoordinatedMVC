//
//  InstantTaskTransition.swift
//  BeyondViewControllers
//
//  Created by Joshua Sullivan on 12/3/16.
//  Copyright © 2016 Josh Sullivan. All rights reserved.
//

import UIKit

class InstantTaskTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.0
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
        container.addSubview(toView)
        fromView.removeFromSuperview()
        transitionContext.completeTransition(true)
    }
}
