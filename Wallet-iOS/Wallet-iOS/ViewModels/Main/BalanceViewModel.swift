//
//  BalanceViewModel.swift
//  Wallet-iOS
//
//  Created by Tian Tong on 2024/8/24.
//

import UIKit

protocol BalanceViewModelCoordinator {
    func gotoAuth()
    func gotoUser()
}

enum TokenType: String {
    case ethereum
    case arbitrum
    case optimism
    case base
    case ethereumSepholia
    case arbitrumSepholia
    case optimismSepholia
    case baseSepholia
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
    var price: Double?
    var formattedPrice: String?
    var change24Hours: String?
    var balanceInEther: Double?
    var formattedBalance: String?
    var ballanceValue: String?
}

class BalanceViewModel: ViewModelProtocol {
    
    var coordinator: BalanceViewModelCoordinator?
    
    let dataModel: BalanceDataModelProtocol
    
    var balances = [
        CryptoCurrency(type: .ethereum, name: "Ethereum", icon: Images.ETH),
        CryptoCurrency(type: .ethereumSepholia, name: "Eth Sepholia", icon: Images.ETH),
        CryptoCurrency(type: .arbitrum, name: "Arbitrum", icon: Images.ARB),
        CryptoCurrency(type: .arbitrumSepholia, name: "Arb Sepholia", icon: Images.ARB),
        CryptoCurrency(type: .optimism, name: "Optimism", icon: Images.OPT),
        CryptoCurrency(type: .optimismSepholia, name: "Opt Sepholia", icon: Images.OPT),
        CryptoCurrency(type: .base, name: "Base", icon: Images.BASE),
        CryptoCurrency(type: .baseSepholia, name: "Base Sepholia", icon: Images.BASE),
    ]
    
    init(dataModel: BalanceDataModelProtocol = BalanceDataModel()) {
        self.dataModel = dataModel
    }
    
    func getEthereumPrice(completion: @escaping () -> Void) {
        dataModel.fetchEthereumPrice { price in
            self.feedPrice(type: .ethereum, quota: price)
            self.feedPrice(type: .ethereumSepholia, quota: price)
            
            DispatchQueue.main.async { completion() }
        }
    }
    
    func getArbitrumPrice(completion: @escaping () -> Void) {
        dataModel.fetchArbitrumPrice { price in
            self.feedPrice(type: .arbitrum, quota: price)
            self.feedPrice(type: .arbitrumSepholia, quota: price)
            
            DispatchQueue.main.async { completion() }
        }
    }
    
    func getOptimismPrice(completion: @escaping () -> Void) {
        dataModel.fetchOptimismPrice { price in
            self.feedPrice(type: .optimism, quota: price)
            self.feedPrice(type: .optimismSepholia, quota: price)
            
            DispatchQueue.main.async { completion() }
        }
    }
    
    func getEthereumMainnet(for address: String, completion: @escaping () -> Void) {
        dataModel.fetchEthereumMainnet(address: address) { balance in
            self.feedBalance(type: .ethereum, balanceInEther: balance)
            
            DispatchQueue.main.async { completion() }
        }
    }
    
    func getEthereumSepholia(for address: String, completion: @escaping () -> Void) {
        dataModel.fetchEthereumSepolia(address: address) { balance in
            self.feedBalance(type: .ethereumSepholia, balanceInEther: balance)
            DispatchQueue.main.async { completion() }
        }
    }
    
    func getArtibrumMainnet(for address: String, completion: @escaping () -> Void) {
        dataModel.fetchArbitrumMainnet(address: address) { balance in
            self.feedBalance(type: .arbitrum, balanceInEther: balance)
            DispatchQueue.main.async { completion() }
        }
    }
    
    func getArtibrumSepholia(for address: String, completion: @escaping () -> Void) {
        dataModel.fetchArbitrumSepolia(address: address) { balance in
            self.feedBalance(type: .arbitrumSepholia, balanceInEther: balance)
            DispatchQueue.main.async { completion() }
        }
    }
    
    func getOptimismMainnet(for address: String, completion: @escaping () -> Void) {
        dataModel.fetchOptimismMainnet(address: address) { balance in
            self.feedBalance(type: .optimism, balanceInEther: balance)
            DispatchQueue.main.async { completion() }
        }
    }
    
    func getOptimismSepholia(for address: String, completion: @escaping () -> Void) {
        dataModel.fetchOptimismSepolia(address: address) { balance in
            self.feedBalance(type: .optimismSepholia, balanceInEther: balance)
            DispatchQueue.main.async { completion() }
        }
    }
    
    func getBaseMainnet(for address: String, completion: @escaping () -> Void) {
        dataModel.fetchBaseMainnet(address: address) { balance in
            self.feedBalance(type: .base, balanceInEther: balance)
            DispatchQueue.main.async { completion() }
        }
    }
    
    func getBaseSepholia(for address: String, completion: @escaping () -> Void) {
        dataModel.fetchBaseSepolia(address: address) { balance in
            self.feedBalance(type: .baseSepholia, balanceInEther: balance)
            DispatchQueue.main.async { completion() }
        }
    }
    
    private func feedPrice(type: TokenType, quota: TokenQuota) {
        for (index, balance) in balances.enumerated() {
            if balance.type == type {
                var _balance = balance
                _balance.price = quota.price
                _balance.formattedPrice = quota.price.asUSDollar()
                _balance.change24Hours = quota.change_24h.asPercentage()
                if let balanceInEther = _balance.balanceInEther {
                    let totalValue = quota.price * balanceInEther
                    _balance.ballanceValue = totalValue.asUSDollar()
                }
                balances[index] = _balance
            }
        }
    }
    
    private func feedBalance(type: TokenType, balanceInEther: Double) {
        for (index, balance) in balances.enumerated() {
            if balance.type == type {
                var _balance = balance
                _balance.balanceInEther = balanceInEther
                _balance.formattedBalance = String(format: "%.4f", balanceInEther).removeTrailingZeros() + " ETH"
                if let price = _balance.price {
                    let totalValue = price * balanceInEther
                    _balance.ballanceValue = totalValue.asUSDollar()
                }
                balances[index] = _balance
            }
        }
    }
    
    func showAuth() {
        coordinator?.gotoAuth()
    }
    
    func showUser(completion: (Bool) -> Void) {
        guard AuthManager.shared.user != nil else {
            completion(false)
            return
        }
        
        coordinator?.gotoUser()
    }
    
}
