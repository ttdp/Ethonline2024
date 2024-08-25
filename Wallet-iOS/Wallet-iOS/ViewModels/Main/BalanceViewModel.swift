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
    
    func getEthereumMainnet(for address: String) {
        dataModel.fetchEthereumMainnet(address: address) { balance in
            print("Ethereum Mainnet: \(balance) ETH")
        }
    }
    
    func getEthereumSepholia(for address: String) {
        dataModel.fetchEthereumSepolia(address: address) { balance in
            print("Ethereum Sepholia: \(balance) ETH")
        }
    }
    
    func getArtibrumMainnet(for address: String) {
        dataModel.fetchArbitrumMainnet(address: address) { balance in
            print("Arbitrum Mainnet: \(balance) ETH")
        }
    }
    
    func getArtibrumSepholia(for address: String) {
        dataModel.fetchArbitrumSepolia(address: address) { balance in
            print("Arbitrum Sepholia: \(balance) ETH")
        }
    }
    
    func getOptimismMainnet(for address: String) {
        dataModel.fetchOptimismMainnet(address: address) { balance in
            print("Optimism Mainnet: \(balance) ETH")
        }
    }
    
    func getOptimismSepholia(for address: String) {
        dataModel.fetchOptimismSepolia(address: address) { balance in
            print("Optimism Sepholia: \(balance) ETH")
        }
    }
    
    func getNFTs(for address: String) {
        dataModel.fetchNFTs(address: address) { nfts in
            print("NFT: \(nfts.count)")
        }
    }
    
}
