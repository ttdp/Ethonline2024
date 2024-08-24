//
//  TxCoordinator.swift
//  Wallet-iOS
//
//  Created by Tian Tong on 2024/8/24.
//

import UIKit

class TxCoordinator: AppCoordinator {
    
    var txViewController: TxViewController?
 
    override func start() {
        let viewModel = TxViewModel()
        viewModel.coordinator = self
        
        txViewController = TxViewController(viewModel: viewModel)
        guard let tx = txViewController else { return }
        
        let topVC = window.rootViewController?.topViewController()
        topVC?.navigationController?.pushViewController(tx, animated: true)
    }
    
}

extension TxCoordinator: TxViewModelCoordinator {
    
}
