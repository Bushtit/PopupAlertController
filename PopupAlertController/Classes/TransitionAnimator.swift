//
//  PopupTransitionAnimator.swift
//
//  Copyright (c) 2016 Bushtit Lab. (https://github.com/Bushtit/)
//

import Foundation
import UIKit

/// Base class for custom transition animations
internal class TransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {

    var to: UIViewController!
    var from: UIViewController!
    let inDuration: TimeInterval
    let outDuration: TimeInterval
    let direction: AnimationDirection

    init(inDuration: TimeInterval, outDuration: TimeInterval, direction: AnimationDirection) {
        self.inDuration = inDuration
        self.outDuration = outDuration
        self.direction = direction
        super.init()
    }

    internal func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return direction == .in ? inDuration : outDuration
    }

    internal func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        switch direction {
        case .in:
            guard let to = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to),
                let from = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) else { return }
            
            self.to = to
            self.from = from

            let container = transitionContext.containerView
            container.addSubview(to.view)
        case .out:
            guard let to = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to),
                let from = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) else { return }
            
            self.to = to
            self.from = from
        }
    }
}
