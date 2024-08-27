//
//  HostCoordinator.swift
//  Wallet-iOS
//
//  Created by Tian Tong on 2024/8/24.
//

import UIKit

class HostCoordinator: AppCoordinator {
    
    var hostViewController: HostViewController?
    
    var sideMenuCoordinator: SideMenuCoordinator?
    var balanceCoordinator: BalanceCoordinator?
    var nftCoordinator: NFTCoordinator?
    
    override func start() {
        let viewModel = HostViewModel()
        viewModel.coordinator = self
        
        hostViewController = HostViewController()
        hostViewController?.viewModel = viewModel
        
        sideMenuCoordinator = SideMenuCoordinator(window: window)
        sideMenuCoordinator?.start()
        balanceCoordinator = BalanceCoordinator(window: window)
        balanceCoordinator?.start()
        nftCoordinator = NFTCoordinator(window: window)
        nftCoordinator?.start()
        
        hostViewController?.sideMenuViewController = sideMenuCoordinator?.sideMenuViewController
        hostViewController?.balanceViewController = balanceCoordinator?.balanceViewController
        hostViewController?.nftViewController = nftCoordinator?.nftViewController
       
        guard let host = hostViewController else { return }
        
        window.rootViewController = UINavigationController(rootViewController: host)
        window.makeKeyAndVisible()
    }
    
}

extension HostCoordinator: HostViewModelCoordinator {
    
}
