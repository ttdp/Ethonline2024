//
//  BalanceViewModel.swift
//  Wallet-iOS
//
//  Created by Tian Tong on 2024/8/24.
//

import UIKit
import web3swift
import Web3Core
import BigInt

protocol ViewModelProtocol {}

protocol BalanceViewModelCoordinator {}

enum TokenType: String {
    case ethereum
    case arbitrum
    case optimism
    case ethereumSepholia
    case arbitrumSepholia
    case optimismSepholia
}

struct CryptoCurrency {
    
    init(type: TokenType, name: String, icon: UIImage) {
        self.type = type
        self.name = name
        self.icon = icon
    }
    
    let type: TokenType
    let name: String
    let icon: UIImage
    var price: String?
    var change: String?
    var balance: String?
    var value: String?
}

class BalanceViewModel: ViewModelProtocol {
    
    var coordinator: BalanceViewModelCoordinator?
    
    let dataModel: BalanceDataModelProtocol
    
    let balances = [
        CryptoCurrency(type: .ethereum, name: "Ethereum", icon: Images.ETH),
        CryptoCurrency(type: .ethereumSepholia, name: "Ethereum Sepholia", icon: Images.ETH),
        CryptoCurrency(type: .arbitrum, name: "Arbitrum", icon: Images.ARB),
        CryptoCurrency(type: .arbitrumSepholia, name: "Arbitrum Sepholia", icon: Images.ARB),
        CryptoCurrency(type: .optimism, name: "Optimism", icon: Images.OPT),
        CryptoCurrency(type: .optimismSepholia, name: "Optimism Sepholia", icon: Images.OPT),
    ]
    
    init(dataModel: BalanceDataModelProtocol = BalanceDataModel()) {
        self.dataModel = dataModel
    }
    
    func getEthereumPrice() {
        dataModel.fetchEthereumPrice { currency in
            print("Currency Name: \(currency.name), Price: \(currency.price), Change: \(currency.change_15m)")
        }
    }
    
    func getArbitrumPrice() {
        dataModel.fetchArbitrumPrice { currency in
            print("Currency Name: \(currency.name), Price: \(currency.price), Change: \(currency.change_15m)")
        }
    }
    
    func getOptimismPrice() {
        dataModel.fetchOptimismPrice { currency in
            print("Currency Name: \(currency.name), Price: \(currency.price), Change: \(currency.change_15m)")
        }
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
