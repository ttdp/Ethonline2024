//
//  MenuViewController.swift
//  Wallet-iOS
//
//  Created by Tian Tong on 2024/8/24.
//

import UIKit

open class MenuViewController: UIViewController {

    public weak var menuContainerViewController: MenuContainerViewController?
    var navigationMenuTransitionDelegate: MenuTransitioningDelegate?

    @objc func handleTap(recognizer: UIGestureRecognizer){
        menuContainerViewController?.hideSideMenu()
    }
}
