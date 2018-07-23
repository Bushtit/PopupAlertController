//
//  PopupPresentationManager.swift
//
//  Copyright (c) 2016 Bushtit Lab. (https://github.com/Bushtit/)
//

import Foundation
import UIKit

final internal class PresentationManager: NSObject, UIViewControllerTransitioningDelegate {

    var transitionStyle: PopupTransitionStyle
    var interactor: InteractiveTransition

    init(transitionStyle: PopupTransitionStyle, interactor: InteractiveTransition) {
        self.transitionStyle = transitionStyle
        self.interactor = interactor
        super.init()
    }

    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let presentationController = PresentationController(presentedViewController: presented, presenting: source)
        return presentationController
    }

    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {

        var transition: TransitionAnimator
        switch transitionStyle {
        case .bounceUp:
            transition = BounceUpTransition(direction: .in)
        case .bounceDown:
            transition = BounceDownTransition(direction: .in)
        case .zoomIn:
            transition = ZoomTransition(direction: .in)
        case .fadeIn:
            transition = FadeTransition(direction: .in)
        }

        return transition
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {

        if interactor.hasStarted || interactor.shouldFinish {
            return DismissInteractiveTransition()
        }

        var transition: TransitionAnimator
        switch transitionStyle {
        case .bounceUp:
            transition = BounceUpTransition(direction: .out)
        case .bounceDown:
            transition = BounceDownTransition(direction: .out)
        case .zoomIn:
            transition = ZoomTransition(direction: .out)
        case .fadeIn:
            transition = FadeTransition(direction: .out)
        }

        return transition
    }

    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactor.hasStarted ? interactor : nil
    }
}
