//
//  FadeTransitionAnimator.swift
//  Weather
//
//  Created by Andrey Piskunov on 20.10.2022.
//

import UIKit

class FadeTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        //Destination controller
        guard let toViewController = transitionContext.viewController(forKey: .to) else {
            return
        }
        
        //Context for the animation process
        transitionContext.containerView.addSubview(toViewController.view)
        toViewController.view.alpha = 0
        let duration = self.transitionDuration(using: transitionContext)
        
        //Animation
        UIView.animate(withDuration: duration) {
            toViewController.view.alpha = 1
        } completion: { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}

