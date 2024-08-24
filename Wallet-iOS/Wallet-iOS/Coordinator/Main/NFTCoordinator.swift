//
//  NFTCoordinator.swift
//  Wallet-iOS
//
//  Created by Tian Tong on 2024/8/24.
//

import UIKit

class NFTCoordinator: AppCoordinator {
    
    var nftViewController: NFTViewController?
 
    override func start() {
        let viewModel = NFTViewModel()
        viewModel.coordinator = self
        
        nftViewController = NFTViewController(viewModel: viewModel)
        guard let nft = nftViewController else { return }
        
        let topVC = window.rootViewController?.topViewController()
        topVC?.navigationController?.pushViewController(nft, animated: true)
    }
    
}

extension NFTCoordinator: NFTViewModelCoordinator {
    
}
