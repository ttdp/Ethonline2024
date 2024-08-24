//
//  SideMenuCoordinator.swift
//  Wallet-iOS
//
//  Created by Tian Tong on 2024/8/24.
//

import UIKit

class SideMenuCoordinator: AppCoordinator {
    
    var sideMenuViewController: SideMenuViewController?
    
    override func start() {
        let viewModel = SideMenuViewModel()
        viewModel.coordinator = self
        
        sideMenuViewController = SideMenuViewController()
        sideMenuViewController?.viewModel = viewModel
    }
    
}

extension SideMenuCoordinator: SideMenuViewModelCoordinator {
    
}
