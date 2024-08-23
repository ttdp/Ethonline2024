//
//  UIViewController+Extension.swift
//  Wallet-iOS
//
//  Created by Tian Tong on 2024/8/24.
//

import UIKit

extension UIViewController {
    
    // MARK: - Add Sub Controller
    
    func addVC(_ child: UIViewController) {
        child.view.frame = view.bounds
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    func removeVC() {
        guard parent != nil else {
            return
        }
        
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
    
    // MARK: - Keyboard
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func hideKeyboardWhenSwipedAround() {
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        swipeUp.cancelsTouchesInView = false
        swipeUp.direction = .up
        view.addGestureRecognizer(swipeUp)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        swipeDown.cancelsTouchesInView = false
        swipeDown.direction = .down
        view.addGestureRecognizer(swipeDown)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // MARK: - Top View Controller
    
    func topViewController() -> UIViewController? {
        if let navigationController = self as? UINavigationController {
            return navigationController.visibleViewController
        }
        
        if let tabBarController = self as? UITabBarController {
            if let seleted = tabBarController.selectedViewController {
                return seleted.topViewController()
            }
        }
        
        if let presentedViewController = self.presentedViewController {
            return presentedViewController.topViewController()
        }
        
        return self
    }
    
}

