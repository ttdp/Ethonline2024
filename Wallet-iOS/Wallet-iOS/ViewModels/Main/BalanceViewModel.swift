//
//  BalanceViewModel.swift
//  Wallet-iOS
//
//  Created by Tian Tong on 2024/8/24.
//

import Foundation
import web3swift
import Web3Core
import BigInt

protocol ViewModelProtocol {}

protocol BalanceViewModelCoordinator {}

class BalanceViewModel: ViewModelProtocol {
    
    var coordinator: BalanceViewModelCoordinator?
    
    let dataModel: BalanceDataModelProtocol
    
    init(dataModel: BalanceDataModelProtocol = BalanceDataModel()) {
        self.dataModel = dataModel
    }
    
    func loadBalance(for address: String) {
        guard let address = EthereumAddress(address) else { return }
        
        dataModel.fetchBalance(address: address) { balance in
            print("Balance: \(balance) ETH")
        }
    }
    
    func loadNFTs(for address: String) {
        guard let address = EthereumAddress(address) else { return }
        
        dataModel.fetchNFTs(address: address) { nfts in
            print("NFT: \(nfts.count)")
        }
    }
    
}
