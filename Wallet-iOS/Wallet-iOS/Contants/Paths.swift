//
//  Paths.swift
//  Wallet-iOS
//
//  Created by TIAN TONG on 8/24/24.
//

import Foundation

struct Paths {

    private init() {}
    
    static let AlchemyAPIKEY = "6xw9VRfg0oDcxD3bWoe6fJF3pehFWqYy"

    static let EthereumMainnet = "https://eth-mainnet.g.alchemy.com/v2/\(AlchemyAPIKEY)"
    static let EthereumSepolia = "https://eth-sepolia.g.alchemy.com/v2/\(AlchemyAPIKEY)"
    
    static let ArbitrumMainnet = "https://arb-mainnet.g.alchemy.com/v2/\(AlchemyAPIKEY)"
    static let ArbitrumSepolia = "https://arb-sepolia.g.alchemy.com/v2/\(AlchemyAPIKEY)"
    
    static let OptimismMainnet = "https://opt-mainnet.g.alchemy.com/v2/\(AlchemyAPIKEY)"
    static let OptimismSepolia = "https://opt-sepolia.g.alchemy.com/v2/\(AlchemyAPIKEY)"
    
    static let BaseMainnet = "https://base-mainnet.g.alchemy.com/v2/\(AlchemyAPIKEY)"
    static let BaseSepolia = "https://base-sepolia.g.alchemy.com/v2/\(AlchemyAPIKEY)"
    
    static let NFT = "https://eth-mainnet.alchemyapi.io/v2/\(AlchemyAPIKEY)/getNFTsForOwner"
    
    static let EthereumPrice = "https://api.coinpaprika.com/v1/tickers/eth-ethereum"
    static let ArbitrumPrice = "https://api.coinpaprika.com/v1/tickers/arb-arbitrum"
    static let OptimismPrice = "https://api.coinpaprika.com/v1/tickers/op-optimism"
    
    static let nft = "https://eth-mainnet.alchemyapi.io/v2/\(AlchemyAPIKEY)/getNFTsForOwner?owner="
    
}
