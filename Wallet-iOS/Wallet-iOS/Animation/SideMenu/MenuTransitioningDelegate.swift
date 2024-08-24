//
//  MenuTransitioningDelegate.swift
//  Wallet-iOS
//
//  Created by Tian Tong on 2024/8/24.
//

import UIKit

/**
 Delegate of menu transitioning actions.
 */
final class MenuTransitioningDelegate: NSObject {

    let interactiveTransition: MenuInteractiveTransition

    public var currentItemOptions = SideMenuItemOptions() {
        didSet {
            interactiveTransition.currentItemOptions = currentItemOptions
        }
    }

    init(interactiveTransition: MenuInteractiveTransition) {
        self.interactiveTransition = interactiveTransition
    }
}

extension MenuTransitioningDelegate: UIViewControllerTransitioningDelegate {

    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        interactiveTransition.present = true
        return interactiveTransition
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        interactiveTransition.present = false
        return interactiveTransition
    }

    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactiveTransition.interactionInProgress ? interactiveTransition : nil
    }

    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactiveTransition.interactionInProgress ? interactiveTransition : nil
    }
}
