//
//  SideMenuItemContent.swift
//  Wallet-iOS
//
//  Created by Tian Tong on 2024/8/24.
//

import UIKit

/**
 The protocol to indicate item of side menu. Every menu item should adopt this protocol.
 */
public protocol SideMenuItemContent {

    /**
     Shows left side menu.
     */
    func showSideMenu()
}

/**
 The extension of SideMenuItemContent protocol implementing `showSideMenu()` method for UIViewController class.
 */
extension SideMenuItemContent where Self: UIViewController {

    public func showSideMenu() {
        if let menuContainerViewController = parent as? MenuContainerViewController {
            menuContainerViewController.showSideMenu()
        } else if let navController = parent as? UINavigationController,
            let menuContainerViewController = navController.parent as? MenuContainerViewController {
            menuContainerViewController.showSideMenu()
        }
    }
}

