//
//  UserCoordinator.swift
//  Wallet-iOS
//
//  Created by TIAN TONG on 8/26/24.
//

import UIKit

class UserCoordinator: AppCoordinator {

    override func start() {
        let viewModel = UserViewModel()
        viewModel.coordinator = self
        
        let userViewController = UserViewController(viewModel: viewModel)
        
        let topVC = window.rootViewController?.topViewController()
        topVC?.navigationController?.present(userViewController, animated: true)
    }
    
}

extension UserCoordinator: UserViewModelCoordinator {}
