//
//  BalanceCoordinator.swift
//  Wallet-iOS
//
//  Created by Tian Tong on 2024/8/24.
//

import UIKit

class BalanceCoordinator: AppCoordinator {
    
    var balanceViewController: BalanceViewController?

    override func start() {
        let viewModel = BalanceViewModel()
        viewModel.coordinator = self
        
        balanceViewController = BalanceViewController(viewModel: viewModel)
        
        guard let balance = balanceViewController else { return }
        let rootNavigation = UINavigationController(rootViewController: balance)
        
        window.rootViewController = rootNavigation
        window.makeKeyAndVisible()
    }
    
}

extension BalanceCoordinator: BalanceViewModelCoordinator {
    
    func gotoAuth() {
        AuthCoordinator(window: window).start()
    }
    
    func gotoUser() {
        UserCoordinator(window: window).start()
    }
    
}
