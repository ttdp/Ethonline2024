//
//  BalanceDataModel.swift
//  Wallet-iOS
//
//  Created by Tian Tong on 2024/8/24.
//

import Foundation
import Alamofire
import BigInt

protocol BalanceDataModelProtocol {
    func fetchEthereumPrice(completion: @escaping (TokenQuota) -> Void)
    func fetchArbitrumPrice(completion: @escaping (TokenQuota) -> Void)
    func fetchOptimismPrice(completion: @escaping (TokenQuota) -> Void)
    func fetchEthereumMainnet(address: String, completion: @escaping (Double) -> Void)
    func fetchEthereumSepolia(address: String, completion: @escaping (Double) -> Void)
    func fetchArbitrumMainnet(address: String, completion: @escaping (Double) -> Void)
    func fetchArbitrumSepolia(address: String, completion: @escaping (Double) -> Void)
    func fetchOptimismMainnet(address: String, completion: @escaping (Double) -> Void)
    func fetchOptimismSepolia(address: String, completion: @escaping (Double) -> Void)
    func fetchBaseMainnet(address: String, completion: @escaping (Double) -> Void)
    func fetchBaseSepolia(address: String, completion: @escaping (Double) -> Void)
}

class BalanceDataModel: BalanceDataModelProtocol {
    
    func fetchEthereumPrice(completion: @escaping (TokenQuota) -> Void) {
        fetchCurrencyPrice(path: Paths.EthereumPrice, completion: completion)
    }
    
    func fetchArbitrumPrice(completion: @escaping (TokenQuota) -> Void) {
        fetchCurrencyPrice(path: Paths.ArbitrumPrice, completion: completion)
    }
    
    func fetchOptimismPrice(completion: @escaping (TokenQuota) -> Void) {
        fetchCurrencyPrice(path: Paths.OptimismPrice, completion: completion)
    }
    
    private func fetchCurrencyPrice(path: String, completion: @escaping (TokenQuota) -> Void) {
        AF.request(path, method: .get).responseDecodable(of: CoinPaprikaResponse.self) { response in
            switch response.result {
            case .success(let coinPaprikaResponse):
                let currencyName = coinPaprikaResponse.name
                let currencyPrice = coinPaprikaResponse.quotes.USD.price
                let currencyChange = coinPaprikaResponse.quotes.USD.percent_change_24h
                
                completion(TokenQuota(name: currencyName, price: currencyPrice, change_24h: currencyChange))
            case .failure(let error):
                print("Request failed with error: \(error.localizedDescription)")
            }
        }
    }
    
    func fetchEthereumMainnet(address: String, completion: @escaping (Double) -> Void) {
        fetchBalance(path: Paths.EthereumMainnet, address: address, completion: completion)
    }
    
    func fetchEthereumSepolia(address: String, completion: @escaping (Double) -> Void) {
        fetchBalance(path: Paths.EthereumSepolia, address: address, completion: completion)
    }
    
    func fetchArbitrumMainnet(address: String, completion: @escaping (Double) -> Void) {
        fetchBalance(path: Paths.ArbitrumMainnet, address: address, completion: completion)
    }
    
    func fetchArbitrumSepolia(address: String, completion: @escaping (Double) -> Void) {
        fetchBalance(path: Paths.ArbitrumSepolia, address: address, completion: completion)
    }
    
    func fetchOptimismMainnet(address: String, completion: @escaping (Double) -> Void) {
        fetchBalance(path: Paths.OptimismMainnet, address: address, completion: completion)
    }
    
    func fetchOptimismSepolia(address: String, completion: @escaping (Double) -> Void) {
        fetchBalance(path: Paths.OptimismSepolia, address: address, completion: completion)
    }
    
    func fetchBaseMainnet(address: String, completion: @escaping (Double) -> Void) {
        fetchBalance(path: Paths.BaseMainnet, address: address, completion: completion)
    }
    
    func fetchBaseSepolia(address: String, completion: @escaping (Double) -> Void) {
        fetchBalance(path: Paths.BaseSepolia, address: address, completion: completion)
    }
    
    private func fetchBalance(path: String, address: String, completion: @escaping (Double) -> Void) {
        let parameters: [String: Any] = ["id": 1, "jsonrpc": "2.0", "method": "eth_getBalance", "params": [address, "latest"]]
        
        AF.request(path, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseDecodable(of: AlchemyResponse.self) { response in
            switch response.result {
            case .success(let alchemyResponse):
                guard let balanceInWei = alchemyResponse.result else { return }
                let balanceInEther = balanceInWei.weiToEther()
                completion(balanceInEther)
            case .failure(let error):
                print("Request failed with error: \(error.localizedDescription)")
            }
        }
    }
    
}

extension String {
    
    func hexStringToBigInt() -> BigInt? {
        // Remove "0x" if present
        let cleanHexString = self.lowercased().hasPrefix("0x")
        ? String(self.dropFirst(2))
        : self
        
        return BigInt(cleanHexString, radix: 16)
    }
    
    func weiToEther() -> Double {
        guard let balanceInWei = self.hexStringToBigInt() else { return 0 }
        let weiToEtherConversionFactor = BigUInt(10).power(18)
        let balanceInEther = Double(balanceInWei) / Double(weiToEtherConversionFactor)
        return balanceInEther
    }
    
    func removeTrailingZeros() -> String {
        if let number = Double(self) {
            // Convert the number back to a string with no trailing zeros
            let formattedString = String(format: "%g", number)
            return formattedString
        } else {
            return self // Return the original value if conversion fails
        }
    }
    
}

extension Double {
    
    func asUSDollar() -> String {
        // Create a NumberFormatter
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "USD" // Set the currency code to USD
        
        // Format the price
        let formattedPrice = formatter.string(from: NSNumber(value: self))
        
        return formattedPrice ?? "$0.00" // Return formatted price or default to "$0.00"
    }
    
    func asPercentage() -> String {
        // Create a NumberFormatter
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.maximumFractionDigits = 2 // Adjust the number of decimal places if needed
        
        // Format the change
        let formattedChange = formatter.string(from: NSNumber(value: abs(self / 100)))
        
        // Determine the sign
        let sign = self >= 0 ? "+" : "-"
        
        return "\(sign)\(formattedChange ?? "0%")"
    }
    
}
