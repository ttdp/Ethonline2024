//
//  AuthCoordinator.swift
//  Wallet-iOS
//
//  Created by TIAN TONG on 8/26/24.
//

import UIKit

class AuthCoordinator: AppCoordinator {
 
    override func start() {
        let viewModel = AuthViewModel()
        viewModel.coordinator = self
        
        let authViewController = AuthViewController(viewModel: viewModel)
        
        let topVC = window.rootViewController?.topViewController()
        topVC?.navigationController?.present(authViewController, animated: true)
    }
    
}

extension AuthCoordinator: AuthViewModelCoordinator {
    
}
