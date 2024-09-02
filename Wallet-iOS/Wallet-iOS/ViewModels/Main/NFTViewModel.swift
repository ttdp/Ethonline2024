//
//  NFTViewModel.swift
//  Wallet-iOS
//
//  Created by Tian Tong on 2024/8/24.
//

import Foundation

protocol NFTViewModelCoordinator {
    
}

class NFTViewModel: ViewModelProtocol {
    
    var coordinator: NFTViewModelCoordinator?
    
    let dataModel: NFTDataModelProtocol
    
    var nfts: [NFT] = []
    
    init(dataModel: NFTDataModelProtocol = NFTDataModel()) {
        self.dataModel = dataModel
    }
    
    func getNFTs(for address: String, completion: @escaping () -> Void) {
        dataModel.fetchNFTs(address: address) { nfts in
            self.nfts = nfts
            completion()
        }
    }
    
}
