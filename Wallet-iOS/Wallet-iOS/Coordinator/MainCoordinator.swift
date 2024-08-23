//
//  MainCoordinator.swift
//  Wallet-iOS
//
//  Created by Tian Tong on 2024/8/24.
//

import UIKit

class MainCoordinator: AppCoordinator {

    override func start() {
        let viewModel = MainViewModel()
        viewModel.coordinator = self
        
        let mainVC = MainViewController(viewModel: viewModel)
        window.rootViewController = UINavigationController(rootViewController: mainVC)
        window.makeKeyAndVisible()
    }
    
}

extension MainCoordinator: MainViewModelCoordinator {
    
}
