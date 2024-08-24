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
    var txCoordinator: TxCoordinator?
    var settingCoordinator: SettingCoordinator?
    
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
        txCoordinator = TxCoordinator(window: window)
        txCoordinator?.start()
        settingCoordinator = SettingCoordinator(window: window)
        settingCoordinator?.start()
        
        hostViewController?.sideMenuViewController = sideMenuCoordinator?.sideMenuViewController
        hostViewController?.balanceViewController = balanceCoordinator?.balanceViewController
        hostViewController?.nftViewController = nftCoordinator?.nftViewController
        hostViewController?.txViewController = txCoordinator?.txViewController
        hostViewController?.settingViewController = settingCoordinator?.settingViewController
        
        guard let host = hostViewController else { return }
        
        window.rootViewController = UINavigationController(rootViewController: host)
        window.makeKeyAndVisible()
    }
    
}

extension HostCoordinator: HostViewModelCoordinator {
    
}
